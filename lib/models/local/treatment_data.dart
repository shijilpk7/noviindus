class TreatmentData {
  final String name;
  final int? id;
  int maleCount;
  int femaleCount;

  TreatmentData({
    required this.name,
    required this.id,
    this.maleCount = 0,
    this.femaleCount = 0,
  });
}
