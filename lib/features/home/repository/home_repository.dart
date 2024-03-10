import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:loc_hackathon/model/meeting_model.dart';
import 'package:loc_hackathon/model/overall_meeting_model.dart';
import 'package:loc_hackathon/model/report_model.dart';
import 'package:loc_hackathon/model/timestamps_model.dart';
import 'package:loc_hackathon/model/user_model.dart';

class HomeRepository {
  HomeRepository();

  Future logIn(BuildContext context, String username, int pid) async {
    try {
      print("Dart api run");
      http.Response res = await http.post(
        Uri.parse(
            "https://mood-lens-server.onrender.com/api/v1/user/login"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "username": username,
          "pid" : pid
        }),
      );
      print("Dart api finish");
      return UserModel.fromJson(jsonDecode(res.body)['user']);
    } catch (e) {
      print("Error in the services catch block");
      print(e.toString());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future getPersonalReport(BuildContext context, int studentId, int meetId) async {
    try {
      // String link =
      //   "C:/Users/Vighnesh/Flutter/Projects/ml_project/assets/demo.pdf";
      print("Dart api run");
      http.Response res = await http.post(
        Uri.parse(
            "https://mood-lens-server.onrender.com/api/v1/student_reports/personal_meeting_report"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "student_id": studentId,
          "meet_id": meetId,
        }),
      );
      print("Dart api finish");
      List<Report> reports = [];
      final parsed = json.decode(res.body)['reports'] as List<dynamic>;
      reports = parsed.map<Report>((json) => Report.fromJson(json)).toList();
      return reports;
    } catch (e) {
      print("Error in the services catch block");
      print(e.toString());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future getAllMeetings(BuildContext context, int studentId) async {
    try {
      // String link =
      //   "C:/Users/Vighnesh/Flutter/Projects/ml_project/assets/demo.pdf";
      print("Dart api run");
      http.Response res = await http.post(
        Uri.parse(
            "https://mood-lens-server.onrender.com/api/v1/student_reports/meetings"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "student_id": studentId,
        }),
      );
      print("Dart api finish");
      List<MeetingModel> reports = [];
      final parsed = json.decode(res.body)['detailedReports'] as List<dynamic>;
      reports = parsed.map<MeetingModel>((json) => MeetingModel.fromJson(json)).toList();
      return reports;
    } catch (e) {
      print("Error in the services catch block");
      print(e.toString());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future getOverallMeetingReport(BuildContext context, int meetId) async {
    try {
      // String link =
      //   "C:/Users/Vighnesh/Flutter/Projects/ml_project/assets/demo.pdf";
      print("Dart api run");
      http.Response res = await http.post(
        Uri.parse(
            "https://mood-lens-server.onrender.com/api/v1/student_reports/overall_meeting_report"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "meet_id": meetId,
        }),
      );
      print("Dart api finish");
      List<OverallMeetingModel> reports = [];
      final parsed = json.decode(res.body)['reports'] as List<dynamic>;
      reports = parsed.map<OverallMeetingModel>((json) => OverallMeetingModel.fromJson(json)).toList();
      return reports;
    } catch (e) {
      print("Error in the services catch block");
      print(e.toString());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future getMeetingTimestampsData(BuildContext context, int meetId) async {
    try {
      // String link =
      //   "C:/Users/Vighnesh/Flutter/Projects/ml_project/assets/demo.pdf";
      print("Dart api run");
      http.Response res = await http.post(
        Uri.parse(
            "https://mood-lens-server.onrender.com/api/v1/student_reports/get_meeting_timestamps"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "meet_id": meetId,
        }),
      );
      print("Dart api finish");
      print(res.body);
      final List<dynamic> jsonList = json.decode(res.body)['timestamps_data'];
      List<MeetingTimestampModel> timestamps =
          jsonList.map((json) => MeetingTimestampModel.fromJson(json)).toList();
      // for(int i =0; i < timestamps.length; i++) {
      //     for(int j = 0; j < timestamps[i].timestamps.length; j++) {
      //       print("$i Check ${timestamps[i].timestamps[j].reportNo}");
      //     }
      // }
      return timestamps;
    } catch (e) {
      print("Error in the timestamp services catch block");
      print(e.toString());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  Future generateConclusion(BuildContext context, int meetId, int studentId) async {
    try {
      // String link =
      //   "C:/Users/Vighnesh/Flutter/Projects/ml_project/assets/demo.pdf";
      print("Dart api run");
      http.Response res = await http.post(
        Uri.parse(
            "https://mood-lens-server.onrender.com/api/v1/student_reports/generate_conclusion"),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "meet_id": meetId,
          "student_id" : studentId
        }),
      );
      print("Dart api finish");
      return res.body;
    } catch (e) {
      print("Error in the timestamp services catch block");
      print(e.toString());
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  // httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         final parsed =
  //             json.decode(res.toString())['reports'] as List<dynamic>;
  //         reports =
  //             parsed.map<Report>((json) => Report.fromJson(json)).toList();

  //         for (int i = 0; i < reports.length; i++) {
  //           print(reports[i]);
  //         }
  //       },
  //     );

  void httpErrorHandle({
    required http.Response response,
    required BuildContext context,
    required VoidCallback onSuccess,
  }) {
    switch (response.statusCode) {
      case 200:
        onSuccess();
        break;
      case 400:
        {
          print(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(jsonDecode(response.body)['msg'])));
        }
        break;
      case 500:
        {
          print(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(jsonDecode(response.body)['error'])));
        }
        break;
      default:
        {
          print(response.body);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(response.body)));
        }
    }
  }
}
