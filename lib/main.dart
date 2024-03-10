import 'package:flutter/material.dart';
import 'package:loc_hackathon/features/auth/screen/login_screen.dart';
import 'package:loc_hackathon/features/home/screens/custom_bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var username = prefs.getString('username');
  runApp(
    MaterialApp(
      title: 'LOC Hackathon',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'Lexend'),
      home: (username == null) ? const LoginScreen() : const CustomBottomBar(),
    ),
  );
}

// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<MyApp> createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   late bool isAuthentication;

//   void checkAuthentication() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? userName = prefs.getString("username");
//     print("USERNAME $userName");
//     if (userName != null || userName!.length > 0) {
//       isAuthentication = true;
//     } else {
//       isAuthentication = false;
//     }
//     setState(() {});
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     checkAuthentication();
//   }

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {}
// }
