import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class DepositeScreen extends StatelessWidget {
  const DepositeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          "Deposited Fees",
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
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFAB47BC), Color(0xFF42A5F5),
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // TOTAL DEPOSITED FEES
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF66BB6A), Color(0xFF43A047),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Total Deposited Fees",
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "₹ 25,000",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // DEPOSITED FEES LIST
            Expanded(
              child: ListView(
                children: [
                  depositedFeesCard(
                    title: "Tuition Fees",
                    amount: "₹ 15,000",
                    date: "10 Feb 2025",
                    mode: "Cash",
                  ),
                  depositedFeesCard(
                    title: "Transport Fees",
                    amount: "₹ 5,000",
                    date: "10 Feb 2025",
                    mode: "Cash",
                  ),
                  depositedFeesCard(
                    title: "Library Fees",
                    amount: "₹ 5,000",
                    date: "10 Feb 2025",
                    mode: "Cash",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  //DEPOSITED FEES CARD
  Widget depositedFeesCard({
    required String title,
    required String amount,
    required String date,
    required String mode,
  }) {
    return Card(
      color: Colors.white,
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  amount,
                  style: GoogleFonts.poppins(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  date,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              "Payment Mode: $mode",
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}