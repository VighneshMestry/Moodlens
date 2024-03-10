import 'package:flutter/material.dart';
import 'package:loc_hackathon/features/auth/screen/login_screen.dart';
import 'package:loc_hackathon/features/home/repository/home_repository.dart';
import 'package:loc_hackathon/features/home/screens/insights.dart';
import 'package:loc_hackathon/features/home/widgets/lecture_card.dart';
import 'package:loc_hackathon/model/meeting_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MeetingModel> allMeetings = [];
  String? userName = "";

  void getAllMeetings() async {
    HomeRepository homeRepository = HomeRepository();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? studentId = prefs.getInt("student_id");
    userName = prefs.getString("name");
    // ignore: use_build_context_synchronously
    allMeetings = await homeRepository.getAllMeetings(context, studentId!);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getAllMeetings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: IconButton(
              icon: const Icon(Icons.calendar_month_outlined),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.remove("name");
                prefs.remove("student_id");
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                    (Route<dynamic> route) => false);
              },
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Lectures",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 35),
            // GestureDetector(
            //   onTap: () {
            //     Navigator.of(context).push(MaterialPageRoute(
            //         builder: (context) => const InsightsScreen()));
            //   },
            //   child: const LectureCard(),
            // ),
            (allMeetings.isEmpty)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: allMeetings.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => InsightsScreen(meetingId: allMeetings[index].meetId, userName: userName!,)));
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: LectureCard(
                              meeting: allMeetings[index],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
