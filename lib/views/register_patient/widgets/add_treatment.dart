import 'package:flutter/material.dart';
import 'package:noviindus/utils/app_colors.dart';
import 'package:noviindus/utils/util_functions.dart';
import 'package:noviindus/view_models/patient_viewmodel.dart';
import 'package:noviindus/views/common_widgets/app_dropdown.dart';
import 'package:noviindus/views/common_widgets/loaderwidget.dart';
import 'package:noviindus/views/common_widgets/no_data_found.dart';
import 'package:provider/provider.dart';

class TreatmentDialog {
  static void show(BuildContext context, {bool? edit = false}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          insetPadding: const EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Consumer<PatientViewmodel>(
            builder: (context, vm, _) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (vm.isloading!)
                      LoaderWidget(color: AppColors.black)
                    else if ((vm.treatmentList ?? []).isEmpty)
                      NoDataFound(onRefresh: () => vm.getTreatmentList())
                    else
                      // Choose Treatment
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: CustomDropdown(
                          selectedItem: vm.selectedTreatment,
                          label: "Choose Treatment",
                          hint: "Choose preferred treatment",
                          items:
                              vm.treatmentList!
                                  .where(
                                    (e) =>
                                        !vm.treatments!.any(
                                          (t) =>
                                              (t.id == e.id &&
                                                  vm.selectedTreatment !=
                                                      t.name),
                                        ),
                                  )
                                  .map((e) => e.name ?? "")
                                  .toSet()
                                  .toList(),
                          onChanged: (value) {
                            final selectedItem = vm.treatmentList!.firstWhere(
                              (e) => e.name == value,
                            );
                            vm.setTreatment(selectedItem.name, selectedItem.id);
                          },
                          validator: UtilFunctions.validateEmail,
                        ),
                      ),

                    const SizedBox(height: 20),

                    // Add Patients
                    Text(
                      "Add Patients",
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Color(0xFF404040)),
                    ),
                    const SizedBox(height: 12),

                    // Male Row
                    _patientRow(
                      "Male",
                      vm.maleCount,
                      vm.incrementMale,
                      vm.decrementMale,
                      context,
                    ),
                    const SizedBox(height: 12),

                    // Female Row
                    _patientRow(
                      "Female",
                      vm.femaleCount,
                      vm.incrementFemale,
                      vm.decrementFemale,
                      context,
                    ),
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
                        onPressed: () {
                          if ((vm.selectedTreatment ?? "").isNotEmpty &&
                              (vm.maleCount != 0 || vm.femaleCount != 0)) {
                            vm.saveTreatment();
                            Navigator.pop(context);
                          } else {
                            toast(
                              (vm.selectedTreatment ?? "").isEmpty
                                  ? "Select Treatment"
                                  : "Add Patients",
                              isError: true,
                            );
                          }
                        },
                        child: Text(
                          "Save",
                          style: Theme.of(
                            context,
                          ).textTheme.bodyLarge?.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Reusable patient row (Male/Female)
  static Widget _patientRow(
    String label,
    int count,
    VoidCallback onAdd,
    VoidCallback onRemove,
    BuildContext context,
  ) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 40,
            padding: EdgeInsets.only(left: 10),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.black),
            ),
          ),
        ),
        SizedBox(width: 100),
        // Minus button
        _circleButton(Icons.remove, onRemove),
        const SizedBox(width: 8),
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            "$count",
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.black,
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(width: 8),
        // Plus button
        _circleButton(Icons.add, onAdd),
      ],
    );
  }

  // Green circular button
  static Widget _circleButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: const BoxDecoration(
          color: Color(0xFF006837),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
