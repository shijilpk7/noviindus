import 'package:flutter/material.dart';
import 'package:noviindus/utils/app_colors.dart';
import 'package:noviindus/utils/app_image.dart';
import 'package:noviindus/view_models/patient_viewmodel.dart';
import 'package:noviindus/views/register_patient/widgets/add_treatment.dart';
import 'package:provider/provider.dart';

class TreatmentsList extends StatelessWidget {
  const TreatmentsList({super.key, required this.theme});

  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Consumer<PatientViewmodel>(
      builder: (context, vm, _) {
        if ((vm.treatments ?? []).isEmpty) {
          return SizedBox(height: 10);
        }
        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 5),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: vm.treatments?.length,
          itemBuilder: (context, index) {
            final data = vm.treatments?[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.lightGrey,
                ),
                child: Padding(
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
                              data?.name ?? "",
                              style: theme.titleLarge?.copyWith(fontSize: 19),
                            ),
                            const SizedBox(height: 15),
                            Row(
                              children: [
                                Text(
                                  "Male",
                                  style: theme.bodyMedium?.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.buttonGreen,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: 26,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.hintText,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "${data?.maleCount ?? 0}",
                                    style: theme.bodyMedium?.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.buttonGreen,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                Text(
                                  "Female",
                                  style: theme.bodyMedium?.copyWith(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.buttonGreen,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  height: 26,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                  ),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.hintText,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "${data?.femaleCount ?? 0}",
                                    style: theme.bodyMedium?.copyWith(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.buttonGreen,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              vm.deleteTreatment(index);
                            },
                            child: Image.asset(AppImages.cross, height: 27),
                          ),
                          const SizedBox(height: 15),
                          InkWell(
                            onTap: () {
                              vm.editTreatment(index);
                              TreatmentDialog.show(context, edit: true);
                            },
                            child: Image.asset(AppImages.edit, height: 27),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
