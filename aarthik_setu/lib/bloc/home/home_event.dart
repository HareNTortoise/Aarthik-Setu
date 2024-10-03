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

class AddPersonalProfile extends HomeEvent {
  final PersonalProfile personalProfile;

  AddPersonalProfile(this.personalProfile);
}

class AddBusinessProfile extends HomeEvent {
  final BusinessProfile businessProfile;

  AddBusinessProfile(this.businessProfile);
}

class DeletePersonalProfile extends HomeEvent {
  final String userId;
  final String personalProfileId;

  DeletePersonalProfile({required this.personalProfileId, required this.userId});
}

class DeleteBusinessProfile extends HomeEvent {
  final String userId;
  final String businessProfileId;

  DeleteBusinessProfile({required this.businessProfileId, required this.userId});
}
