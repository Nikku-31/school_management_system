import 'package:flutter/material.dart';

import '../../AppManager/Services/FeeS/get_student_fee_service.dart';
import '../../Model/FeeM/get_student_fee_model.dart';

class StudentFeeViewModel extends ChangeNotifier {
  bool isLoading = false;
  List<FeeData> feeList = [];
  double totalPayable = 0.0;

  Future<void> getFees(int admissionNo) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await StudentFeeService.fetchFees(admissionNo);
      feeList = response.data;

      // Calculate Total
      totalPayable = feeList.fold(0, (sum, item) => sum + item.feeAmount);
    } catch (e) {
      debugPrint("Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}