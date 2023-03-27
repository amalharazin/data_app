import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vp18_data_app/database/controllers/user_db_controller.dart';
import 'package:vp18_data_app/models/process_response.dart';
import 'package:vp18_data_app/pref/shared_pref_controller.dart';
import 'package:vp18_data_app/provider/language_provider.dart';
import 'package:vp18_data_app/utils/context_extenssion.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  String? _language;

  @override
  void initState() {
    super.initState();
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
        actions: [
          IconButton(
              onPressed: () {
                _showLanguageBottomSheet();
              },
              icon: const Icon(Icons.language))
        ],
        title: Text(
          context.localizations.login,
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
                _performLogin();
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10))),
              child:  Text(context.localizations.login),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
              Text(context.localizations.no_account),
              TextButton(onPressed: (){
                Navigator.pushNamed(context, '/register_screen');
              },
                  child: Text(context.localizations.create_now),
              ),
            ]
            ),
          ],
        ),
      ),
    );
  }

  void _performLogin() {
    if (_checkData()) {
      _login();
    }
  }

  bool _checkData() {
    if (_emailTextController.text.isNotEmpty) {
      return true;
    }
    context.showSnackBar(message: 'Enter required data', error: true);
    return false;
  }

  void _login() async{
    ProcessResponse processResponse=await UserDbController().login(_emailTextController.text, _passwordTextController.text);
    context.showSnackBar(message: processResponse.message,error: processResponse.success);
    if(processResponse.success)
    Navigator.pushReplacementNamed(context, '/home_screen');
  }

  void _showLanguageBottomSheet() async{
     String? result =await showModalBottomSheet<String>(
      isDismissible: true,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      builder: (context) {
        return BottomSheet(
          onClosing: () {},
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        ),
          backgroundColor: Colors.transparent,

          builder: (context) {
            return StatefulBuilder(builder: (context, setState) {
              return  Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(context.localizations.language_hint,
                      style: GoogleFonts.tajawal(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black
                      ),
                    ),
                    Text(context.localizations.language_message,
                      style: GoogleFonts.tajawal(
                          fontWeight: FontWeight.w300,
                          fontSize: 13,
                          color: Colors.black45
                      ),
                    ),
                    const Divider(),
                    RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        visualDensity:const VisualDensity(vertical: VisualDensity.minimumDensity),
                        title: Text('English',
                          style: GoogleFonts.tajawal(),
                        ),
                        value: 'en', groupValue: _language, onChanged: (String? value){
                      setState(()=>_language=value);
                      Navigator.pop(context,'en');

                    }),

                    RadioListTile<String>(
                        contentPadding: EdgeInsets.zero,
                        visualDensity:const VisualDensity(vertical: VisualDensity.minimumDensity),


                        title: Text('العربية',
                          style: GoogleFonts.tajawal(),
                        ),
                        value: 'ar', groupValue: _language, onChanged: (String? value){
                      setState(()=>_language=value);
                      Navigator.pop(context,'ar');

                    }),
                  ],
                ),
              );


            },);
          },
        );
      },
    );
     if(result!=null){
       Provider.of<LanguageProvider>(context,listen: false).changeLanguage(result);
       //change language
     }
  }
}
