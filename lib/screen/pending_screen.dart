import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../Model/AccountM/send_login_model.dart';
import '../Model/FeeM/save_fee_model.dart';
import '../ViewModel/AccountVM/student_details_view_model.dart';
import '../ViewModel/FeeVM/get_student_fee_view_model.dart';
import '../ViewModel/FeeVM/save_fee_view_model.dart';
import 'widgets/pending_shimmer.dart';
import 'widgets/pending_widgets.dart';

class PendingScreen extends StatefulWidget {
  final Student? student;
  const PendingScreen({super.key, this.student}); // ✅ Removed student parameter

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  // ---------------- CONTROLLERS ----------------
  late TextEditingController admissionNoController;
  late TextEditingController nameController;
  late TextEditingController fatherNameController;
  late TextEditingController classController;
  late TextEditingController sectionController;
  late TextEditingController dateController;
  late TextEditingController feePayableController;
  late TextEditingController feePaidController;
  late TextEditingController balanceController;

  String selectedMonth = "Upto April 2025";
  final List<String> monthsList = [
    "Upto April 2025", "Upto May 2025", "Upto June 2025", "Upto July 2025",
    "Upto August 2025", "Upto September 2025", "Upto October 2025", "Upto November 2025",
    "Upto December 2025", "Upto January 2026", "Upto February 2026", "Upto March 2026",
  ];

