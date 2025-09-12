import 'package:flutter/material.dart';

class InvoicePage extends StatelessWidget {
  const InvoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    return Scaffold(
      body: InteractiveViewer(
        // 👈 enables pinch zoom
        minScale: 0.8,
        maxScale: 3.0,
        boundaryMargin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(height: 40),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Logo
                    Image.asset("assets/images/logo.png", height: 80),
                    const Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "KUMARAKOM",
                          style: const TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            height: 1.8,
                          ),
                        ),
                        Text(
                          "Cheepunkal P.O. Kumarakom, kottayam, Kerala - 686563\n"
                          "e-mail: unknown@gmail.com\n"
                          "Mob: +91 9876543210 | +91 9786543210",
                          textAlign: TextAlign.right,
                          style: const TextStyle(
                            fontFamily: "Manrope",
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "GST No: 32AABCU9603R1ZW",
                          style: const TextStyle(
                            fontFamily: "Inter",
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Patient Details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Patient Details",
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF00A64F),
                            ),
                          ),
                          const SizedBox(height: 8),
                          _detailRow("Name", "Salih T"),
                          _detailRow("Address", "Nadakkave, Kozhikode"),
                          _detailRow("WhatsApp Number", "+91 987654321"),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _detailRow("Booked On", "31/01/2024   |   12:12pm"),
                          _detailRow("Treatment Date", "21/02/2024"),
                          _detailRow("Treatment Time", "11:00 am"),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Table header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey, width: 0.3),
                      top: BorderSide(color: Colors.grey, width: 0.3),
                    ),
                  ),
                  child: Row(
                    children: const [
                      Expanded(
                        child: Text(
                          "Treatment",
                          style: TextStyle(
                            fontFamily: "Inter",
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                            color: Color(0xFF00A64F),
                          ),
                        ),
                      ),
                      SizedBox(width: 60, child: Text("Price")),
                      SizedBox(width: 40, child: Text("Male")),
                      SizedBox(width: 50, child: Text("Female")),
                      SizedBox(width: 60, child: Text("Total")),
                    ],
                  ),
                ),

                // Table rows
                _treatmentRow("Panchakarma", "₹230", "4", "4", "₹2,540"),
                _treatmentRow(
                  "Njavara Kizhi Treatment",
                  "₹230",
                  "4",
                  "4",
                  "₹2,540",
                ),
                _treatmentRow("Panchakarma", "₹230", "4", "6", "₹2,540"),

                const SizedBox(height: 10),

                // Totals
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        TotalRow("Total Amount", "₹7,620", bold: true),
                        TotalRow("Discount", "₹500"),
                        TotalRow("Advance", "₹1,200"),
                        TotalRow("Balance", "₹5,920", bold: true),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Thank you
                Column(
                  children: [
                    Text(
                      "Thank you for choosing us",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: const Color(0xFF00A64F),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Your well-being is our commitment, and we're honored\n"
                      "you've entrusted us with your health journey",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 10,
                        color: Colors.grey.shade400,
                      ),
                    ),
                    const SizedBox(height: 30),
                    const Text("Signature / Logo here"),
                  ],
                ),

                const SizedBox(height: 20),

                // Footer note
                Text(
                  "“Booking amount is non-refundable, and it's important to arrive on the allotted time for your treatment”",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 10,
                    color: const Color(0xFFC9C9C9),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    //
  }

  static Widget _detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          Text(
            "$label: ",
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9A9A9A),
              height: 1.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget _treatmentRow(
    String name,
    String price,
    String male,
    String female,
    String total,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: const TextStyle(
                fontFamily: "Inter",
                fontSize: 13,
                color: Color(0xFF737373),
              ),
            ),
          ),
          SizedBox(width: 60, child: Text(price)),
          SizedBox(width: 40, child: Text(male)),
          SizedBox(width: 50, child: Text(female)),
          SizedBox(width: 60, child: Text(total)),
        ],
      ),
    );
  }
}

class TotalRow extends StatelessWidget {
  final String label;
  final String value;
  final bool bold;
  const TotalRow(this.label, this.value, {this.bold = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 12,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
          const SizedBox(width: 20),
          Text(
            value,
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 12,
              fontWeight: bold ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
