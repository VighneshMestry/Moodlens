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

  Future<String> generateConclusion() async {
    HomeRepository homeRepository = HomeRepository();
    SharedPreferences refs = await SharedPreferences.getInstance();
    int? studentId = refs.getInt("student_id");
    return await homeRepository.generateConclusion(
        context, widget.meetingId, studentId!);
  }

  late Future<String> _conclusionFuture;

  @override
  void initState() {
    super.initState();
    // Assuming you have a function that fetches the conclusion asynchronously
    _conclusionFuture = generateConclusion();
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
            // generateConclusion();
            // (conclusion.length == 0) ? SizedBox() :
            // setState(() {});
            _showConclusionDialog(context);
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

  void _showConclusionDialog(BuildContext context) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 700),
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
      pageBuilder: (context, anim1, anim2) {
        return FutureBuilder<String>(
          future: _conclusionFuture,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 500,
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(bottom: 0, left: 12, right: 12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: SizedBox.expand(
                    child: Center(
                      child: SingleChildScrollView(
                        child: Text(
                          snapshot.data!,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return AlertDialog(
                title: Text('No Conclusion'),
                content: Text('No conclusion available.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }

  // Future<String> fetchConclusion() async {
  //   // Simulate fetching conclusion from a future function
  //   await Future.delayed(Duration(seconds: 2));
  //   return "Based on the emotional report, it appears that your child experienced a range of emotions during the meeting. While there were positive emotions of happiness, the presence of confusion suggests that they may have faced some challenges in understanding the content or keeping up with the pace of the discussion.\n\nGiven your child's disability, it's important to consider whether these challenges could be related to their specific needs. If other students in the class also reported similar emotions, this may indicate a need for the teacher to adjust their teaching style or provide additional support to all students.\n\nIf your child's emotions were more negative than those of their classmates, it may be helpful to discuss with them specifically what they found challenging. Encouraging them to communicate their difficulties and providing positive reinforcement for their efforts can help them develop coping mechanisms and improve their engagement in future meetings.";
  // }
}

// showGeneralDialog(
//           barrierLabel: "Label",
//           barrierDismissible: true,
//           barrierColor: Colors.black.withOpacity(0.5),
//           transitionDuration: Duration(milliseconds: 700),
//           context: context,
//           pageBuilder: (context, anim1, anim2) {
//             return Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 height: 500,
//                 margin:
//                     const EdgeInsets.only(bottom: 0, left: 12, right: 12),
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   ),
//                 ),
//                 child: SizedBox.expand(
//                   child: Text(conclusion),
//                 ),
//               ),
//             );
//           },
//           transitionBuilder: (context, anim1, anim2, child) {
//             return SlideTransition(
//               position: Tween(begin: Offset(0, 1), end: Offset(0, 0))
//                   .animate(anim1),
//               child: child,
//             );
//           },
//         );