  @override
  void initState() {
    super.initState();
    _initControllers();

    // ✅ Fetch everything based on local storage ID
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final detailVM = context.read<StudentDetailViewModel>();
      final feeVM = context.read<StudentFeeViewModel>();

      // 1. Fetch Detailed Student Info
      await detailVM.getStudentDetails();

      if (detailVM.student != null) {
        // 2. Map Info API data to controllers
        _updateUI(detailVM.student!);

        // 3. Fetch Fees using the Admission No obtained from Info API
        await feeVM.getFees(detailVM.student!.admissionNo);
      }
    });
  }

  void _initControllers() {
    admissionNoController = TextEditingController();
    nameController = TextEditingController();
    fatherNameController = TextEditingController();
    classController = TextEditingController();
    sectionController = TextEditingController();
    dateController = TextEditingController(text: DateFormat('dd-MM-yyyy').format(DateTime.now()));
    feePayableController = TextEditingController();
    feePaidController = TextEditingController(text: "0");
    balanceController = TextEditingController();

    feePaidController.addListener(_calculateBalance);
  }

  void _updateUI(dynamic student) {
    setState(() {
      admissionNoController.text = student.admissionNo.toString();
      nameController.text = student.studentName;
      fatherNameController.text = student.fatherName;
      classController.text = student.className;
      sectionController.text = student.sectionName;
    });
  }

  void _calculateBalance() {
    double payable = double.tryParse(feePayableController.text) ?? 0.0;
    double paid = double.tryParse(feePaidController.text) ?? 0.0;
    setState(() {
      balanceController.text = (payable - paid).toStringAsFixed(2);
    });
  }

  int _getMonthNumber(String monthStr) {
    Map<String, int> monthMap = {
      "April": 1, "May": 2, "June": 3, "July": 4, "August": 5, "September": 6,
      "October": 7, "November": 8, "December": 9, "January": 10, "February": 11, "March": 12,
    };
    for (var month in monthMap.keys) {
      if (monthStr.contains(month)) return monthMap[month]!;
    }
    return 1;
  }

  void _handleSave() async {
    final feeVM = context.read<StudentFeeViewModel>();
    final detailVM = context.read<StudentDetailViewModel>();
    final saveVM = context.read<SaveFeeViewModel>();

    if (detailVM.student == null || feeVM.feeList.isEmpty) return;

    List<FeeDetailItem> details = feeVM.feeList.map((f) {
      return FeeDetailItem(
        feeHeadId: f.feeHeadId,
        originalFee: f.feeAmount,
        actualFee: f.feeAmount,
      );
    }).toList();

    SaveFeeRequest request = SaveFeeRequest(
      studentId: detailVM.student!.studentId,
      feePaid: double.tryParse(feePaidController.text) ?? 0.0,
      balance: double.tryParse(balanceController.text) ?? 0.0,
      feePayable: feeVM.totalPayable,
      feeDetails: details,
      selectedMonths: [
        SelectedMonthItem(
          feeMonth: _getMonthNumber(selectedMonth),
          feeYear: 2026,
        )
      ],
    );

    bool success = await saveVM.postFee(request);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Fee Collected Successfully!"), backgroundColor: Colors.green),
      );
      // Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final feeVM = context.watch<StudentFeeViewModel>();
    final detailVM = context.watch<StudentDetailViewModel>();

    // Update fee total when loading finishes
    if (!feeVM.isLoading && feeVM.feeList.isNotEmpty) {
      feePayableController.text = feeVM.totalPayable.toString();
      _calculateBalance();
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("Fees Collection",
            style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFFAB47BC), Color(0xFF42A5F5)]),
          ),
        ),
      ),
      body: (detailVM.isLoading)
          ? const PendingShimmer()
          : SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownButtonHideUnderline(
                    child: DropdownButton2<String>(
                      isExpanded: true,
                      value: selectedMonth,
                      items: monthsList.map((item) => DropdownMenuItem(
                        value: item,
                        child: Text(item, style: GoogleFonts.poppins(fontSize: 14)),
                      )).toList(),
                      onChanged: (value) => setState(() => selectedMonth = value!),
                    ),
                  ),
                  const SizedBox(height: 12),
                  PendingWidgets.inputRow("Admission No", "Admission No", controller: admissionNoController, readOnly: true),
                  PendingWidgets.inputRow("Date", "Date", controller: dateController, readOnly: true),
                  const SizedBox(height: 20),
                  _sectionLabel("Student Name"),
                  PendingWidgets.textField("Student Name", controller: nameController, readOnly: true),
                  const SizedBox(height: 14),
                  _sectionLabel("Father's Name"),
                  PendingWidgets.textField("Father's Name", controller: fatherNameController, readOnly: true),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: _buildInfoColumn("Class", classController)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildInfoColumn("Section", sectionController)),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text("Fee Details", style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 10),
                  _buildTableHeader(),

                  if (feeVM.isLoading)
                    _buildShimmerLoading()
                  else if (feeVM.feeList.isEmpty)
                    const Center(child: Padding(padding: EdgeInsets.all(20), child: Text("No fee details found.")))
                  else
                    ...feeVM.feeList.map((fee) => PendingWidgets.feeRow(
                      fee.feeName,
                      fee.feeAmount.toString(),
                      fee.feeAmount.toString(),
                    )),

                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(child: PendingWidgets.inputField("Total Payable", "", filled: true, controller: feePayableController)),
                      const SizedBox(width: 12),
                    ],
                  ),
                  const SizedBox(height: 14),
                  _payButton(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _payButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Consumer<SaveFeeViewModel>(
        builder: (context, saveVM, _) {
          return SizedBox(
            height: 42,
            width: 100,
            child: ElevatedButton(
              onPressed: (saveVM.isSaving || context.read<StudentFeeViewModel>().feeList.isEmpty) ? null : _handleSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              ),
              child: saveVM.isSaving
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                  : Text("Pay", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w500)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoColumn(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel(label),
        const SizedBox(height: 6),
        // ✅ Pass true here
        PendingWidgets.textField(label, controller: controller, readOnly: true),
      ],
    );
  }

  Widget _sectionLabel(String text) => Text(text, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w500));

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      color: Colors.grey.shade300,
      child: Row(
        children: [
          Expanded(flex: 3, child: _headerText("Fees Head")),
          Expanded(flex: 2, child: _headerText("Fees")),
          Expanded(flex: 2, child: _headerText("Actual")),
        ],
      ),
    );
  }

  Widget _headerText(String text) => Text(text, style: GoogleFonts.poppins(fontSize: 13, fontWeight: FontWeight.w600));

  Widget _buildShimmerLoading() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: List.generate(3, (index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          child: Row(
            children: [
              Expanded(flex: 3, child: Container(height: 14, color: Colors.white)),
              const SizedBox(width: 20),
              Expanded(flex: 2, child: Container(height: 14, color: Colors.white)),
              const SizedBox(width: 20),
              Expanded(flex: 2, child: Container(height: 14, color: Colors.white)),
            ],
          ),
        )),
      ),
    );
  }

  @override
  void dispose() {
    feePaidController.removeListener(_calculateBalance);
    admissionNoController.dispose();
    nameController.dispose();
    fatherNameController.dispose();
    classController.dispose();
    sectionController.dispose();
    dateController.dispose();
    feePayableController.dispose();
    feePaidController.dispose();
    balanceController.dispose();
    super.dispose();
  }
}