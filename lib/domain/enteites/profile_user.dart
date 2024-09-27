class UserProfile {
  String userName;
  String email;
  String profileImage;
  double height;
  double weight;
  int age;

  UserProfile({
    required this.userName,
    required this.email,
    required this.profileImage,
    required this.height,
    required this.weight,
    required this.age,
  });

  // Convert height and weight for metric system
  String get heightMetric => "${(height * 100).toStringAsFixed(1)} cm";
  String get weightMetric => "${weight.toStringAsFixed(1)} kg";

  // Convert height and weight for imperial system
  String get heightImperial {
    final inches = (height * 39.37).toInt();
    final feet = inches ~/ 12;
    final remainderInches = inches % 12;
    return "$feet' $remainderInches\"";
  }

  String get weightImperial => "${(weight * 2.20462).toStringAsFixed(1)} lbs";
}
