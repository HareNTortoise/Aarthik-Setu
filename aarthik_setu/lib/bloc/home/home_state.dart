part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class FetchingProfiles extends HomeState {}

final class HomeInitialized extends HomeState {
  final List<PersonalProfile> personalProfiles;
  final List<BusinessProfile> businessProfiles;
  final PersonalProfile currentPersonalProfile;
  final BusinessProfile currentBusinessProfile;

  HomeInitialized({
    required this.personalProfiles,
    required this.businessProfiles,
    required this.currentPersonalProfile,
    required this.currentBusinessProfile,
  });
}

final class FetchingProfileFailed extends HomeState {
  final String errorMessage;

  FetchingProfileFailed(this.errorMessage);
}
