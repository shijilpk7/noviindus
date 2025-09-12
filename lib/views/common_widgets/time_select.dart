import 'package:flutter/material.dart';

class TreatmentTimePicker extends StatelessWidget {
  final String? selectedHour;
  final String? selectedMinute;
  final ValueChanged<String?> onHourChanged;
  final ValueChanged<String?> onMinuteChanged;

  const TreatmentTimePicker({
    super.key,
    this.selectedHour,
    this.selectedMinute,
    required this.onHourChanged,
    required this.onMinuteChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text("Treatment Time", style: theme.bodyLarge),
        const SizedBox(height: 8),

        // Dropdown Row
        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                hint: "Hour",
                value: selectedHour,
                items: List.generate(12, (i) => "${i + 1}"),
                onChanged: onHourChanged,
              ),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: _buildDropdown(
                hint: "Minutes",
                value: selectedMinute,
                items: List.generate(60, (i) => i.toString().padLeft(2, '0')),
                onChanged: onMinuteChanged,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String hint,
    required String? value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value?.isEmpty ?? true ? null : value,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade100,
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
      ),
      icon: const Icon(Icons.keyboard_arrow_down, color: Colors.green),
      items:
          items
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: const TextStyle(fontSize: 14, color: Colors.black),
                  ),
                ),
              )
              .toList(),
      onChanged: onChanged,
    );
  }
}
