// payment_option_widget.dart
import 'package:flutter/material.dart';
import 'package:noviindus/view_models/patient_viewmodel.dart';
import 'package:provider/provider.dart';

class PaymentOptionWidget extends StatelessWidget {
  const PaymentOptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientViewmodel>(
      builder: (context, viewModel, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Payment Option",
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF404040),
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 8),
              RadioGroup<String?>(
                groupValue: viewModel.selectedOption,
                onChanged: (value) {
                  viewModel.selectOption(value ?? "");
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _optionItem(context, viewModel, "Cash"),
                    _optionItem(context, viewModel, "Card"),
                    _optionItem(context, viewModel, "UPI"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _optionItem(
    BuildContext context,
    PatientViewmodel viewModel,
    String option,
  ) {
    final bool isSelected = viewModel.selectedOption == option;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        viewModel.selectOption(option);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String?>(value: option),
            Text(
              option,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: Colors.black,
                height: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
