class CoachInfo {
  final String firstName;
  final String lastName;
  final int age;
  final int experience;
  final String username;
  final String profileImageUrl;

  CoachInfo({
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.experience,
    required this.username,
    required this.profileImageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'age': age,
      'experience': experience,
      'username': username,
      'profileImageUrl': profileImageUrl,
    };
  }
} 