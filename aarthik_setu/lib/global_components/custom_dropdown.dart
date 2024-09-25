import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown({
    super.key,
    required this.label,
    required this.labelFontSize,
    required this.buttonLabel,
    this.current,
    this.width = 300,
    this.height = 65,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String buttonLabel;
  final double width;
  final double height;
  final double labelFontSize;
  final String? current;
  final Function(String?)? onChanged;
  final List<DropdownMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(fontSize: labelFontSize),
        ),
        const SizedBox(height: 5),
        SizedBox(
          width: width,
          height: height,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              customButton: Material(
                child: InkWell(
                  child: Ink(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey, width: 1.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          current ?? buttonLabel,
                          style: const TextStyle(color: Colors.black, fontSize: 18),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ),
              items: items,
              onChanged: onChanged,
              buttonStyleData: ButtonStyleData(
                height: 60,
                width: 800,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              style: const TextStyle(color: Colors.black, fontSize: 18),
              menuItemStyleData: const MenuItemStyleData(height: 65),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 500,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                offset: const Offset(-20, 0),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: WidgetStateProperty.all(6),
                  thumbVisibility: WidgetStateProperty.all(true),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
