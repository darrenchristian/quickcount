import 'package:flutter/material.dart';
import 'candidate_bar_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/mayor_votes.dart';
import '../models/candidate_chart_data.dart';
import '../data/councilor_votes.dart';
import '../data/cong_and_bm.dart';

class QuickCount extends StatefulWidget {
  const QuickCount({super.key});

  @override
  State<QuickCount> createState() => _QuickCountState();
}

class _QuickCountState extends State<QuickCount> {
  late List<CandidateChartData> _mayorData;
  late List<CandidateChartData> _viceMayorData;
  late List<CandidateChartData> _councilorData;
  late TooltipBehavior _tooltipBehavior;
  late Future<bool> _loadingFuture;
  late List<CandidateChartData> _congData;
  late List<CandidateChartData> _bmData;
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

    int arvinTotalVotes = ArvinVotes.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );
    int ocaTotalVotes = OcaVotes.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    //councilor

    int c1_votes = C1_Bong.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c2_votes = C2_Darwin.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c3_votes = C3_Bino.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c4_votes = C4_Blem.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c5_votes = C5_Jemjem.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c6_votes = C6_Patay.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c7_votes = C7_Tantan.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c8_votes = C8_Mars.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c9_votes = C9_Resty.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c10_votes = C10_Eddie.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c11_votes = C11_Jelo.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c12_votes = C12_Osorio.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c13_votes = C13_Wowie.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c14_votes = C14_JP.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c15_votes = C15_Andro.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c16_votes = C16_Nerio.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int c17_votes = C17_William.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    print("C1_Bong: $c1_votes");
    print("C2_Darwin: $c2_votes");
    print("C3_Bino: $c3_votes");
    print("C4_Blem: $c4_votes");
    print("C5_Jemjem: $c5_votes");
    print("C6_Patay: $c6_votes");
    print("C7_Tantan: $c7_votes");
    print("C8_Mars: $c8_votes");
    print("C9_Resty: $c9_votes");
    print("C10_Eddie: $c10_votes");
    print("C11_Jelo: $c11_votes");
    print("C12_Osorio: $c12_votes");
    print("C13_Wowie: $c13_votes");
    print("C14_JP: $c14_votes");
    print("C15_Andro: $c15_votes");
    print("C16_Nerio: $c16_votes");
    print("C17_William: $c17_votes");

    //congressman

    int cong1_votes = CongPleyto.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    // board members

    int bm1_votes = bm1_angel.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int bm2_votes = bm2_jay.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int bm3_votes = bm3_mary.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int bm4_votes = bm4_art.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int bm5_votes = bm5_doc.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    int bm6_votes = bm6_marissa.fold(
      0,
      (sum, item) => sum + (item['votes'] as int),
    );

    _mayorData = [
      CandidateChartData(
        'Candidate 2', // This is LDL
        'LDL',
        'assets/images/ldl.jpg', // Ensure this path is correct & image exists
        ldlTotalVotes,
        'ff0000',
      ),
      CandidateChartData(
        'Candidate 1', // This is Jowar
        'JOWAR',
        'assets/images/jowar.jpg', // Ensure this path is correct & image exists
        jowarTotalVotes,
        '0c2db8',
      ),
    ];

    // vice mayor
    _viceMayorData = [
      CandidateChartData(
        'Candidate 1',
        'ARVIN',
        'assets/images/arvin.jpg',
        arvinTotalVotes,
        '0c2db8',
      ),
      CandidateChartData(
        'Candidate 2',
        'OCA',
        'assets/images/oca.jpg',
        ocaTotalVotes,
        'FF0000',
      ),
    ];

    // councilor
    _councilorData = [
      CandidateChartData(
        'COUNCILOR 1',
        'BONG',
        '',
        c1_votes,
        'FF0000',
      ),
      CandidateChartData(
        'Candidate 2',
        'DARWIN',
        '',
        c2_votes,
        '0c2db8',
      ),
      CandidateChartData(
        'Candidate 3',
        'BINO',
        '',
        c3_votes,
        'FF0000',
      ),
      CandidateChartData(
        'Candidate 4',
        'BLEM',
        '',
        c4_votes,
        '0c2db8',
      ),
      CandidateChartData(
        'Candidate 5',
        'JEMJEM',
        '',
        c5_votes,
        'FF0000',
      ),
      CandidateChartData(
        'Candidate 6',
        'PATAY',
        '',
        c6_votes,
        'FF0000',
      ),
      CandidateChartData(
        'Candidate 7',
        'TANTAN',
        '',
        c7_votes,
        '008000',
      ),
      CandidateChartData(
        'Candidate 8',
        'MARS',
        '',
        c8_votes,
        'FF0000',
      ),
      CandidateChartData(
        'Candidate 9',
        'RESTY',
        '',
        c9_votes,
        'FF0000',
      ),
      CandidateChartData(
        'Candidate 10',
        'EDDIE',
        '',
        c10_votes,
        'FF0000',
      ),
      CandidateChartData(
        'Candidate 11',
        'JELO',
        '',
        c11_votes,
        'FF0000',
      ),
      CandidateChartData(
        'Candidate 12',
        'RAMIRO',
        '',
        c12_votes,
        '0c2db8',
      ),
      CandidateChartData(
        'Candidate 13',
        'WOWIE',
        '',
        c13_votes,
        '0c2db8',
      ),
      CandidateChartData(
        'Candidate 14',
        'JP',
        '',
        c14_votes,
        '0c2db8',
      ),
      CandidateChartData(
        'Candidate 15',
        'ANDRO',
        '',
        c15_votes,
        '0c2db8',
      ),
      CandidateChartData(
        'Candidate 16',
        'NERIO',
        '',
        c16_votes,
        '0c2db8',
      ),
      CandidateChartData(
        'Candidate 17',
        'WILLIAM',
        '',
        c17_votes,
        '0c2db8',
      ),
    ];

    //congressman
    _congData = [
      CandidateChartData(
        'Candidate 1', // This is LDL
        'PLEYTO',
        'assets/images/ldl.jpg', // Ensure this path is correct & image exists
        cong1_votes,
        '0c2db8',
      ),
    ];

    //board members
    _bmData = [
      CandidateChartData(
        'Candidate 1', // This is LDL
        'ANGEL',
        '', // Ensure this path is correct & image exists
        bm1_votes,
        'FF0000',
      ),
      CandidateChartData(
        'Candidate 2', // This is LDL
        'JAY',
        '', // Ensure this path is correct & image exists
        bm2_votes,
        '0c2db8',
      ),
      CandidateChartData(
        'Candidate 3', // This is LDL
        'MARY JANE',
        'assets/images/ldl.jpg', // Ensure this path is correct & image exists
        bm3_votes,
        '008000',
      ),
      CandidateChartData(
        'Candidate 4', // This is LDL
        'ART',
        '', // Ensure this path is correct & image exists
        bm4_votes,
        '0c2db8',
      ),
      CandidateChartData(
        'Candidate 5', // This is LDL
        'DOC',
        '', // Ensure this path is correct & image exists
        bm5_votes,
        '008000',
      ),
      CandidateChartData(
        'Candidate 6', // This is LDL
        'MARISSA',
        '', // Ensure this path is correct & image exists
        bm6_votes,
        '008000',
      ),
    ];
    // Sort based on votes (ascending order - lower votes first, higher votes last)
    // This places the candidate with more votes at the top of the chart
    _mayorData.sort((a, b) => a.votes.compareTo(b.votes));
    _viceMayorData.sort((a, b) => a.votes.compareTo(b.votes));
    _councilorData.sort((a, b) => a.votes.compareTo(b.votes));
    _congData.sort((a, b) => a.votes.compareTo(b.votes));
    _bmData.sort((a, b) => a.votes.compareTo(b.votes));

    _tooltipBehavior = TooltipBehavior(enable: true);
  }

  // Helper function to parse hex color strings
  Color _hexToColor(String hexCode) {
    final hexValue = hexCode.replaceAll('#', '');
    return Color(int.parse('FF$hexValue', radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<bool>(
        future: _loadingFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
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
                            'Calculating...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          }

          return Container(
            color: Colors.lightBlueAccent,
            height: MediaQuery.of(context).size.height,
            child: Stack(children: [
              Positioned.fill(child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover)),
              Container(
                child: Column(
                  children: [
                    //row 1: mayor and vice mayor
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        //mayor
                        Expanded(
                          flex: 1,
                          child: CandidateBarChart(
                            tooltipBehavior: _tooltipBehavior,
                            data: _mayorData,
                            pointColorMapper: _hexToColor,
                            title: 'MAYOR 2025',
                            height: 300,
                            withImage: true,
                            fontSize: 30,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CandidateBarChart(
                            tooltipBehavior: _tooltipBehavior,
                            data: _viceMayorData,
                            pointColorMapper: _hexToColor,
                            title: 'VICE MAYOR 2025',
                            height: 300,
                            withImage: true,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                    //row 2: councilor
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 1,
                          child: CandidateBarChart(
                            tooltipBehavior: _tooltipBehavior,
                            data: _councilorData,
                            pointColorMapper: _hexToColor,
                            title: 'COUNCILOR 2025',
                            height: 680,
                            fontSize: 16,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CandidateBarChart(
                                tooltipBehavior: _tooltipBehavior,
                                data: _congData,
                                pointColorMapper: _hexToColor,
                                title: 'CONGRESSMAN 2025',
                                height: 200,
                                fontSize: 25,
                              ),
                              CandidateBarChart(
                                tooltipBehavior: _tooltipBehavior,
                                data: _bmData,
                                pointColorMapper: _hexToColor,
                                title: 'BOARD MEMBERS 2025',
                                height: 350,
                                fontSize: 20,
                              ),
                              CandidateBarChart(
                                tooltipBehavior: _tooltipBehavior,
                                data: _congData,
                                pointColorMapper: _hexToColor,
                                title: 'PARTYLIST 2025',
                                height: 120,
                                fontSize: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          );
        },
      ),
    );
  }
}
