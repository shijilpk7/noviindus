import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:noviindus/utils/app_colors.dart';
import 'package:noviindus/utils/app_image.dart';
import 'package:noviindus/utils/util_functions.dart';
import 'package:noviindus/view_models/patient_viewmodel.dart';
import 'package:noviindus/views/common_widgets/app_dropdown.dart';
import 'package:noviindus/views/common_widgets/app_textfield.dart';
import 'package:noviindus/views/common_widgets/loaderwidget.dart';
import 'package:noviindus/views/common_widgets/no_data_found.dart';
import 'package:noviindus/views/register_patient/widgets/add_treatment.dart';
import 'package:noviindus/views/register_patient/widgets/payment_option.dart';
import 'package:noviindus/views/register_patient/widgets/time_select.dart';
import 'package:provider/provider.dart';

class RegisterPatient extends StatelessWidget {
  const RegisterPatient({super.key});

  @override
  Widget build(BuildContext context) {
    final patientVM = Provider.of<PatientViewmodel>(context, listen: false);
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
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
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Text("Register", style: theme.titleLarge),
                ),
                const SizedBox(height: 15),
                const Divider(color: AppColors.hintText, height: 1),
              ],
            ),
          ),

          /// Scrollable body
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: patientVM.registerFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      /// Name
                      AppTextField(
                        controller: patientVM.nameController,
                        label: "Name",
                        hint: "Enter your full name",

                        validator: UtilFunctions.validateField,
                      ),
                      const SizedBox(height: 15),

                      /// Whatsapp Number
                      AppTextField(
                        controller: patientVM.whatsappController,
                        label: "Whatsapp Number",
                        hint: "Enter your Whatsapp number",
                        keyboardType: TextInputType.phone,

                        validator: UtilFunctions.validateField,
                      ),
                      const SizedBox(height: 15),

                      /// Address
                      AppTextField(
                        controller: patientVM.addressController,
                        label: "Address",
                        hint: "Enter your full address",

                        validator: UtilFunctions.validateField,
                      ),
                      const SizedBox(height: 15),

                      /// Location
                      CustomDropdown(
                        label: "Location",
                        hint: "Choose your location",
                        items: const ["Kochi", "Calicut", "Kannur"],
                        onChanged: (value) {
                          patientVM.addsSelectedLocation(value);
                        },
                        validator: UtilFunctions.validateField,
                      ),
                      const SizedBox(height: 15),

                      /// Branch
                      Consumer<PatientViewmodel>(
                        builder: (context, vm, _) {
                          if (vm.isloading!) {
                            return LoaderWidget(color: AppColors.black);
                          } else if ((vm.branchesList ?? []).isEmpty) {
                            return NoDataFound(
                              onRefresh: () => vm.getBranchList(),
                            );
                          } else {
                            return CustomDropdown(
                              selectedItem: vm.selectedBranch,
                              label: "Branch",
                              hint: "Select the branch",
                              items:
                                  vm.branchesList!
                                      .map((e) => e.name ?? "")
                                      .toSet()
                                      .toList(),
                              onChanged: (value) {
                                final selectedItem = vm.branchesList!
                                    .firstWhere((e) => e.name == value);
                                vm.addSelectedBranch(selectedItem.id, value);
                              },
                              validator: UtilFunctions.validateField,
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 15),

                      /// Treatments
                      Text("Treatments", style: theme.bodyLarge),
                      Consumer<PatientViewmodel>(
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                ),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 12),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: AppColors.lightGrey,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "$index.",
                                          style: theme.titleLarge?.copyWith(
                                            fontSize: 18,
                                          ),
                                        ),
                                        const SizedBox(width: 6),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                data?.name ?? "",
                                                style: theme.titleLarge
                                                    ?.copyWith(fontSize: 19),
                                              ),
                                              const SizedBox(height: 15),
                                              Row(
                                                children: [
                                                  Text(
                                                    "Male",
                                                    style: theme.bodyMedium
                                                        ?.copyWith(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors
                                                                  .buttonGreen,
                                                        ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    height: 26,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 15,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            AppColors.hintText,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      "${data?.maleCount ?? 0}",
                                                      style: theme.bodyMedium
                                                          ?.copyWith(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                AppColors
                                                                    .buttonGreen,
                                                          ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 20),
                                                  Text(
                                                    "Female",
                                                    style: theme.bodyMedium
                                                        ?.copyWith(
                                                          fontSize: 17,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color:
                                                              AppColors
                                                                  .buttonGreen,
                                                        ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Container(
                                                    height: 26,
                                                    padding:
                                                        const EdgeInsets.symmetric(
                                                          horizontal: 15,
                                                        ),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        color:
                                                            AppColors.hintText,
                                                      ),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            8,
                                                          ),
                                                    ),
                                                    child: Text(
                                                      "${data?.femaleCount ?? 0}",
                                                      style: theme.bodyMedium
                                                          ?.copyWith(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color:
                                                                AppColors
                                                                    .buttonGreen,
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
                                                patientVM.deleteTreatment(
                                                  index,
                                                );
                                              },
                                              child: Image.asset(
                                                AppImages.cross,
                                                height: 27,
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            InkWell(
                                              onTap: () {
                                                // patientVM.setTreatment(
                                                //   data?.name,
                                                //   data?.id,
                                                //   male: data?.maleCount,
                                                //   female: data?.femaleCount,
                                                // );
                                                vm.editTreatment(index);
                                                TreatmentDialog.show(
                                                  context,
                                                  edit: true,
                                                );
                                              },
                                              child: Image.asset(
                                                AppImages.edit,
                                                height: 27,
                                              ),
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
                      ),

                      /// Add Treatment button
                      SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.buttonGreenLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            patientVM.clearTreatmentData();
                            TreatmentDialog.show(context);
                          },
                          child: Text(
                            "+ Add Treatments",
                            style: theme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.black,
                              fontSize: 17,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),

                      /// Total Amount
                      AppTextField(
                        controller: patientVM.totalAmountController,
                        label: "Total Amount",
                        keyboardType: TextInputType.number,

                        validator: UtilFunctions.validateField,
                      ),
                      const SizedBox(height: 15),

                      /// Discount Amount
                      AppTextField(
                        controller: patientVM.discountAmountController,
                        label: "Discount Amount",
                        keyboardType: TextInputType.number,

                        validator: UtilFunctions.validateField,
                      ),
                      const SizedBox(height: 15),

                      /// Payment option
                      const PaymentOptionWidget(),
                      const SizedBox(height: 15),

                      /// Advance Amount
                      AppTextField(
                        controller: patientVM.advanceAmountController,
                        label: "Advance Amount",
                        keyboardType: TextInputType.number,

                        validator: UtilFunctions.validateField,
                      ),
                      const SizedBox(height: 15),

                      /// Balance Amount
                      AppTextField(
                        controller: patientVM.balanceAmountController,
                        label: "Balance Amount",
                        keyboardType: TextInputType.number,

                        validator: UtilFunctions.validateField,
                      ),
                      const SizedBox(height: 15),

                      /// Treatment Date
                      Text("Treatment Date", style: theme.bodyLarge),
                      const SizedBox(height: 8),
                      Consumer<PatientViewmodel>(
                        builder: (context, vm, _) {
                          return InkWell(
                            onTap: () async {
                              final picked = await showDatePicker(
                                context: context,
                                initialDate: vm.selectedDate ?? DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (picked != null) {
                                vm.setDate(picked);
                                patientVM.treatmentDateController.text =
                                    DateFormat("dd/MM/yyyy").format(picked);
                              }
                            },
                            child: Container(
                              height: 54,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    patientVM.treatmentDateController.text,
                                    style: theme.bodyLarge,
                                  ),
                                  Image.asset(
                                    AppImages.calender,
                                    height: 16,
                                    color: AppColors.buttonGreen,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),

                      /// Time Picker
                      TreatmentTimePicker(
                        selectedHour: null,
                        selectedMinute: null,
                        onHourChanged: (val) {
                          patientVM.addTimeHour(val);
                        },
                        onMinuteChanged: (val) {
                          patientVM.addTimeMin(val);
                        },
                      ),
                      const SizedBox(height: 30),

                      /// Save button
                      Consumer<PatientViewmodel>(
                        builder: (context, vm, _) {
                          return SizedBox(
                            height: 48,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.buttonGreen,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                if (patientVM.registerFormKey.currentState!
                                    .validate()) {
                                  if ((vm.treatments ?? []).isEmpty) {
                                    toast("Add Treatements", isError: true);
                                    return;
                                  }
                                  if ((vm.selectedPaymentOption ?? "")
                                      .isEmpty) {
                                    toast("Add Payment option", isError: true);
                                    return;
                                  }
                                  if ((vm.treatments ?? []).isEmpty) {
                                    toast("Add Treatements", isError: true);
                                    return;
                                  }
                                  patientVM.registerPatient().then((value) {
                                    if (value) {
                                      toast("Patients added");
                                      Navigator.pop(context);
                                    } else {
                                      toast(vm.errormsg, isError: true);
                                      Navigator.pop(context);
                                    }
                                  });
                                }
                              },
                              child:
                                  vm.isloading!
                                      ? LoaderWidget()
                                      : Text("Save", style: theme.labelLarge),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
