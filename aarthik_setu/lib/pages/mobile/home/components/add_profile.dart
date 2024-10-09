import 'package:aarthik_setu/constants/app_constants.dart';
import 'package:aarthik_setu/global_components/labelled_text_field.dart';
import 'package:aarthik_setu/models/loan_applications/personal/personal_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final size = MediaQuery.of(context).size;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Profile',
                style: GoogleFonts.poppins(fontSize: 24), // Smaller font size for mobile
              ),
              const SizedBox(height: 20),
              LabelledTextField(
                width: size.width * 0.85, // Adjust width based on mobile screen size
                label: 'Profile Name',
                hintText: 'Enter profile name',
                controller: profileNameController,
              ),
              const SizedBox(height: 20),
              LabelledTextField(
                width: size.width * 0.85,
                label: 'PAN Number',
                hintText: 'Enter PAN number',
                controller: panNumberController,
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
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
                      Navigator.of(context).pop(); // Close the dialog after adding
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
    );
  }
}
