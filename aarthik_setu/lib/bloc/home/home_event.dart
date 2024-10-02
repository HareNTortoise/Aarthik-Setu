part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class ChangePersonalProfile extends HomeEvent {
  final String newPersonalProfileId;

  ChangePersonalProfile(this.newPersonalProfileId);
}

class ChangeBusinessProfile extends HomeEvent {
  final String newBusinessProfileId;

  ChangeBusinessProfile(this.newBusinessProfileId);
}

class FetchProfiles extends HomeEvent {
  final String userId;

  FetchProfiles(this.userId);
}
