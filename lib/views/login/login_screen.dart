import 'package:flutter/material.dart';
import 'package:noviindus/utils/app_colors.dart';
import 'package:noviindus/utils/util_functions.dart';
import 'package:noviindus/view_models/login_viewmodel.dart';
import 'package:noviindus/view_models/patient_viewmodel.dart';
import 'package:noviindus/views/common_widgets/app_textfield.dart';
import 'package:noviindus/views/common_widgets/loaderwidget.dart';
import 'package:noviindus/views/patient_list/patient_list.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Form(
            key: loginViewModel.loginFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Logo / background
                Stack(
                  children: [
                    SizedBox(
                      height: size.height * 0.28,
                      child: Image.asset(
                        "assets/images/login_bg.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Image.asset(
                          "assets/images/logo.png",
                          height: 80,
                          width: 80,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.05),

                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Login Or Register To Book Your Appointments",
                    style: theme.titleLarge,
                  ),
                ),
                SizedBox(height: size.height * 0.03),

                // Email field
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: AppTextField(
                    controller: loginViewModel.emailController,
                    label: "Email",
                    hint: "Enter your email",
                    keyboardType: TextInputType.emailAddress,
                    validator: UtilFunctions.validateEmail,
                    focusNode: loginViewModel.emailFocus,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      FocusScope.of(
                        context,
                      ).requestFocus(loginViewModel.passwordFocus);
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.01),

                // Password field
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10,
                  ),
                  child: AppTextField(
                    controller: loginViewModel.passwordController,
                    label: "Password",
                    hint: "Enter password",
                    obscureText: true,
                    validator: UtilFunctions.validatePassword,
                    focusNode: loginViewModel.passwordFocus,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => _login(context, loginViewModel),
                  ),
                ),
                SizedBox(height: size.height * 0.08),

                // Login button
                Consumer<LoginViewModel>(
                  builder: (context, loginVM, _) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          onPressed: () => _login(context, loginViewModel),
                          child:
                              loginVM.isloading!
                                  ? LoaderWidget()
                                  : Text("Login", style: theme.labelLarge),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.18),
                // Footer
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30.0,
                    vertical: 30,
                  ),
                  child: Text.rich(
                    TextSpan(
                      text:
                          "By creating or logging into an account you are agreeing with our ",
                      style: theme.bodySmall,
                      children: [
                        TextSpan(
                          text: "Terms and Conditions",
                          style: theme.bodySmall?.copyWith(
                            color: AppColors.blue,
                          ),
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy.",
                          style: theme.bodySmall?.copyWith(
                            color: AppColors.blue,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _login(BuildContext context, LoginViewModel loginViewModel) {
    if (loginViewModel.isloading!) {
      return;
    }
    if (loginViewModel.loginFormKey.currentState!.validate()) {
      loginViewModel.login().then((value) {
        if (value) {
          toast(loginViewModel.loginResponse?.message);
          //get patient data
          Provider.of<PatientViewmodel>(
            context,
            listen: false,
          ).getPatientList();
          loginViewModel.clear();
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BookingListScreen()),
            (route) => false,
          );
        } else {
          toast(
            loginViewModel.errormsg ?? "Invalid login credentials",
            isError: true,
          );
        }
      });
    }
  }
}
