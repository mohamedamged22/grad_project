class TouristTravelInterestsModel {
  final List<String> travelInterests;

  TouristTravelInterestsModel({required this.travelInterests});

  factory TouristTravelInterestsModel.fromJson(Map<String, dynamic> json) {
    return TouristTravelInterestsModel(
      travelInterests: List<String>.from(json['travelInterests'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {"travelInterests": travelInterests};
}
