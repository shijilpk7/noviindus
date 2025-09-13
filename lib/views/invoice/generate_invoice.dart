import 'package:flutter/services.dart';
import 'package:noviindus/models/response_models/patient_list_response.dart';
import 'package:noviindus/utils/app_image.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Future<void> generatePatientPdf(Patient? patient) async {
  final pdf = pw.Document();

  // ✅ Load Logo
  final logoBytes = await rootBundle.load(AppImages.logo);
  final logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());

  // ✅ Load Fonts
  final fontInter = await rootBundle.load("assets/fonts/Inter_28pt-Light.ttf");
  final fontInterSemiBold = await rootBundle.load(
    "assets/fonts/Inter_28pt-SemiBold.ttf",
  );
  final fontInterMedium = await rootBundle.load(
    "assets/fonts/Inter_28pt-Light.ttf",
  );

  final fontManropeSemiBold = await rootBundle.load(
    "assets/fonts/Manrope-SemiBold.ttf",
  );

  String? treatmentDate = "";
  String? treatmentTime = "";

  if (patient?.dateNdTime != null && patient!.dateNdTime!.isNotEmpty) {
    final dt = DateTime.tryParse(patient.dateNdTime!);
    if (dt != null) {
      treatmentDate =
          "${dt.day.toString().padLeft(2, '0')}-${dt.month.toString().padLeft(2, '0')}-${dt.year}";
      treatmentTime =
          "${dt.hour % 12 == 0 ? 12 : dt.hour % 12}:${dt.minute.toString().padLeft(2, '0')} ${dt.hour >= 12 ? 'PM' : 'AM'}";
    }
  }

  final ttfInter = pw.Font.ttf(fontInter);
  final ttfInterSemiBold = pw.Font.ttf(fontInterSemiBold);
  final ttfInterMedium = pw.Font.ttf(fontInterMedium);
  final ttfManropeSemiBold = pw.Font.ttf(fontManropeSemiBold);

  pdf.addPage(
    pw.MultiPage(
      margin: const pw.EdgeInsets.all(24),
      build: (context) {
        return [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Container(
                height: 80,
                width: 80,
                decoration: pw.BoxDecoration(
                  shape: pw.BoxShape.circle,
                  border: pw.Border.all(color: PdfColors.green, width: 2),
                ),
                child: pw.Center(
                  child: pw.Image(logoImage, fit: pw.BoxFit.contain),
                ),
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    patient?.branch?.name ?? "KUMARAKOM",
                    style: pw.TextStyle(
                      font: ttfManropeSemiBold,
                      fontSize: 10,
                      lineSpacing: 18,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    patient?.branch?.address ?? "",
                    style: pw.TextStyle(
                      font: ttfManropeSemiBold,
                      fontSize: 10,
                      lineSpacing: 18,
                      color: PdfColors.grey,
                    ),
                  ),
                  pw.Text(
                    "Mob: ${patient?.branch?.phone ?? ""}",
                    style: pw.TextStyle(
                      font: ttfManropeSemiBold,
                      fontSize: 10,
                      color: PdfColors.grey,
                    ),
                  ),
                  pw.Text(
                    "e-mail: ${patient?.branch?.mail ?? ""}",
                    style: pw.TextStyle(
                      font: ttfManropeSemiBold,
                      fontSize: 10,
                      color: PdfColors.grey,
                    ),
                  ),
                  pw.Text(
                    "GST No: ${patient?.branch?.gst ?? ""}",
                    style: pw.TextStyle(
                      font: ttfInter,
                      fontSize: 10,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),

          pw.SizedBox(height: 20),
          pw.Divider(color: PdfColor.fromHex("#D9D9D9")),
          pw.SizedBox(height: 20),
          pw.Text(
            "Patient Details",
            style: pw.TextStyle(
              font: ttfInterSemiBold,
              fontSize: 13,
              color: PdfColor.fromHex("#00A64F"),
            ),
          ),
          pw.SizedBox(height: 8),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "Name: ",
                    style: pw.TextStyle(
                      font: ttfInterSemiBold,
                      fontSize: 11,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    "Address: ",
                    style: pw.TextStyle(
                      font: ttfInterSemiBold,
                      fontSize: 11,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    "WhatsApp Number: ",
                    style: pw.TextStyle(
                      font: ttfInterSemiBold,
                      fontSize: 11,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    patient?.name ?? "Salih T",
                    style: pw.TextStyle(
                      font: ttfManropeSemiBold,
                      fontSize: 10,
                      color: PdfColor.fromHex("#9A9A9A"),
                    ),
                  ),
                  pw.Text(
                    patient?.address ?? "",
                    style: pw.TextStyle(
                      font: ttfManropeSemiBold,
                      fontSize: 10,
                      color: PdfColor.fromHex("#9A9A9A"),
                    ),
                  ),
                  pw.Text(
                    patient?.phone ?? "",
                    style: pw.TextStyle(
                      font: ttfManropeSemiBold,
                      fontSize: 10,
                      color: PdfColor.fromHex("#9A9A9A"),
                    ),
                  ),
                ],
              ),
              pw.Spacer(),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "Booked On: ",
                    style: pw.TextStyle(
                      font: ttfInterSemiBold,
                      fontSize: 11,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    "Treatment Date: ",
                    style: pw.TextStyle(
                      font: ttfInterSemiBold,
                      fontSize: 11,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.Text(
                    "Treatment Time: ",
                    style: pw.TextStyle(
                      font: ttfInterSemiBold,
                      fontSize: 11,
                      color: PdfColors.black,
                    ),
                  ),
                ],
              ),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    patient?.createdAt?.split('T').first ?? "",
                    style: pw.TextStyle(
                      font: ttfManropeSemiBold,
                      fontSize: 10,
                      lineSpacing: 18,
                      color: PdfColor.fromHex("#9A9A9A"),
                    ),
                  ),
                  pw.Text(
                    treatmentDate ?? "",
                    style: pw.TextStyle(
                      font: ttfManropeSemiBold,
                      fontSize: 10,
                      color: PdfColor.fromHex("#9A9A9A"),
                    ),
                  ),
                  pw.Text(
                    treatmentTime ?? "",
                    style: pw.TextStyle(
                      font: ttfManropeSemiBold,
                      fontSize: 10,
                      color: PdfColor.fromHex("#9A9A9A"),
                    ),
                  ),
                ],
              ),
            ],
          ),

          pw.SizedBox(height: 20),
          pw.LayoutBuilder(
            builder: (context, constraints) {
              final double dotSize = 2.0;
              final double gap = 6.0;
              final int count =
                  (constraints!.maxWidth / (dotSize + gap)).floor();

              return pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 10),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: List.generate(count, (index) {
                    return pw.Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromHex("#D9D9D9"), // light grey dot
                        shape: pw.BoxShape.circle,
                      ),
                    );
                  }),
                ),
              );
            },
          ),
          pw.SizedBox(height: 20),

          pw.Row(
            children: [
              pw.Expanded(
                flex: 3,
                child: pw.Text(
                  "Treatment",
                  style: pw.TextStyle(
                    font: ttfInterSemiBold,
                    fontSize: 13,
                    color: PdfColor.fromHex("#00A64F"),
                  ),
                ),
              ),
              pw.SizedBox(width: 20),
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  "Price",
                  style: pw.TextStyle(
                    font: ttfInterSemiBold,
                    fontSize: 13,
                    color: PdfColor.fromHex("#00A64F"),
                  ),
                ),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  "Male",
                  style: pw.TextStyle(
                    font: ttfInterSemiBold,
                    fontSize: 13,
                    color: PdfColor.fromHex("#00A64F"),
                  ),
                ),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  "Female",
                  style: pw.TextStyle(
                    font: ttfInterSemiBold,
                    fontSize: 13,
                    color: PdfColor.fromHex("#00A64F"),
                  ),
                ),
              ),
              pw.Expanded(
                flex: 2,
                child: pw.Text(
                  "Total",
                  style: pw.TextStyle(
                    font: ttfInterSemiBold,
                    fontSize: 13,
                    color: PdfColor.fromHex("#00A64F"),
                  ),
                ),
              ),
            ],
          ),

          pw.SizedBox(height: 6),
          ...patient?.patientdetailsSet?.map((t) {
                final male = int.tryParse(t.male ?? "0") ?? 0;
                final female = int.tryParse(t.female ?? "0") ?? 0;
                final price = patient.price ?? 230;
                final total = price * (male + female);
                return pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(vertical: 2),
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Text(
                          t.treatmentName ?? "Panchakarma",
                          style: pw.TextStyle(
                            font: ttfInterMedium,
                            fontSize: 13,
                            color: PdfColor.fromHex("#737373"),
                          ),
                        ),
                      ),
                      pw.SizedBox(width: 20),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          "₹$price",
                          style: pw.TextStyle(font: ttfInter, fontSize: 12),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          "$male",
                          style: pw.TextStyle(font: ttfInter, fontSize: 12),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          "$female",
                          style: pw.TextStyle(font: ttfInter, fontSize: 12),
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Text(
                          "₹$total",
                          style: pw.TextStyle(font: ttfInter, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList() ??
              [],

          pw.SizedBox(height: 20),
          pw.LayoutBuilder(
            builder: (context, constraints) {
              final double dotSize = 2.0;
              final double gap = 6.0;
              final int count =
                  (constraints!.maxWidth / (dotSize + gap)).floor();

              return pw.Padding(
                padding: const pw.EdgeInsets.symmetric(vertical: 10),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: List.generate(count, (index) {
                    return pw.Container(
                      width: dotSize,
                      height: dotSize,
                      decoration: pw.BoxDecoration(
                        color: PdfColor.fromHex("#D9D9D9"), // light grey dot
                        shape: pw.BoxShape.circle,
                      ),
                    );
                  }),
                ),
              );
            },
          ),
          pw.SizedBox(height: 20),

          pw.Align(
            alignment: pw.Alignment.centerRight,
            child: pw.SizedBox(
              width: 170,
              child: pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          "Total Amount: ",
                          style: pw.TextStyle(
                            font: ttfInterSemiBold,
                            fontSize: 13,
                            color: PdfColors.black,
                          ),
                        ),
                      ),
                      pw.Text(
                        "₹${patient?.totalAmount ?? 0}",
                        style: pw.TextStyle(
                          font: ttfInterSemiBold,
                          fontSize: 13,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          "Discount: ",
                          style: pw.TextStyle(
                            font: ttfInterSemiBold,
                            fontSize: 13,
                            color: PdfColors.black,
                          ),
                        ),
                      ),

                      pw.Text(
                        "₹${patient?.discountAmount ?? 0}",
                        style: pw.TextStyle(
                          font: ttfInterSemiBold,
                          fontSize: 13,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          "Advance: ",
                          style: pw.TextStyle(
                            font: ttfInterSemiBold,
                            fontSize: 13,
                            color: PdfColors.black,
                          ),
                        ),
                      ),

                      pw.Text(
                        "₹${patient?.advanceAmount ?? 0}",
                        style: pw.TextStyle(
                          font: ttfInterSemiBold,
                          fontSize: 13,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  ),
                  pw.SizedBox(height: 10),
                  pw.LayoutBuilder(
                    builder: (context, constraints) {
                      final double dotSize = 2.0;
                      final double gap = 6.0;
                      final int count =
                          (constraints!.maxWidth / (dotSize + gap)).floor();

                      return pw.Padding(
                        padding: const pw.EdgeInsets.symmetric(vertical: 10),
                        child: pw.Row(
                          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                          children: List.generate(count, (index) {
                            return pw.Container(
                              width: dotSize,
                              height: dotSize,
                              decoration: pw.BoxDecoration(
                                color: PdfColor.fromHex(
                                  "#D9D9D9",
                                ), // light grey dot
                                shape: pw.BoxShape.circle,
                              ),
                            );
                          }),
                        ),
                      );
                    },
                  ),
                  pw.SizedBox(height: 10),
                  pw.Row(
                    children: [
                      pw.Expanded(
                        child: pw.Text(
                          "Balance: ",
                          style: pw.TextStyle(
                            font: ttfInterSemiBold,
                            fontSize: 13,
                            color: PdfColors.black,
                          ),
                        ),
                      ),

                      pw.Text(
                        "₹${patient?.balanceAmount ?? 0}",
                        style: pw.TextStyle(
                          font: ttfInterSemiBold,
                          fontSize: 13,
                          color: PdfColors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          pw.SizedBox(height: 30),
          pw.Row(
            children: [
              pw.Expanded(child: pw.SizedBox()),
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.end,
                children: [
                  pw.Text(
                    "Thank you for choosing us",
                    style: pw.TextStyle(
                      font: ttfInterSemiBold,
                      fontSize: 16,
                      color: PdfColor.fromHex("#00A64F"),
                    ),
                  ),
                  pw.SizedBox(height: 6),
                  pw.Text(
                    "Your well-being is our commitment, and we're honored\n you've entrusted us with your health journey",
                    textAlign: pw.TextAlign.center,
                    style: pw.TextStyle(
                      font: ttfInter,
                      fontSize: 10,
                      color: PdfColor.fromHex("#D9D9D9"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ];
      },
    ),
  );

  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
