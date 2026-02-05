import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widget/app_button.dart';

class ComplaintScreen extends StatefulWidget {
  const ComplaintScreen({super.key});

  @override
  State<ComplaintScreen> createState() => _ComplaintScreenState();
}

class _ComplaintScreenState extends State<ComplaintScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController subjectController = TextEditingController();
  final TextEditingController complaintController = TextEditingController();

  String selectedCategory = "General";

  final List<String> categories = [
    "General",
    "Teacher",
    "Fees",
    "Other"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Complaint",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,),
        ),
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFAB47BC), Color(0xFF42A5F5)],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              //CATEGORY DROPDOWN
              Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonFormField<String>(
                    value: selectedCategory,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "Complaint Category",
                    ),
                    items: categories
                        .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ),
                    )
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedCategory = value!;
                      });
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              //SUBJECT
              TextFormField(
                controller: subjectController,
                decoration: InputDecoration(
                  labelText: "Subject",
                  hintText: "Enter complaint subject",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Subject is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // COMPLAINT MESSAGE
              TextFormField(
                controller: complaintController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: "Complaint",
                  hintText: "Write your complaint here...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Complaint cannot be empty";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              AppButton(title2: "Submit complaint", onPress1:() {
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Complaint submitted successfully"),
                    ),
                  );
                }
              },)
            ],
          ),
        ),
      ),
    );
  }
}
