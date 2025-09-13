import 'dart:developer';

import 'package:flutter/rendering.dart';
import 'package:noviindus/models/response_models/branch_list_response.dart';
import 'package:noviindus/models/response_models/general_response.dart';
import 'package:noviindus/models/response_models/login_response.dart';
import 'package:noviindus/models/response_models/patient_list_response.dart';
import 'package:noviindus/models/response_models/treatment_list_response.dart';
import 'package:noviindus/services/api_service/api_urls.dart';
import 'package:noviindus/services/api_service/api_viewmodel.dart';

class ApiRepository {
  ApiViewModel? _apiViewModel;

  ApiViewModel? get apiViewModel => _apiViewModel;

  ApiRepository() {
    _apiViewModel = ApiViewModel();
  }

  Future<LoginResponse?> login({Map<String, dynamic>? data}) async {
    return _apiViewModel!.login<LoginResponse>(
      apiUrl: ApiUrls.klogin,
      data: data,
    );
  }

  //patient list
  Future<PatientListResponse?> getPatientList() async {
    return _apiViewModel!.get<PatientListResponse>(
      apiUrl: ApiUrls.kPatientList,
    );
  }

  //get treatement list
  Future<TreatmentListResponse?> getTreatmentList() async {
    return _apiViewModel!.get<TreatmentListResponse>(
      apiUrl: ApiUrls.kTreatmentList,
    );
  }

  //get branch list
  Future<BranchListResponse?> getBranchList() async {
    return _apiViewModel!.get<BranchListResponse>(apiUrl: ApiUrls.kBranchList);
  }

  //post patient detail
  Future<GeneralResponse?> registerPatient({Map<String, dynamic>? data}) async {
    debugPrint("request: ${data.toString()}");
    return _apiViewModel!.post<GeneralResponse>(
      apiUrl: ApiUrls.kPatientUpdate,
      data: data,
    );
  }
}
