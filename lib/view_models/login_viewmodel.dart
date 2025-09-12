import 'package:flutter/material.dart';
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

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }
}
