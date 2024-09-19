import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import '../../../l10n/l10n.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<L10nBloc, L10nState>(
      builder: (context, state) {
        return Container(
          alignment: Alignment.topRight,
          child: DropdownButtonHideUnderline(
            child: DropdownButton2<Locale>(
              customButton: Ink(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      L10nAll.languageNames[(state as L10n).locale.languageCode]!,
                      style: const TextStyle(color: Colors.black, fontSize: 18),
                    ),
                    const SizedBox(width: 20),
                    const Icon(LineIcons.language, color: Colors.black),
                  ],
                ),
              ),
              value: (state).locale,
              onChanged: (Locale? locale) {
                context.read<L10nBloc>().add(ChangeLocale(locale!));
              },
              items: L10nAll.all.map((Locale locale) {
                return DropdownMenuItem<Locale>(
                  value: locale,
                  child: Text(
                    L10nAll.languageNames[locale.languageCode]!,
                    style: GoogleFonts.poppins(color: Colors.black, fontSize: 21),
                  ),
                );
              }).toList(),
              style: const TextStyle(color: Colors.black, fontSize: 18),
              buttonStyleData: ButtonStyleData(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              selectedItemBuilder: (BuildContext context) {
                return L10nAll.all.map((Locale locale) {
                  return Center(
                    child: Text(
                      L10nAll.languageNames[locale.languageCode]!,
                      style: GoogleFonts.poppins(color: Colors.black, fontSize: 21),
                    ),
                  );
                }).toList();
              },
              dropdownStyleData: DropdownStyleData(
                maxHeight: 500,
                width: 200,
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
        );
      },
    );
  }
}
