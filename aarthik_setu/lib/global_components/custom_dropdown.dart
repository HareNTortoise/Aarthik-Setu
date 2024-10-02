import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDropdown extends StatelessWidget {
  CustomDropdown({
    super.key,
    required this.label,
    this.labelFontSize = 18,
    required this.buttonLabel,
    this.searchHintText = 'Search for an item...',
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
  final List<String> items;
  final String searchHintText;
  final TextEditingController _searchController = TextEditingController();

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
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey, width: 1.5),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          child: AutoSizeText(
                            current ?? buttonLabel,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(color: Colors.black),
                            maxLines: 1,
                            minFontSize: 14,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Icon(Icons.arrow_drop_down),
                      ],
                    ),
                  ),
                ),
              ),
              items: items
                  .map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item, style: GoogleFonts.poppins(color: Colors.black, fontSize: 18)),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
              buttonStyleData: ButtonStyleData(
                height: 60,
                width: 800,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              style: const TextStyle(color: Colors.black, fontSize: 18),
              menuItemStyleData: const MenuItemStyleData(height: 65),
              dropdownStyleData: DropdownStyleData(
                maxHeight: 500,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                offset: const Offset(-20, 0),
                scrollbarTheme: ScrollbarThemeData(
                  radius: const Radius.circular(40),
                  thickness: WidgetStateProperty.all(6),
                  thumbVisibility: WidgetStateProperty.all(true),
                ),
              ),
              dropdownSearchData: DropdownSearchData(
                searchController: _searchController,
                searchInnerWidgetHeight: 50,
                searchInnerWidget: Container(
                  height: 90,
                  padding: const EdgeInsets.all(15),
                  child: TextFormField(
                    expands: true,
                    maxLines: null,
                    controller: _searchController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: searchHintText,
                      hintStyle: const TextStyle(fontSize: 18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return item.value.toString().toLowerCase().contains(searchValue.toLowerCase());
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
