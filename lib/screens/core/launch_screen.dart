import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vp18_data_app/pref/shared_pref_controller.dart';

class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  State<LaunchScreen> createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {


  @override
  void initState(){
    super.initState();
    Future.delayed( const Duration(seconds: 3),(){
    bool loggedIn= SharedPrefController().getValue<bool>(Prefkey.loggedIn.name)??false;
    String route= loggedIn?'/home_screen':'/login_screen';
      Navigator.pushReplacementNamed(context, route);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Text('DATA APP',
            style: GoogleFonts.tajawal(
              fontWeight: FontWeight.bold,
              fontSize: 26
            ),

          )),
    );
  }
}
