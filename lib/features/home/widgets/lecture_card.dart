// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:loc_hackathon/model/meeting_model.dart';

class LectureCard extends StatelessWidget {
  final MeetingModel meeting;
  const LectureCard({
    Key? key,
    required this.meeting,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> lecDisplayImage = ["assets/lecture1.png", "assets/lecture2.png", "assets/lecture3.png"];

    return Container(
      height: 100,
      width: 100,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color.fromARGB(255, 247, 246, 242)),
      child: Row(
        children: [
          Container(
            height: 80,
            width: 140,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage(lecDisplayImage[meeting.title.length%3]),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.1),
                  BlendMode.darken,
                ),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (meeting.title.length >= 20) ? "${meeting.title.substring(0,20)}..." : meeting.title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  "By: ${meeting.hostName}",
                  style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text(
                  meeting.description,
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
