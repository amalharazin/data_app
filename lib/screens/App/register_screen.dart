import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vp18_data_app/database/controllers/user_db_controller.dart';
import 'package:vp18_data_app/models/process_response.dart';
import 'package:vp18_data_app/models/user.dart';
import 'package:vp18_data_app/pref/shared_pref_controller.dart';
import 'package:vp18_data_app/provider/language_provider.dart';
import 'package:vp18_data_app/utils/context_extenssion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _fullNameTextController;
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;


  @override
  void initState() {
    super.initState();
    _fullNameTextController =TextEditingController();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(
          context.localizations.register,
          style: GoogleFonts.tajawal(
            fontSize: 26,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
          context.localizations.login_hint,
              style: GoogleFonts.tajawal(
                  fontWeight: FontWeight.w700, fontSize: 26),
            ),
            Text(
              context.localizations.login_message,
              style: GoogleFonts.tajawal(
                  fontSize: 16, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _fullNameTextController,
              style: GoogleFonts.tajawal(),
              keyboardType: TextInputType.text,
              decoration:  InputDecoration(
                hintText: context.localizations.full_name,
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _emailTextController,
              style: GoogleFonts.tajawal(),
              keyboardType: TextInputType.emailAddress,
              decoration:  InputDecoration(
                hintText: context.localizations.email,
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordTextController,
              style: GoogleFonts.tajawal(),
              keyboardType: TextInputType.text,
              decoration:  InputDecoration(
                hintText: context.localizations.password,
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                _performRegister();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child:  Text(context.localizations.register),
            ),
          ],
        ),
      ),
    );
  }

  void _performRegister() {
    if (_checkData()) {
      _register();
    }
  }

  bool _checkData() {
    if (_fullNameTextController.text.isNotEmpty&&
    _emailTextController.text.isNotEmpty&&
        _passwordTextController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Enter required data', error: true);
    return false;
  }

  void _register() async{
    ProcessResponse processResponse=await UserDbController()
        .register(user);
    context.showSnackBar(message: processResponse.message,error: !processResponse.success);
    if(processResponse.success)
    Navigator.pop(context);
  }
User get user{
    User user=User();
    user.fullName=_fullNameTextController.text;
    user.email=_emailTextController.text;
    user.password=_passwordTextController.text;
    return user;
}
}
