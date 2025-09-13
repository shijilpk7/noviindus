import 'package:flutter/material.dart';
import 'package:noviindus/models/response_models/patient_list_response.dart';
import 'package:noviindus/utils/app_colors.dart';
import 'package:noviindus/utils/util_functions.dart';
import 'package:noviindus/views/invoice/generate_invoice.dart';

class PatientCard extends StatelessWidget {
  final int? index;
  final Patient? patient;

  const PatientCard({super.key, this.index, required this.patient});
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.lightGrey,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "$index.",
                    style: theme.titleLarge?.copyWith(fontSize: 18),
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          patient?.name ?? "",
                          style: theme.titleLarge?.copyWith(fontSize: 19),
                        ),
                        const SizedBox(height: 4),

                        Text(
                          (patient?.patientdetailsSet ?? []).isNotEmpty
                              ? patient
                                      ?.patientdetailsSet
                                      ?.first
                                      .treatmentName ??
                                  ""
                              : "Couple Combo Package (Rejuvenile...)",
                          maxLines: 1,
                          style: theme.bodyMedium?.copyWith(
                            fontSize: 17,
                            overflow: TextOverflow.ellipsis,
                            fontWeight: FontWeight.w400,
                            color: AppColors.buttonGreen,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Image.asset(
                              "assets/images/calender.png",
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              UtilFunctions.formatDateString(
                                patient?.createdAt ?? "",
                              ),
                              style: theme.bodyLarge?.copyWith(
                                fontSize: 15,
                                color: AppColors.hintText,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Image.asset(
                              "assets/images/user.png",
                              width: 16,
                              height: 16,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              patient?.user ?? "",
                              style: theme.bodyLarge?.copyWith(
                                fontSize: 15,
                                color: AppColors.hintText,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const Divider(color: AppColors.dividerColor, height: 1),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              child: InkWell(
                onTap: () {
                  generatePatientPdf(patient);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "View Booking details",
                      style: theme.bodyMedium?.copyWith(
                        fontSize: 16,
                        color: AppColors.black,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      fontWeight: FontWeight.w700,
                      color: AppColors.buttonGreen,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
