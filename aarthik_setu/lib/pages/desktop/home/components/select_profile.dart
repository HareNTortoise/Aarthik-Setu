import 'package:aarthik_setu/constants/colors.dart';
import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../bloc/auth/auth_bloc.dart';
import '../../../../bloc/home/home_bloc.dart';
import '../../../../constants/app_constants.dart';
import '../../../../models/loan_applications/business/business_profile.dart';
import '../../../../models/loan_applications/personal/personal_profile.dart';
import 'add_profile.dart';

class ProfileTile extends StatelessWidget {
  const ProfileTile({
    super.key,
    required this.isPersonal,
    this.personalProfile,
    this.businessProfile,
  });

  final PersonalProfile? personalProfile;
  final BusinessProfile? businessProfile;
  final bool isPersonal;

  @override
  Widget build(BuildContext context) {
    final currentPersonalProfile = (context.read<HomeBloc>().state as HomeInitialized).currentPersonalProfile;
    final currentBusinessProfile = (context.read<HomeBloc>().state as HomeInitialized).currentBusinessProfile;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: double.infinity,
      height: 100,
      child: FilledButton.tonal(
        onPressed: () {
          if (isPersonal) {
            context.read<HomeBloc>().add(ChangePersonalProfile(personalProfile!.id!));
          } else {
            context.read<HomeBloc>().add(ChangeBusinessProfile(businessProfile!.id!));
          }
        },
        style: ButtonStyle(
          textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 20, color: Colors.black)),
          shape: WidgetStateProperty.all(
              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
          backgroundColor: WidgetStateProperty.all(
            isPersonal
                ? currentPersonalProfile.id != personalProfile!.id
                    ? AppColors.primaryColorTwo.withOpacity(0.5)
                    : AppColors.primaryColorOne.withOpacity(0.5)
                : currentBusinessProfile.id != businessProfile!.id
                    ? AppColors.primaryColorTwo.withOpacity(0.5)
                    : AppColors.primaryColorOne.withOpacity(0.5),
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isPersonal ? personalProfile!.name : businessProfile!.name,
                  style: GoogleFonts.poppins(fontSize: 22),
                ),
                const SizedBox(height: 10),
                Text(
                  'PAN Number : ${isPersonal ? personalProfile!.pan : businessProfile!.pan}',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.check_circle,
              color: isPersonal
                  ? currentPersonalProfile.id == personalProfile!.id
                      ? AppColors.primaryColorOne
                      : Colors.transparent
                  : currentBusinessProfile.id == businessProfile!.id
                      ? AppColors.primaryColorOne
                      : Colors.transparent,
              size: 30,
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                final String userId = (context.read<AuthBloc>().state as AuthSuccess).id;
                isPersonal
                    ? context
                        .read<HomeBloc>()
                        .add(DeletePersonalProfile(userId: userId, personalProfileId: personalProfile!.id!))
                    : context
                        .read<HomeBloc>()
                        .add(DeleteBusinessProfile(userId: userId, businessProfileId: businessProfile!.id!));
              },
              icon: const Icon(Icons.delete, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectProfile extends StatelessWidget {
  const SelectProfile({super.key, required this.isPersonal});

  final bool isPersonal;

  @override
  Widget build(BuildContext context) {
    return ResponsiveScaledBox(
      width: AppConstants.desktopScaleWidth,
      child: Dialog(
        child: SizedBox(
          width: 800,
          height: 800,
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              children: [
                Text('Select ${isPersonal ? 'Personal' : 'Business'} Profile',
                    style: GoogleFonts.poppins(fontSize: 42)),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state is HomeInitialized) {
                      final profiles = isPersonal ? state.personalProfiles : state.businessProfiles;
                      return Column(
                        children: [
                          for (final profile in profiles)
                            if (isPersonal)
                              ProfileTile(personalProfile: profile as PersonalProfile, isPersonal: isPersonal)
                            else
                              ProfileTile(businessProfile: profile as BusinessProfile, isPersonal: isPersonal),
                        ],
                      );
                    } else if (state is FetchingProfiles) {
                      return const Center(
                        child: SizedBox(
                          width: 100,
                          height: 100,
                          child: LoadingIndicator(
                            indicatorType: Indicator.orbit,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    } else {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text('Failed to fetch profiles', style: GoogleFonts.poppins(fontSize: 24)),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: IconButton(
                              onPressed: () {
                                final String userId = (context.read<AuthBloc>().state as AuthSuccess).id;
                                context.read<HomeBloc>().add(FetchProfiles(userId));
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(Colors.redAccent[100]),
                              ),
                              icon: const Icon(Icons.refresh, size: 40),
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                const Divider(),
                const SizedBox(height: 20),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 180,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          showDialog(context: context, builder: (_) => AddProfile(isPersonal: isPersonal));
                        },
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                          backgroundColor: WidgetStateProperty.all(Colors.redAccent[100]),
                          textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 20, color: Colors.white)),
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                        ),
                        child: const Text('Add Profile', style: TextStyle(fontSize: 20, color: Colors.black)),
                      ),
                    ),
                    SizedBox(
                      width: 180,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () => context.pop(),
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(const EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                          backgroundColor: WidgetStateProperty.all(Colors.redAccent[100]),
                          textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 20, color: Colors.white)),
                          shape: WidgetStateProperty.all(
                              const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20)))),
                        ),
                        child: Text(AppLocalizations.of(context)!.closeButton, style: const TextStyle(fontSize: 20)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
