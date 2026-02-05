import 'dart:convert';
import 'package:flutter/material.dart'; // Added for debugPrint
import 'package:http/http.dart' as http;
import '../../../Model/FeeM/get_student_fee_model.dart';

class StudentFeeService {
  static Future<StudentFeeResponse> fetchFees(int admissionNo) async {
    final url = Uri.parse(
        "https://eschool.my-erp.in/api/FeeApi/GetStudentFeeForMonthYear?admissionNo=$admissionNo&month=0&financialYear=2025-2026");

    // Print the URI
    debugPrint("--- API CALL ---");
    debugPrint("URL: $url");

    final response = await http.get(url);

    // Print the Response
    debugPrint("STATUS CODE: ${response.statusCode}");
    debugPrint("RESPONSE BODY: ${response.body}");
    debugPrint("-----------------");

    if (response.statusCode == 200) {
      return StudentFeeResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load fees: ${response.statusCode}');
    }
  }
}