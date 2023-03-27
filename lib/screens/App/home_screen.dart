import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vp18_data_app/pref/shared_pref_controller.dart';
import 'package:vp18_data_app/utils/context_extenssion.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(onPressed: (){
            _showLogoutConfirmationDialog(context);
          }, icon: const Icon(Icons.logout))
        ],
      ),
    );
  }
  void _showLogoutConfirmationDialog(BuildContext context) async{
   bool?result=await showDialog<bool>(
      barrierDismissible: true,
      // barrierColor: Colors.red.shade300,
      context: context, builder: (context) {

      return   AlertDialog(

        title:  Text(context.localizations.login_hint),
        content: Text(context.localizations.confirm_message),
        titleTextStyle: GoogleFonts.tajawal(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold
        ),
        contentTextStyle: GoogleFonts.tajawal(
          color: Colors.black,
          fontWeight: FontWeight.w300,
          fontSize: 13
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context,true);
          }, child: Text(context.localizations.yes,
            style: GoogleFonts.tajawal(
              color: Colors.red.shade600
            ),

          )),
          TextButton(onPressed: (){
            Navigator.pop(context,false);

          }, child: Text(context.localizations.no,
            style: GoogleFonts.tajawal(),

          )),

        ],

      );

    },
   );
   if(result??false){
      await SharedPrefController().removeValueFor(Prefkey.loggedIn.name);
     Future.delayed( const Duration(milliseconds: 500),(){
         Navigator.pushReplacementNamed(context, '/login_screen');

         });
   }





  }

}
