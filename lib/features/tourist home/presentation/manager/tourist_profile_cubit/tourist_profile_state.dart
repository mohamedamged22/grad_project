abstract class TouristProfileState {
  const TouristProfileState();
}

class TouristProfileInitial extends TouristProfileState {}

class TouristProfileLoading extends TouristProfileState {}

class TouristProfileLoaded extends TouristProfileState {
  final Map<String, dynamic> profileData;

  const TouristProfileLoaded(this.profileData);
}

class TouristProfileUpdateSuccess extends TouristProfileState {
  final String message;
  const TouristProfileUpdateSuccess(this.message);
}

class TouristProfileError extends TouristProfileState {
  final String message;

  const TouristProfileError(this.message);
}
