import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeTable extends StatelessWidget {
  const TimeTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Time Table",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFAB47BC), Color(0xFF42A5F5),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card
               SizedBox(
                 width: double.infinity,
                 child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Monday",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                          ),),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              Expanded(child: Text("9:00 AM - Math",
                                style: GoogleFonts.poppins(),
                              ),),
                              Expanded(child: Text("10:00 AM - English",
                                style: GoogleFonts.poppins(),))
                            ],
                          ),
                          const SizedBox(height: 8,),
                          Row(
                            children: [
                              Expanded(child: Text("11:00 AM - Hindi",
                                style: GoogleFonts.poppins(),
                              ),),
                              Expanded(child: Text("12:00 AM - Science",
                                style: GoogleFonts.poppins(),))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
               ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Tuesday",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                          ),),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            Expanded(child: Text("9:00 AM - Math",
                              style: GoogleFonts.poppins(),
                            ),),
                            Expanded(child: Text("10:00 AM - English",
                              style: GoogleFonts.poppins(),))
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            Expanded(child: Text("11:00 AM - Hindi",
                              style: GoogleFonts.poppins(),
                            ),),
                            Expanded(child: Text("12:00 AM - Science",
                              style: GoogleFonts.poppins(),))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Wednesday",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                          ),),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            Expanded(child: Text("9:00 AM - Math",
                              style: GoogleFonts.poppins(),
                            ),),
                            Expanded(child: Text("10:00 AM - English",
                              style: GoogleFonts.poppins(),))
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            Expanded(child: Text("11:00 AM - Hindi",
                              style: GoogleFonts.poppins(),
                            ),),
                            Expanded(child: Text("12:00 AM - Science",
                              style: GoogleFonts.poppins(),))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Thursday",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                          ),),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            Expanded(child: Text("9:00 AM - Math",
                              style: GoogleFonts.poppins(),
                            ),),
                            Expanded(child: Text("10:00 AM - English",
                              style: GoogleFonts.poppins(),))
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            Expanded(child: Text("11:00 AM - Hindi",
                              style: GoogleFonts.poppins(),
                            ),),
                            Expanded(child: Text("12:00 AM - Science",
                              style: GoogleFonts.poppins(),))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Friday",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                          ),),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            Expanded(child: Text("9:00 AM - Math",
                              style: GoogleFonts.poppins(),
                            ),),
                            Expanded(child: Text("10:00 AM - English",
                              style: GoogleFonts.poppins(),))
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            Expanded(child: Text("11:00 AM - Hindi",
                              style: GoogleFonts.poppins(),
                            ),),
                            Expanded(child: Text("12:00 AM - Science",
                              style: GoogleFonts.poppins(),))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Saturday",
                          style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600
                          ),),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            Expanded(child: Text("9:00 AM - Math",
                              style: GoogleFonts.poppins(),
                            ),),
                            Expanded(child: Text("10:00 AM - English",
                              style: GoogleFonts.poppins(),))
                          ],
                        ),
                        const SizedBox(height: 8,),
                        Row(
                          children: [
                            Expanded(child: Text("11:00 AM - Hindi",
                              style: GoogleFonts.poppins(),
                            ),),
                            Expanded(child: Text("12:00 AM - Science",
                              style: GoogleFonts.poppins(),))
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
