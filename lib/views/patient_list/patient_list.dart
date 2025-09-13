import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noviindus/utils/app_colors.dart';
import 'package:noviindus/utils/app_image.dart';
import 'package:noviindus/view_models/patient_viewmodel.dart';
import 'package:noviindus/views/common_widgets/loaderwidget.dart';
import 'package:noviindus/views/common_widgets/no_data_found.dart';
import 'package:noviindus/views/login/login_screen.dart';
import 'package:noviindus/views/patient_list/widgets/patient_card.dart';
import 'package:noviindus/views/register_patient/register_patient.dart';
import 'package:provider/provider.dart';

class BookingListScreen extends StatelessWidget {
  const BookingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) {
          _showLogoutDialog(context);
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => _showLogoutDialog(context),
                      icon: const Icon(Icons.arrow_back),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Badge(
                        child: Image.asset(
                          AppImages.notification,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Consumer<PatientViewmodel>(
                builder: (context, patientVM, child) {
                  final hasQuery = patientVM.searchController.text.isNotEmpty;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 40,
                            child: TextField(
                              onSubmitted: (value) {
                                if (value.isNotEmpty) {
                                  patientVM.searchPatient(value);
                                }
                              },
                              controller: patientVM.searchController,
                              decoration: InputDecoration(
                                hintText: "Search for patients",
                                hintStyle: theme.bodyMedium,
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: AppColors.hintText,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: AppColors.hintText,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                    color: AppColors.hintText,
                                  ),
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
                            onPressed: () {
                              if (hasQuery) {
                                patientVM.clearSearch();
                              } else {
                                patientVM.searchPatient(
                                  patientVM.searchController.text,
                                );
                              }
                            },
                            child: Text(
                              hasQuery ? "Clear" : "Search",
                              style: theme.labelLarge?.copyWith(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Consumer<PatientViewmodel>(
                  builder: (context, patientVM, _) {
                    final selectedDate = patientVM.selectedDateFilter;
                    final formattedDate =
                        selectedDate != null
                            ? DateFormat('dd/MM/yyyy').format(selectedDate)
                            : "";
                    return Row(
                      children: [
                        Expanded(
                          flex: selectedDate != null ? 0 : 1,
                          child: Text(
                            "Sort by :",
                            style: theme.bodySmall?.copyWith(fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 8),

                        /// Middle container with picked date + clear button
                        if (selectedDate != null)
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {
                                patientVM.clearDateFilter();
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.dividerColor,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(formattedDate, style: theme.bodyLarge),
                                    SizedBox(width: 5),
                                    Image.asset(AppImages.cross, height: 15),
                                  ],
                                ),
                              ),
                            ),
                          )
                        else
                          SizedBox(),

                        const SizedBox(width: 8),

                        /// Date picker button
                        Expanded(
                          flex: 1,
                          child: InkWell(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );

                              if (pickedDate != null) {
                                Provider.of<PatientViewmodel>(
                                  context,
                                  listen: false,
                                ).filterByDate(pickedDate);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors.dividerColor,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                        ),
                      ],
                    );
                  },
                ),
              ),
              const Divider(color: AppColors.hintText),
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () async {
                    Provider.of<PatientViewmodel>(
                      context,
                      listen: false,
                    ).getPatientList();
                  },
                  child: Consumer<PatientViewmodel>(
                    builder: (context, patientVM, _) {
                      if (patientVM.isloading ?? false) {
                        return LoaderWidget(color: AppColors.black);
                      } else if ((patientVM.patientList ?? []).isEmpty) {
                        return NoDataFound(
                          onRefresh: () => patientVM.getPatientList(),
                        );
                      } else {
                        return ListView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          itemCount: (patientVM.patientList ?? []).length,
                          itemBuilder: (context, index) {
                            var data = patientVM.patientList?[index];
                            return PatientCard(index: index + 1, patient: data);
                          },
                        );
                      }
                    },
                  ),
                ),
              ),

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
                      Provider.of<PatientViewmodel>(
                        context,
                        listen: false,
                      ).registerPatientCalls();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RegisterPatient(),
                        ),
                      );
                    },
                    child: Text("Register Now", style: theme.labelLarge),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Text(
            "Logout",
            style: theme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          content: Text(
            "Do you want to logout and go to login screen?",
            style: theme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          actionsPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          actions: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () => Navigator.pop(ctx),
                      child: Text(
                        "Cancel",
                        style: theme.labelLarge?.copyWith(
                          fontSize: 15,

                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.buttonGreenLight,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: Text(
                        "Confirm",
                        style: theme.labelLarge?.copyWith(
                          fontSize: 15,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
