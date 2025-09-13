// payment_option_widget.dart
import 'package:flutter/material.dart';
import 'package:noviindus/utils/app_colors.dart';
import 'package:noviindus/view_models/patient_viewmodel.dart';
import 'package:provider/provider.dart';

class PaymentOptionWidget extends StatelessWidget {
  const PaymentOptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientViewmodel>(
      builder: (context, viewModel, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Payment Option",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: AppColors.black),
            ),
            const SizedBox(height: 8),
            RadioGroup<String?>(
              groupValue: viewModel.selectedPaymentOption,
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
        );
      },
    );
  }

  Widget _optionItem(
    BuildContext context,
    PatientViewmodel viewModel,
    String option,
  ) {
    final bool isSelected = viewModel.selectedPaymentOption == option;

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
            Radio<String?>(
              value: option,
              fillColor: WidgetStatePropertyAll(AppColors.black),
            ),
            Text(
              option,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: AppColors.black,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
