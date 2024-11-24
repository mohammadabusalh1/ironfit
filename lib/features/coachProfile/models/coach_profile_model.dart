class CoachProfileModel {
  String? fullName;
  String imageUrl;
  String email;
  String coachId;
  bool isLoading;
  bool isDataLoaded;

  CoachProfileModel({
    this.fullName,
    this.imageUrl = '',
    this.email = '',
    required this.coachId,
    this.isLoading = true,
    this.isDataLoaded = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'imageUrl': imageUrl,
      'email': email,
      'coachId': coachId,
    };
  }

  factory CoachProfileModel.fromJson(Map<String, dynamic> json) {
    return CoachProfileModel(
      fullName: json['fullName'],
      imageUrl: json['imageUrl'] ?? '',
      email: json['email'] ?? '',
      coachId: json['coachId'],
    );
  }
} 