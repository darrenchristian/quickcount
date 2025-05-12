import 'package:flutter/material.dart';
import 'candidate_bar_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/mayor_votes.dart';
import '../models/candidate_chart_data.dart';
import '../data/councilor_votes.dart';
import '../data/cong_and_bm.dart';
import '../data/party_list.dart';
import '../models/barangay_votes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

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
  late List<CandidateChartData> _partyListData;

  Future<void> getVotes() async {
    try {
      final response = await supabase.from('votes').select('*');
      List<BarangayVotes> barangayVotes =
          response.map((json) => BarangayVotes.fromJson(json)).toList();

      // Calculate total votes for all candidate types
      Map<String, int> totalVotes = {};

      // Process each candidate
      for (var vote in barangayVotes) {
        if (!totalVotes.containsKey(vote.candidate)) {
          totalVotes[vote.candidate] = 0;
        }
        totalVotes[vote.candidate] = (totalVotes[vote.candidate] ?? 0) + vote.votes;
      }

      // Print vote counts for debugging
      totalVotes.forEach((candidate, votes) {
        print("$candidate: $votes votes");
      });

      // Update UI with new data
      setState(() {
        // Mayor data
        _mayorData = [
          CandidateChartData(
            'Candidate 2',
            'LDL',
            'assets/images/ldl.jpg',
            totalVotes['m2_ldl'] ?? 0,
            'ff0000',
          ),
          CandidateChartData(
            'Candidate 1',
            'JOWAR',
            'assets/images/jowar.jpg',
            totalVotes['m1_jowar'] ?? 0,
            '0c2db8',
          ),
        ];

        // Vice Mayor data
        _viceMayorData = [
          CandidateChartData(
            'Candidate 1',
            'ARVIN',
            'assets/images/arvin.jpg',
            totalVotes['v1_arvin'] ?? 0,
            '0c2db8',
          ),
          CandidateChartData(
            'Candidate 2',
            'OCA',
            'assets/images/oca.jpg',
            totalVotes['v2_oca'] ?? 0,
            'FF0000',
          ),
        ];

        // Councilor data
        _councilorData = [
          CandidateChartData('COUNCILOR 1', 'BONG', '', totalVotes['c1_bong'] ?? 0, 'FF0000'),
          CandidateChartData('COUNCILOR 2', 'DARWIN', '', totalVotes['c2_darwin'] ?? 0, '0c2db8'),
          CandidateChartData('COUNCILOR 3', 'BINO', '', totalVotes['c3_bino'] ?? 0, 'FF0000'),
          CandidateChartData('COUNCILOR 4', 'BLEM', '', totalVotes['c4_blem'] ?? 0, '0c2db8'),
          CandidateChartData('COUNCILOR 5', 'JEMJEM', '', totalVotes['c5_jemjem'] ?? 0, 'FF0000'),
          CandidateChartData('COUNCILOR 6', 'PATAY', '', totalVotes['c6_patay'] ?? 0, 'FF0000'),
          CandidateChartData('COUNCILOR 7', 'TANTAN', '', totalVotes['c7_tantan'] ?? 0, '008000'),
          CandidateChartData('COUNCILOR 8', 'MARS', '', totalVotes['c8_mars'] ?? 0, 'FF0000'),
          CandidateChartData('COUNCILOR 9', 'RESTY', '', totalVotes['c9_resty'] ?? 0, 'FF0000'),
          CandidateChartData('COUNCILOR 10', 'EDDIE', '', totalVotes['c10_eddie'] ?? 0, 'FF0000'),
          CandidateChartData('COUNCILOR 11', 'JELO', '', totalVotes['c11_jelo'] ?? 0, 'FF0000'),
          CandidateChartData('COUNCILOR 12', 'RAMIRO', '', totalVotes['c12_ramiro'] ?? 0, '0c2db8'),
          CandidateChartData('COUNCILOR 13', 'WOWIE', '', totalVotes['c13_wowie'] ?? 0, '0c2db8'),
          CandidateChartData('COUNCILOR 14', 'JP', '', totalVotes['c14_jp'] ?? 0, '0c2db8'),
          CandidateChartData('COUNCILOR 15', 'ANDRO', '', totalVotes['c15_andro'] ?? 0, '0c2db8'),
          CandidateChartData('COUNCILOR 16', 'NERIO', '', totalVotes['c16_nerio'] ?? 0, '0c2db8'),
          CandidateChartData(
            'COUNCILOR 17',
            'WILLIAM',
            '',
            totalVotes['c17_william'] ?? 0,
            '0c2db8',
          ),

          // Add other councilors similarly
        ];

        // Congressman data
        _congData = [
          CandidateChartData(
            'Candidate 1',
            'PLEYTO',
            'assets/images/pleyto.jpg',
            totalVotes['cn1_pleyto'] ?? 0,
            '0c2db8',
          ),
        ];

        // Board member data
        _bmData = [
          CandidateChartData('Candidate 1', 'ANGEL', '', totalVotes['bm1_angel'] ?? 0, 'FF0000'),
          CandidateChartData('Candidate 2', 'JAY', '', totalVotes['bm2_jay'] ?? 0, '0c2db8'),
          CandidateChartData('Candidate 3', 'MARY', '', totalVotes['bm3_mary'] ?? 0, 'FF0000'),
          CandidateChartData('Candidate 4', 'ART', '', totalVotes['bm4_art'] ?? 0, '0c2db8'),
          CandidateChartData('Candidate 5', 'DOC', '', totalVotes['bm5_doc'] ?? 0, 'FF0000'),
          CandidateChartData('Candidate 6', 'MARISA', '', totalVotes['bm6_marisa'] ?? 0, '0c2db8'),
          // Add other board members similarly
        ];

        // Party list data
        _partyListData = [
          CandidateChartData(
            'Candidate 1',
            'APATDAPAT',
            '',
            totalVotes['p48_apatdapat'] ?? 0,
            '0c2db8',
          ),
        ];

        // Sort all data based on votes
        _mayorData.sort((a, b) => a.votes.compareTo(b.votes));
        _viceMayorData.sort((a, b) => a.votes.compareTo(b.votes));
        _councilorData.sort((a, b) => a.votes.compareTo(b.votes));
        _congData.sort((a, b) => a.votes.compareTo(b.votes));
        _bmData.sort((a, b) => a.votes.compareTo(b.votes));
      });
    } catch (e) {
      print("Error fetching votes: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadingFuture = Future.delayed(const Duration(seconds: 2), () => true);

    // Initialize empty lists
    _mayorData = [];
    _viceMayorData = [];
    _councilorData = [];
    _congData = [];
    _bmData = [];
    _partyListData = [];

    // Fetch data from Supabase
    getVotes();

    // Initialize tooltips
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
                  Positioned.fill(child: Image.asset('assets/images/bg.jpg', fit: BoxFit.cover)),
                  Container(
                    color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(color: Colors.white, strokeWidth: 5),
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
            child: Stack(
              children: [
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
                                  height: 180,
                                  fontSize: 25,
                                  withImage: true,
                                ),
                                CandidateBarChart(
                                  tooltipBehavior: _tooltipBehavior,
                                  data: _bmData,
                                  pointColorMapper: _hexToColor,
                                  title: 'BOARD MEMBERS 2025',
                                  height: 330,
                                  fontSize: 19,
                                ),
                                CandidateBarChart(
                                  tooltipBehavior: _tooltipBehavior,
                                  data: _partyListData,
                                  pointColorMapper: _hexToColor,
                                  title: 'PARTYLIST 2025',
                                  height: 150,
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
              ],
            ),
          );
        },
      ),
    );
  }
}
