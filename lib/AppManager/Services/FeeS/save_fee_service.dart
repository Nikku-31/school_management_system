import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../Model/FeeM/save_fee_model.dart';

class SaveFeeService {
  static Future<bool> saveFee(SaveFeeRequest request) async {
    final url = Uri.parse('https://eschool.my-erp.in/api/FeeApi/SaveFeeCollection');
    final requestBody = jsonEncode(request.toJson());

    // --- Terminal Debugging: Request ---
    debugPrint("==================== API REQUEST ====================");
    debugPrint("URI: $url");
    debugPrint("METHOD: POST");
    debugPrint("PAYLOAD: $requestBody");
    debugPrint("====================================================");

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'accept': '*/*',
        },
        body: requestBody,
      );

      // --- Terminal Debugging: Response ---
      debugPrint("==================== API RESPONSE ====================");
      debugPrint("STATUS CODE: ${response.statusCode}");
      debugPrint("BODY: ${response.body}");
      debugPrint("======================================================");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['success'] ?? false;
      } else {
        debugPrint("Error: Server returned status code ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("==================== API ERROR ====================");
      debugPrint("EXCEPTION: $e");
      debugPrint("===================================================");
      return false;
    }
  }
}