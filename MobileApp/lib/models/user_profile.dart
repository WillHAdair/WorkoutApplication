class UserProfile {
  int id;
  double height;
  double weight;
  double maintenanceCalories;
  DateTime lastUpdated;

  UserProfile({
    required this.id,
    required this.height,
    required this.weight,
    required this.maintenanceCalories,
    required this.lastUpdated,
  });
}

extension UserProfileCopyWith on UserProfile {
  UserProfile copyWith({
    int? id,
    double? height,
    double? weight,
    double? maintenanceCalories,
    DateTime? lastUpdated,
  }) {
    return UserProfile(
      id: id ?? this.id,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      maintenanceCalories: maintenanceCalories ?? this.maintenanceCalories,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}