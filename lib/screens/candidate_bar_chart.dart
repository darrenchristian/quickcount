import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/candidate_chart_data.dart';

class CandidateBarChart extends StatefulWidget {
  const CandidateBarChart({
    super.key,
    required this.tooltipBehavior,
    required this.data,
    required this.pointColorMapper,
    required this.title,
    required this.height,
    this.withImage = false,
    required this.fontSize,
  });
  final TooltipBehavior tooltipBehavior;
  final List<CandidateChartData> data;
  final Function(String) pointColorMapper;
  final String title;
  final double height;
  final bool withImage;
  final double fontSize;

  @override
  State<CandidateBarChart> createState() => _CandidateBarChartState();
}

class _CandidateBarChartState extends State<CandidateBarChart> {
  @override
  Widget build(BuildContext context) {
    const double imageWidth = 5.0;
    const double spaceBetweenImageText = 7.0;
    const double averageTextWidth = 30.0;
    const double annotationPadding = 25.0;
    const double estimatedAnnotationWidth =
        imageWidth + spaceBetweenImageText + averageTextWidth + annotationPadding;
    const double plotOffsetValue = estimatedAnnotationWidth + 15;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightBlueAccent.withOpacity(0.7),
          borderRadius: BorderRadius.circular(16),
        ),
        child:
            //row 1
            Container(
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(16),
          ),
          child: SfCartesianChart(
            title: ChartTitle(
              text: widget.title,
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
            tooltipBehavior: widget.tooltipBehavior,
            series: <CartesianSeries<CandidateChartData, String>>[
              BarSeries<CandidateChartData, String>(
                dataSource: widget.data,
                xValueMapper: (CandidateChartData data, _) => data.candidateId,
                yValueMapper: (CandidateChartData data, _) => data.votes,
                name: 'Votes',
                borderRadius: BorderRadius.circular(8),
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(
                    fontSize: widget.fontSize,
                    fontFamily: GoogleFonts.montserrat().fontFamily,
                  ),
                ),
                dataLabelMapper: (CandidateChartData data, _) => NumberFormat(
                  '#,###',
                ).format(data.votes),

                // === ADD POINT COLOR MAPPER HERE ===
                pointColorMapper: (CandidateChartData data, _) {
                  return widget.pointColorMapper(data.color);
                },
                // width: 0.8, // Optional: bar thickness
              ),
            ],
            annotations: _buildAnnotations(),
          ),
        ),

        //row 2
      ),
    );
  }

  List<CartesianChartAnnotation> _buildAnnotations() {
    List<CartesianChartAnnotation> annotations = [];
    for (var dataItem in widget.data) {
      annotations.add(
        CartesianChartAnnotation(
          widget: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                (widget.withImage)
                    ? Container(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            dataItem.imagePath!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : Text(
                        "${dataItem.displayLabel}  ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.montserrat().fontFamily,
                        ),
                      ),
                if (widget.withImage)
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
