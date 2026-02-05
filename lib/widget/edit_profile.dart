import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../ViewModel/AccountVM/student_details_view_model.dart';
import '../screen/widgets/edit_profile_shimmer.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController studentName = TextEditingController();
  final TextEditingController academicYear = TextEditingController();
  final TextEditingController campus = TextEditingController();
  final TextEditingController className = TextEditingController();
  final TextEditingController grNumber = TextEditingController();
  final TextEditingController house = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController pickupTime = TextEditingController();
  final TextEditingController dropTime = TextEditingController();
  final TextEditingController fatherName = TextEditingController();
  final TextEditingController fatherPhone = TextEditingController();
  final TextEditingController fatherEmail = TextEditingController();
  final TextEditingController motherName = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ✅ Trigger API Call
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StudentDetailViewModel>().getStudentDetails().then((_) {
        _fillControllers();
      });
    });
  }

  void _fillControllers() {
    final student = context.read<StudentDetailViewModel>().student;
    if (student != null) {
      setState(() {
        studentName.text = student.studentName;
        academicYear.text = student.sessionName;
        campus.text = student.schoolName;
        className.text = "${student.className} ${student.sectionName}";
        grNumber.text = student.admissionNo.toString();
        address.text = student.address;
        pickupTime.text = student.pickupTime;
        dropTime.text = student.dropTime;
        fatherName.text = student.fatherName;
        fatherPhone.text = student.mobile;
        fatherEmail.text = student.email;
        motherName.text = student.motherName;
        house.text = "-";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text("Student Profile", style: GoogleFonts.poppins(color: Colors.white, fontWeight: FontWeight.w600)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFFAB47BC), Color(0xFF42A5F5)]),
          ),
        ),
      ),
      body: Consumer<StudentDetailViewModel>(
        builder: (context, vm, child) {
          if (vm.isLoading) {
            return const EditProfileShimmer();
          }
          if (vm.student == null) return const Center(child: Text("No Profile Data Found"));

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _profileHeader(),
                  const SizedBox(height: 20),
                  _textField("Student Name", studentName),
                  _textField("Academic Year", academicYear),
                  _textField("Campus", campus),
                  _textField("Class", className),
                  Row(
                    children: [
                      Expanded(child: _textField("Pickup", pickupTime)),
                      const SizedBox(width: 10),
                      Expanded(child: _textField("Drop", dropTime)),
                    ],
                  ),
                  _textField("GR Number", grNumber),
                  _textField("Address", address, maxLines: 2),
                  const Divider(height: 40),
                  _parentInfo(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _profileHeader() {
    return Container(
      height: 90, width: 90,
      decoration: const BoxDecoration(shape: BoxShape.circle, gradient: LinearGradient(colors: [Color(0xFFAB47BC), Color(0xFF42A5F5)])),
      child: const Icon(Icons.person, size: 40, color: Colors.white),
    );
  }

  Widget _parentInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Parent Details", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        const SizedBox(height: 10),
        _textField("Father Name", fatherName),
        _textField("Contact", fatherPhone),
        _textField("Mother Name", motherName),
      ],
    );
  }

  Widget _textField(String label, TextEditingController controller, {int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: GoogleFonts.poppins(fontSize: 13),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}