class CandidateChartData {
  CandidateChartData(
    this.candidateId,
    this.displayLabel,
    this.imagePath,
    this.votes,
    this.color,
  );

  final String candidateId; // Unique identifier for the bar, e.g., "Candidate 1"
  final String displayLabel; // Text label like "Jowar" or "LDL"
  final String? imagePath; // Path to the asset image
  final num votes; // The value for the bar
  final String color;
}
