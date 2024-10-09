import 'package:aarthik_setu/constants/colors.dart';
import 'package:aarthik_setu/bloc/l10n/l10n_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_indicator/loading_indicator.dart';
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
      height: 80, // Smaller height for mobile
      child: ElevatedButton(
        onPressed: () {
          if (isPersonal) {
            context.read<HomeBloc>().add(ChangePersonalProfile(personalProfile!.id!));
          } else {
            context.read<HomeBloc>().add(ChangeBusinessProfile(businessProfile!.id!));
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: isPersonal
              ? currentPersonalProfile.id != personalProfile!.id
              ? AppColors.primaryColorTwo.withOpacity(0.5)
              : AppColors.primaryColorOne.withOpacity(0.5)
              : currentBusinessProfile.id != businessProfile!.id
              ? AppColors.primaryColorTwo.withOpacity(0.5)
              : AppColors.primaryColorOne.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Slightly reduced radius for mobile
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
                  style: GoogleFonts.poppins(fontSize: 18), // Smaller font for mobile
                ),
                const SizedBox(height: 8),
                Text(
                  'PAN Number: ${isPersonal ? personalProfile!.pan : businessProfile!.pan}',
                  style: GoogleFonts.poppins(fontSize: 14), // Smaller font for mobile
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
              size: 25, // Adjust icon size for mobile
            ),
            const SizedBox(width: 8),
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
              icon: const Icon(Icons.delete, size: 25), // Adjust icon size for mobile
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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select ${isPersonal ? 'Personal' : 'Business'} Profile',
          style: GoogleFonts.poppins(fontSize: 24),
        ),
        backgroundColor: AppColors.primaryColorOne,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16), // Adjusted padding for mobile
        child: Column(
          children: [
            BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                if (state is HomeInitialized) {
                  final profiles = isPersonal ? state.personalProfiles : state.businessProfiles;
                  return Expanded(
                    child: ListView.builder(
                      itemCount: profiles.length,
                      itemBuilder: (context, index) {
                        final profile = profiles[index];
                        return isPersonal
                            ? ProfileTile(personalProfile: profile as PersonalProfile, isPersonal: isPersonal)
                            : ProfileTile(businessProfile: profile as BusinessProfile, isPersonal: isPersonal);
                      },
                    ),
                  );
                } else if (state is FetchingProfiles) {
                  return const Center(
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: LoadingIndicator(
                        indicatorType: Indicator.orbit,
                        strokeWidth: 2,
                      ),
                    ),
                  );
                } else {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Failed to fetch profiles', style: GoogleFonts.poppins(fontSize: 20)),
                        const SizedBox(height: 20),
                        IconButton(
                          onPressed: () {
                            final String userId = (context.read<AuthBloc>().state as AuthSuccess).id;
                            context.read<HomeBloc>().add(FetchProfiles(userId));
                          },
                          icon: const Icon(Icons.refresh, size: 40),
                          color: Colors.redAccent[100],
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                showDialog(context: context, builder: (_) => AddProfile(isPersonal: isPersonal));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent[100],
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: const Text('Add Profile', style: TextStyle(fontSize: 18, color: Colors.black)),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => context.pop(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent[100],
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(AppLocalizations.of(context)!.closeButton, style: const TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
