import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:noviindus/utils/app_colors.dart';

class UtilFunctions {
  static String? validateName(String? value) {
    return value == null || value.isEmpty ? 'Name is required' : null;
  }

  static String? validatePhone(String? value) {
    return value == null || value.isEmpty
        ? 'Valid Phone Number is required'
        : null;
  }

  static String? validateField(String? value) {
    return value == null || value.isEmpty ? 'Field is required' : null;
  }

  static String? validatePassword(String? value) {
    return value == null || value.isEmpty ? 'Password is required' : null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  static String formatDateString(String dateString) {
    if (dateString.isNotEmpty) {
      DateTime dateTime = DateTime.parse(dateString);
      final DateFormat formatter = DateFormat('dd/MM/yyyy');
      return formatter.format(dateTime);
    } else {
      return "";
    }
  }
}

void toast(msg, {bool? isError = false}) {
  Fluttertoast.showToast(
    gravity: ToastGravity.CENTER_RIGHT,
    backgroundColor: isError! ? AppColors.error : AppColors.green,
    textColor: AppColors.white,
    msg: msg ?? "Something went wrong",
    toastLength: Toast.LENGTH_LONG,
  );
}
