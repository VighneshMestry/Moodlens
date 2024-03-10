// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:loc_hackathon/features/home/repository/home_repository.dart';

import 'package:loc_hackathon/features/home/screens/overall_meeting_insights.dart';
import 'package:loc_hackathon/features/home/screens/personal_insights_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsightsScreen extends StatefulWidget {
  final int meetingId;
  final String userName;
  const InsightsScreen({
    Key? key,
    required this.meetingId,
    required this.userName,
  }) : super(key: key);

  @override
  State<InsightsScreen> createState() => _InsightsScreenState();
}

class _InsightsScreenState extends State<InsightsScreen> {
  int _currentpage = 0;
  String conclusion = "";

  void generateConclusion() async {
    HomeRepository homeRepository = HomeRepository();
    SharedPreferences refs = await SharedPreferences.getInstance();
    int? studentId = refs.getInt("student_id");
    conclusion = await homeRepository.generateConclusion(
        context, widget.meetingId, studentId!);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (_currentpage == 0)
              ? "${widget.userName}'s Insights"
              : "Classroom Insights",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
        ),
      ),
      body: DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const SizedBox(
                height: 20,
              ),
              // Container(
              //   margin: const EdgeInsets.symmetric(horizontal: 20),
              //   child: Align(
              //     alignment: Alignment.topLeft,
              //     child: Text(
              //       "health",
              //       // style: HeadingText,
              //     ),
              //   ),
              // ),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 5,
                          spreadRadius: 5)
                    ],
                    borderRadius: BorderRadius.circular(20)),
                child: TabBar(
                  // indicatorSize: 100,
                  labelColor: Colors.white,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromRGBO(14, 61, 154, 1)),
                  tabs: [
                    // Tab(
                    //   text: "viewReminders",
                    // ),
                    Container(
                      width: 300,
                      child: Center(child: Text("Personal insights")),
                    ),
                    Container(
                      width: 300,
                      child: Center(child: Text("Class insights")),
                    ),
                  ],
                  onTap: (index) {
                    _currentpage = index;
                    setState(() {});
                  },
                ),
              ),
              SizedBox(height: 8),
              Expanded(
                child: (_currentpage == 0)
                    ? PersonalInsightsScreen(
                        meetingId: widget.meetingId,
                        userName: widget.userName,
                      )
                    : OverallMeetingReports(
                        meetId: widget.meetingId,
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        padding: const EdgeInsets.all(5.0),
        height: 70,
        width: 70,
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: Colors.white,
          onPressed: () {
            showDialog(
              barrierDismissible: true,
              context: context,
              builder: (context) {
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      height: 200,
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0),
                        child: Text(conclusion),
                      )),
                );
              },
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(
              "assets/moodlensLogo1.png",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
