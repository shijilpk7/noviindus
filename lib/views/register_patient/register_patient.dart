import 'package:flutter/material.dart';
import 'package:noviindus/utils/app_colors.dart';
import 'package:noviindus/utils/util_functions.dart';
import 'package:noviindus/view_models/login_viewmodel.dart';
import 'package:noviindus/views/common_widgets/app_dropdown.dart';
import 'package:noviindus/views/common_widgets/app_textfield.dart';
import 'package:noviindus/views/common_widgets/custom_appbar.dart';
import 'package:noviindus/views/common_widgets/time_select.dart';
import 'package:noviindus/views/invoice/invoice_screen.dart';
import 'package:noviindus/views/register_patient/widgets/add_treatment.dart';
import 'package:noviindus/views/register_patient/widgets/payment_option.dart';
import 'package:provider/provider.dart';

class RegisterPatient extends StatelessWidget {
  const RegisterPatient({super.key});

  @override
  Widget build(BuildContext context) {
    final loginViewModel = Provider.of<LoginViewModel>(context, listen: false);
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 15),
              child: Text("Register", style: theme.titleLarge),
            ),
            const Divider(color: AppColors.hintText, height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: AppTextField(
                controller: loginViewModel.emailController,
                label: "Name",
                hint: "Enter your full name",
                keyboardType: TextInputType.emailAddress,
                validator: UtilFunctions.validateEmail,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: AppTextField(
                controller: loginViewModel.emailController,
                label: "Whatsapp Number",
                hint: "Enter your Whatsapp number",
                keyboardType: TextInputType.emailAddress,
                validator: UtilFunctions.validateEmail,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: AppTextField(
                controller: loginViewModel.emailController,
                label: "Address",
                hint: "Enter your full address",
                keyboardType: TextInputType.emailAddress,
                validator: UtilFunctions.validateEmail,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CustomDropdown(
                label: "Location",
                hint: "Choose your location",
                items: ["value 1", "value 2"],
                onChanged: (value) {},
                validator: UtilFunctions.validateEmail,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: CustomDropdown(
                label: "Branch",
                hint: "Select the branch",
                items: ["value 1", "value 2"],
                onChanged: (value) {},
                validator: UtilFunctions.validateEmail,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Text("Treatments", style: theme.bodyLarge),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.lightGrey,
                    ),
                    child: Column(
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
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Vikram Singh",
                                      style: theme.titleLarge?.copyWith(
                                        fontSize: 19,
                                      ),
                                    ),
                                    SizedBox(height: 10),
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
                                        SizedBox(width: 10),
                                        Container(
                                          height: 26,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.hintText,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            "2",
                                            style: theme.bodyMedium?.copyWith(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.buttonGreen,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20),
                                        Text(
                                          "Female",
                                          style: theme.bodyMedium?.copyWith(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.buttonGreen,
                                          ),
                                        ),

                                        SizedBox(width: 10),
                                        Container(
                                          height: 26,
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 15,
                                          ),
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: AppColors.hintText,
                                            ),
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                          child: Text(
                                            "2",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/images/cross.png",
                                    height: 27,
                                  ),
                                  SizedBox(height: 10),
                                  Image.asset(
                                    "assets/images/edit.png",
                                    height: 27,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.buttonGreenLight,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    TreatmentDialog.show(context);
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => RegisterPatient(),
                    //   ),
                    // );
                  },
                  child: Text(
                    "+ Add Treatments",
                    style: theme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: AppColors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: AppTextField(
                controller: loginViewModel.emailController,
                label: "Total Amount",
                keyboardType: TextInputType.number,
                validator: UtilFunctions.validateField,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: AppTextField(
                controller: loginViewModel.emailController,
                label: "Discount Amount",
                keyboardType: TextInputType.emailAddress,
                validator: UtilFunctions.validateField,
              ),
            ),

            //payment option
            PaymentOptionWidget(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: AppTextField(
                controller: loginViewModel.emailController,
                label: "Advance Amount",
                keyboardType: TextInputType.emailAddress,
                validator: UtilFunctions.validateField,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: AppTextField(
                controller: loginViewModel.emailController,
                label: "Balance Amount",
                keyboardType: TextInputType.emailAddress,
                validator: UtilFunctions.validateField,
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: AppTextField(
                controller: loginViewModel.emailController,
                label: "Treatment Date",
                keyboardType: TextInputType.emailAddress,
                validator: UtilFunctions.validateField,
                suffixIcon: Image.asset(
                  "assets/images/calender.png",
                  height: 18,
                  width: 18,
                  color: AppColors.buttonGreen,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TreatmentTimePicker(
                selectedHour: null,
                selectedMinute: null,
                onHourChanged: (val) {
                  print("Selected Hour: $val");
                },
                onMinuteChanged: (val) {
                  print("Selected Minute: $val");
                },
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(20),
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
                      MaterialPageRoute(builder: (context) => InvoicePage()),
                    );
                  },
                  child: Text("Save", style: theme.labelLarge),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
