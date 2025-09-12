import 'package:flutter/material.dart';
import 'package:noviindus/utils/app_colors.dart';
import 'package:noviindus/views/common_widgets/custom_appbar.dart';
import 'package:noviindus/views/patient_list/widgets/patient_card.dart';
import 'package:noviindus/views/register_patient/register_patient.dart';

class BookingListScreen extends StatelessWidget {
  const BookingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppbar(),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 40,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Search for treatments",
                        hintStyle: theme.bodyMedium,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.hintText,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.hintText),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColors.hintText),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 0,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    onPressed: () {},
                    child: Text(
                      "Search",
                      style: theme.labelLarge?.copyWith(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Sort by
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Sort by :",
                    style: theme.bodySmall?.copyWith(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.dividerColor),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Date", style: theme.bodyLarge),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: AppColors.textPrimary,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Divider(color: AppColors.hintText),

          // Booking list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              itemCount: 6,
              itemBuilder: (context, index) {
                return PatientCard(index: index + 1);
              },
            ),
          ),

          // Bottom Button
          Padding(
            padding: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonGreen,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPatient()),
                  );
                },
                child: Text("Register Now", style: theme.labelLarge),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
