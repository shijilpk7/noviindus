import 'package:flutter/material.dart';
import 'package:noviindus/utils/app_colors.dart';
import 'package:noviindus/utils/util_functions.dart';
import 'package:noviindus/views/common_widgets/app_dropdown.dart';

class TreatmentDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          insetPadding: const EdgeInsets.all(25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Choose Treatment
                CustomDropdown(
                  label: "Choose Treatment",
                  hint: "Choose prefered treatment",
                  items: ["value 1", "value 2"],
                  onChanged: (value) {},
                  validator: UtilFunctions.validateEmail,
                ),
                const SizedBox(height: 20),
                Text(
                  "Add Patients",
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF404040),
                    height: 1.0,
                  ),
                ),
                const SizedBox(height: 12),

                //male row
                _patientRow("Male"),
                const SizedBox(height: 12),

                // Female Row
                _patientRow("Female"),
                const SizedBox(height: 24),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF006837),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 1,
                        height: 1.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _patientRow(String label) {
    return Row(
      children: [
        Container(
          width: 90,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.grey.shade300),
          ),
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w300,
              color: Colors.black,
              height: 1.0,
            ),
          ),
        ),
        const Spacer(),
        _circleButton(Icons.remove),
        const SizedBox(width: 8),
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Text(
            "0",
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
              height: 1.0,
            ),
          ),
        ),
        const SizedBox(width: 8),
        _circleButton(Icons.add),
      ],
    );
  }

  // Green circular button
  static Widget _circleButton(IconData icon) {
    return Container(
      width: 36,
      height: 36,
      decoration: const BoxDecoration(
        color: Color(0xFF006837),
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 20),
    );
  }
}
