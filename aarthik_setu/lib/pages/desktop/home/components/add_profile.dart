import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:aarthik_setu/global_components/labelled_text_field.dart';
import 'package:aarthik_setu/models/loan_applications/personal/personal_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';

import '../../../../bloc/auth/auth_bloc.dart';
import '../../../../bloc/home/home_bloc.dart';
import '../../../../models/loan_applications/business/business_profile.dart';

class AddProfile extends StatelessWidget {
  AddProfile({super.key, required this.isPersonal});

  final TextEditingController profileNameController = TextEditingController();
  final TextEditingController panNumberController = TextEditingController();
  final bool isPersonal;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Dialog(
        child: IntrinsicHeight(
          child: IntrinsicWidth(
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Add Profile', style: GoogleFonts.poppins(fontSize: 36)),
                  const SizedBox(height: 20),
                  LabelledTextField(
                    width: 400,
                    label: 'Profile Name',
                    hintText: 'Enter profile name',
                    controller: profileNameController,
                  ),
                  const SizedBox(height: 20),
                  LabelledTextField(
                    width: 400,
                    label: 'PAN Number',
                    hintText: 'Enter PAN number',
                    controller: panNumberController,
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FilledButton.tonal(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          final String userId = (context.read<AuthBloc>().state as AuthSuccess).id;
                          if (isPersonal) {
                            context.read<HomeBloc>().add(
                                  AddPersonalProfile(
                                    PersonalProfile(
                                      userId: userId,
                                      name: profileNameController.text,
                                      pan: panNumberController.text,
                                    ),
                                  ),
                                );
                          } else {
                            context.read<HomeBloc>().add(
                                  AddBusinessProfile(
                                    BusinessProfile(
                                      userId: userId,
                                      name: profileNameController.text,
                                      pan: panNumberController.text,
                                    ),
                                  ),
                                );
                          }
                        },
                        child: Text(
                          'Add Profile',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
