import 'package:flutter/material.dart';
import 'package:noviindus/services/api_service/api_repository.dart';

class PatientViewmodel extends ChangeNotifier {
  final ApiRepository apiRepository;

  PatientViewmodel({required this.apiRepository});

  String? _selectedOption;

  String? get selectedOption => _selectedOption;

  void selectOption(String option) {
    _selectedOption = option;
    notifyListeners();
  }
}
