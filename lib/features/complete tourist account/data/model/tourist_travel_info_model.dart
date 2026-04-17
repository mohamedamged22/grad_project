class TouristTravelInfoModel {
  final String travelDateFrom;
  final String travelDateTo;
  final String destinationCity;
  final String tripType;
  final int numberOfTravelers;

  TouristTravelInfoModel({
    required this.travelDateFrom,
    required this.travelDateTo,
    required this.destinationCity,
    required this.tripType,
    required this.numberOfTravelers,
  });

  factory TouristTravelInfoModel.fromJson(Map<String, dynamic> json) {
    return TouristTravelInfoModel(
      travelDateFrom: json['travelDateFrom'] ?? '',
      travelDateTo: json['travelDateTo'] ?? '',
      destinationCity: json['destinationCity'] ?? '',
      tripType: json['tripType'] ?? '',
      numberOfTravelers: json['numberOfTravelers'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
    "travelDateFrom": travelDateFrom,
    "travelDateTo": travelDateTo,
    "destinationCity": destinationCity,
    "tripType": tripType,
    "numberOfTravelers": numberOfTravelers,
  };
}
