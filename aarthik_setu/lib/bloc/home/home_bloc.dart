import 'package:aarthik_setu/models/loan_applications/business/business_profile.dart';
import 'package:aarthik_setu/models/loan_applications/personal/personal_profile.dart';
import 'package:aarthik_setu/repository/personal_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../repository/business_profile.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final PersonalProfileRepository personalProfileRepository;
  final BusinessProfileRepository businessProfileRepository;
  final Logger _logger = Logger();

  HomeBloc({required this.personalProfileRepository, required this.businessProfileRepository}) : super(HomeInitial()) {
    on<FetchProfiles>((event, emit) async {
      emit(FetchingProfiles());
      try {
        final List<PersonalProfile> personalProfiles = await personalProfileRepository.getProfile(event.userId);
        final List<BusinessProfile> businessProfiles = await businessProfileRepository.getProfile(event.userId);

        _logger.i('Fetched business profiles: $businessProfiles');
        _logger.i('Fetched personal profiles: $personalProfiles');

        emit(HomeInitialized(
          personalProfileIds: personalProfiles,
          businessProfileIds: businessProfiles,
          currentPersonalProfile: personalProfiles.first,
          currentBusinessProfile: businessProfiles.first,
        ));
      } catch (e) {
        emit(FetchingProfileFailed(e.toString()));
      }
    });

    on<ChangePersonalProfile>((event, emit) {
      emit(HomeInitialized(
        personalProfileIds: (state as HomeInitialized).personalProfileIds,
        businessProfileIds: (state as HomeInitialized).businessProfileIds,
        currentPersonalProfile: (state as HomeInitialized)
            .personalProfileIds
            .firstWhere((element) => element.id == event.newPersonalProfileId),
        currentBusinessProfile: (state as HomeInitialized).currentBusinessProfile,
      ));
    });

    on<ChangeBusinessProfile>((event, emit) {
      emit(HomeInitialized(
        personalProfileIds: (state as HomeInitialized).personalProfileIds,
        businessProfileIds: (state as HomeInitialized).businessProfileIds,
        currentPersonalProfile: (state as HomeInitialized).currentPersonalProfile,
        currentBusinessProfile: (state as HomeInitialized)
            .businessProfileIds
            .firstWhere((element) => element.id == event.newBusinessProfileId),
      ));
    });
  }
}
