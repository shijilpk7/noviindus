import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:convert';
import 'dart:developer' as dev;

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noviindus/services/api_service/api_viewmodel.dart';

class ApiRepository {
  ApiViewModel? _apiViewModel;

  ApiViewModel? get apiViewModel => _apiViewModel;

  ApiRepository() {
    _apiViewModel = ApiViewModel();
  }

  // Future<LoginResponse?> login({Map<String, dynamic>? data}) async {
  //   return _apiViewModel!.login<LoginResponse>(
  //     apiUrl: ApiUrls.klogin,
  //     data: data,
  //   );
  // }

  // Future<SentOtpResponse?> sentOTP({Map<String, dynamic>? data}) async {
  //   return _apiViewModel!.post<SentOtpResponse>(
  //     apiUrl: ApiUrls.klogin,
  //     data: data,
  //   );
  // }

  // Future<DelegateListResponse?> getDelegateList({
  //   Map<String, dynamic>? param,
  // }) async {
  //   return _apiViewModel!.get<DelegateListResponse>(
  //     apiUrl: ApiUrls.kDelegatesList,
  //     params: param,
  //   );
  // }

  // Future<ProposalListResponseModel?> getProposalList({
  //   Map<String, dynamic>? param,
  //   String? id,
  //   BuildContext? context,
  // }) async {
  //   return _apiViewModel!.get<ProposalListResponseModel>(
  //     apiUrl: ApiUrls.kProposalList,
  //     params: param,
  //     context: context,
  //   );
  // }
}
