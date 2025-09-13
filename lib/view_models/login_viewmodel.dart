import 'package:flutter/material.dart';
import 'package:noviindus/models/response_models/login_response.dart';
import 'package:noviindus/services/api_service/api_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final ApiRepository apiRepository;

  LoginViewModel({required this.apiRepository});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  final loginFormKey = GlobalKey<FormState>();
  var data;

  void clear() {
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  //login api call

  String? _errormsg;
  String? get errormsg => _errormsg;

  bool? _isloading = false;
  bool? get isloading => _isloading;

  LoginResponse? _loginResponse;
  LoginResponse? get loginResponse => _loginResponse;

  Future<bool> login() async {
    _isloading = true;
    notifyListeners();
    try {
      LoginResponse? response = await apiRepository.login(
        //TODO: Change
        // data: {
        //   "username": emailController.text,
        //   "password": passwordController.text,
        // },
        data: {"username": "test_user", "password": 12345678},
      );
      if (response?.status == true) {
        _loginResponse = response;
        _isloading = false;
        notifyListeners();
        return true;
      } else {
        _errormsg = response?.message ?? "Invalid login credentials";
      }
      _isloading = false;
      notifyListeners();
      return false;
    } catch (e) {
      debugPrint("error: ${e.toString()}");
      _errormsg = e.toString();
      _isloading = false;
      notifyListeners();
      return false;
    }
  }
}
