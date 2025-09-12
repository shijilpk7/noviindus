import 'package:flutter/material.dart';
import 'package:noviindus/utils/app_colors.dart';

class CustomDropdown extends StatelessWidget {
  final String? label;
  final String? hint;
  final List<String> items;
  final String? selectedItem;
  final ValueChanged<String?> onChanged;
  final String? Function(String?)? validator;
  final bool? clearbutton;
  final VoidCallback? onClear;

  const CustomDropdown({
    super.key,
    this.label,
    this.hint,
    required this.items,
    this.selectedItem,
    required this.onChanged,
    this.validator,
    this.clearbutton = false,
    this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(label!, style: theme.bodyLarge),
          const SizedBox(height: 8),
        ],
        DropdownButtonFormField<String>(
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (clearbutton!) ...{
                InkWell(
                  onTap: onClear ?? () {},
                  child: const Icon(Icons.clear, color: Colors.red),
                ),
                const SizedBox(width: 5),
              },
              const Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.buttonGreen,
              ),
            ],
          ),
          initialValue: selectedItem?.isEmpty ?? true ? null : selectedItem,
          hint: Text(hint ?? "", style: theme.bodyMedium),
          items:
              items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 1.275,
                        color: AppColors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
          validator: validator,
          onChanged: onChanged,
          dropdownColor: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(6),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: theme.bodyMedium,
            filled: true,
            fillColor: Colors.grey.shade100,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}
