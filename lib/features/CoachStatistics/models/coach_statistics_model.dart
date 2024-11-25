class CoachStatisticsModel {
  final int trainees;
  final int newTrainees;
  final double income;
  final Map<String, int> ageDistribution;

  CoachStatisticsModel({
    this.trainees = 0,
    this.newTrainees = 0,
    this.income = 0.0,
    this.ageDistribution = const {
      '18-25': 0,
      '26-35': 0,
      '36-45': 0,
      '46+': 0,
    },
  });
} 