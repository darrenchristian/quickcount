import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/mayor_votes.dart';

// Data Model (CandidateChartData remains the same)
class CandidateChartData {
  CandidateChartData(
    this.candidateId,
    this.displayLabel,
    this.imagePath,
    this.votes,
  );
  final String candidateId;
  final String displayLabel;
  final String imagePath;
  final int votes;
}

class CandidateBarChart extends StatefulWidget {
  const CandidateBarChart({super.key});

  @override
  State<CandidateBarChart> createState() => _CandidateBarChartState();
}

class _CandidateBarChartState extends State<CandidateBarChart> {
  late List<CandidateChartData> _chartData;
  late TooltipBehavior _tooltipBehavior;
  late Future<bool> _loadingFuture;

  @override
  void initState() {
    super.initState();
    _loadingFuture = Future.delayed(const Duration(seconds: 2), () => true);

    // Calculate total votes for each candidate
    int jowarTotalVotes = JowarVotes.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );
    int ldlTotalVotes = LDLVotes.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    _chartData = [
      CandidateChartData(
        'Candidate 2', // This is LDL
        'LDL',
        'assets/images/ldl.jpg', // Ensure this path is correct & image exists
        ldlTotalVotes,
      ),
      CandidateChartData(
        'Candidate 1', // This is Jowar
        'JOWAR',
        'assets/images/jowar.jpg', // Ensure this path is correct & image exists
        jowarTotalVotes,
      ),
    ];

    // Sort based on votes (ascending order - lower votes first, higher votes last)
    // This places the candidate with more votes at the top of the chart
    _chartData.sort((a, b) => a.votes.compareTo(b.votes));

    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  // Helper function to parse hex color strings
  Color _hexToColor(String hexCode) {
    final hexValue = hexCode.replaceAll('#', '');
    return Color(int.parse('FF$hexValue', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    const double imageWidth = 10.0;
    const double spaceBetweenImageText = 5.0;
    const double averageTextWidth = 60.0;
    const double annotationPadding = 5.0;
    const double estimatedAnnotationWidth =
        imageWidth +
        spaceBetweenImageText +
        averageTextWidth +
        annotationPadding;
    const double plotOffsetValue = estimatedAnnotationWidth + 15;

    return Scaffold(
      backgroundColor: Colors.blue,
      body: FutureBuilder<bool>(
        future: _loadingFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover),
                ),
                Container(
                  color: Colors.black.withOpacity(
                    0.5,
                  ), // Semi-transparent overlay
                  child: const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 5,
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Loading...',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }

          return Stack(
            children: [
              Positioned.fill(child: Image.asset('assets/images/logo.png')),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      //row 1
                      Expanded(
                        flex: 3,
                        child: Container(
                          height: 300,
                          color: Colors.white,
                          child: SfCartesianChart(
                            title: ChartTitle(
                              text: 'MAYORAL VOTES FOR 2025',
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontFamily: GoogleFonts.montserrat().fontFamily,
                              ),
                            ),
                            primaryXAxis: CategoryAxis(
                              labelStyle: TextStyle(
                                fontSize: 0.01,
                                color: Colors.transparent,
                                fontFamily: GoogleFonts.montserrat().fontFamily,
                              ),
                              majorTickLines: const MajorTickLines(size: 0),
                              majorGridLines: const MajorGridLines(width: 0),
                              axisLine: const AxisLine(width: 0),
                            ),
                            primaryYAxis: NumericAxis(
                              minimum: 0,
                              title: const AxisTitle(text: 'Votes'),
                              plotOffset: plotOffsetValue,
                              labelStyle: TextStyle(
                                fontSize: 0.01,
                                color: Colors.transparent,
                                fontFamily: GoogleFonts.montserrat().fontFamily,
                              ),
                              majorGridLines: const MajorGridLines(width: 0),
                              majorTickLines: const MajorTickLines(size: 0),
                              axisLine: const AxisLine(width: 0),
                            ),
                            tooltipBehavior: _tooltipBehavior,
                            series: <
                              CartesianSeries<CandidateChartData, String>
                            >[
                              BarSeries<CandidateChartData, String>(
                                dataSource: _chartData,
                                xValueMapper:
                                    (CandidateChartData data, _) =>
                                        data.candidateId,
                                yValueMapper:
                                    (CandidateChartData data, _) => data.votes,
                                name: 'Votes',
                                borderRadius: BorderRadius.circular(8),
                                dataLabelSettings: DataLabelSettings(
                                  isVisible: true,
                                  textStyle: TextStyle(
                                    fontSize: 50,
                                    fontFamily:
                                        GoogleFonts.montserrat().fontFamily,
                                  ),
                                ),
                                dataLabelMapper:
                                    (CandidateChartData data, _) =>
                                        NumberFormat(
                                          '#,###',
                                        ).format(data.votes),

                                // === ADD POINT COLOR MAPPER HERE ===
                                pointColorMapper: (CandidateChartData data, _) {
                                  if (data.displayLabel == 'JOWAR BAUTISTA') {
                                    return _hexToColor(
                                      '0c2db8',
                                    ).withOpacity(0.8); // Deep Blue for Jowar
                                  } else if (data.displayLabel ==
                                      'L. DE LEON') {
                                    return Colors.red.withOpacity(
                                      0.8,
                                    ); // Red for LDL
                                  }
                                  return Colors
                                      .grey; // Default color if no match
                                },
                                // width: 0.8, // Optional: bar thickness
                              ),
                            ],
                            annotations: _buildAnnotations(),
                          ),
                        ),
                      ),

                      //row 2
                      Expanded(
                        flex: 2,
                        child: Container(height: 300, color: Colors.red),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<CartesianChartAnnotation> _buildAnnotations() {
    List<CartesianChartAnnotation> annotations = [];
    for (var dataItem in _chartData) {
      annotations.add(
        CartesianChartAnnotation(
          widget: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  width: 50,
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      dataItem.imagePath,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        print(
                          'Error loading image ${dataItem.imagePath}: $error',
                        );
                        return Icon(
                          Icons.broken_image,
                          size: 100,
                          color: Colors.grey[400],
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  dataItem.displayLabel,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                  ),
                ),
              ],
            ),
          ),
          coordinateUnit: CoordinateUnit.point,
          region: AnnotationRegion.plotArea,
          x: dataItem.candidateId,
          y: 0,
          horizontalAlignment: ChartAlignment.far,
          verticalAlignment: ChartAlignment.center,
        ),
      );
    }
    return annotations;
  }
}
