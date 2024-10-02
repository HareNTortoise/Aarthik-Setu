import 'package:aarthik_setu/constants/colors.dart';
import 'package:aarthik_setu/pages/desktop/forms/business_loans/components/declare_business.dart';
import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dropzone/flutter_dropzone.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../bloc/l10n/l10n_bloc.dart';
import '../../../../constants/app_constants.dart';
import '../../../../global_components/language_dropdown.dart';
import 'components/enter_gst_credentials.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class GSTDetailsForm extends StatefulWidget {
  const GSTDetailsForm({super.key});

  @override
  State<GSTDetailsForm> createState() => _GSTDetailsFormState();
}

class _GSTDetailsFormState extends State<GSTDetailsForm> {
  DropzoneViewController? dropZoneController;
  FilePickerResult? result;
  bool _haveGST = true;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Localizations.override(
        context: context,
        locale: (context.watch<L10nBloc>().state as L10n).locale,
        child: BlocBuilder<L10nBloc, L10nState>(
          builder: (context, state) {
            return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100.0),
            child: SizedBox.expand(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 30),
                    const LanguageDropdown(),
                    Text(
                      AppLocalizations.of(context)!.gstDetailsTitle,
                      style: GoogleFonts.poppins(fontSize: 80),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 350,
                      height: 100,
                      child: AnimatedToggleSwitch<bool>.dual(
                        current: _haveGST,
                        first: false,
                        second: true,
                        borderWidth: 10,
                        textBuilder: (index) => index == true
                            ? Text(
                          AppLocalizations.of(context)!.toggleEnterGst,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 24,
                                ),
                              )
                            : Text(
                          AppLocalizations.of(context)!.toggleDeclareBusiness,
                                style: GoogleFonts.poppins(
                                  color: Colors.black,
                                  fontSize: 22,
                                ),
                              ),
                        indicatorSize: const Size.fromWidth(85),
                        style: ToggleStyle(
                          backgroundColor: Colors.grey[200],
                          borderRadius: BorderRadius.circular(50),
                          borderColor: Colors.transparent,
                          boxShadow: [
                            const BoxShadow(
                              color: Colors.black26,
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 1.5),
                            ),
                          ],
                        ),
                        styleBuilder: (index) => index == true
                            ? ToggleStyle(indicatorColor: AppColors.primaryColorOne)
                            : ToggleStyle(indicatorColor: AppColors.primaryColorTwo),
                        iconBuilder: (index) => index == true
                            ? const Icon(
                                Icons.business,
                                size: 30,
                                color: Colors.white,
                              )
                            : const Icon(
                                Icons.edit,
                                size: 30,
                              ),
                        onChanged: (value) {
                          setState(() {
                            _haveGST = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 60),
                    IntrinsicHeight(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        margin: const EdgeInsets.only(bottom: 100),
                        width: 1200,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 7,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: _haveGST
                            ? const EnterGSTCredentials()
                            : const DeclareBusiness(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
          },
        ),
      ),
    );
  }
}
