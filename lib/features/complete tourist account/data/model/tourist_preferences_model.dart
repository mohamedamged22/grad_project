class TouristPreferencesModel {
  final String specialNeeds;
  final List<String> travelPreferences;
  final String foodPreference;
  final String foodAllergies;
  final String notes;

  TouristPreferencesModel({
    required this.specialNeeds,
    required this.travelPreferences,
    required this.foodPreference,
    required this.foodAllergies,
    required this.notes,
  });

  factory TouristPreferencesModel.fromJson(Map<String, dynamic> json) {
    return TouristPreferencesModel(
      specialNeeds: json['specialNeeds'] ?? '',
      travelPreferences: List<String>.from(json['travelPreferences'] ?? []),
      foodPreference: json['foodPreference'] ?? '',
      foodAllergies: json['foodAllergies'] ?? '',
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    "specialNeeds": specialNeeds,
    "travelPreferences": travelPreferences,
    "foodPreference": foodPreference,
    "foodAllergies": foodAllergies,
    "notes": notes,
  };
}
