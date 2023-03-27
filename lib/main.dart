import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vp18_data_app/database/db_controller.dart';
import 'package:vp18_data_app/pref/shared_pref_controller.dart';
import 'package:vp18_data_app/provider/language_provider.dart';
import 'package:vp18_data_app/screens/App/home_screen.dart';
import 'package:vp18_data_app/screens/App/login_screen.dart';
import 'package:vp18_data_app/screens/App/register_screen.dart';
import 'package:vp18_data_app/screens/core/launch_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPreferences();
  await DbController().initDatabase();
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageProvider>(
      create: (context) => LanguageProvider(),
      builder: (context, child) {
        return  MaterialApp(

          localizationsDelegates: const[
            AppLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate],
          locale: Locale(
            Provider.of<LanguageProvider>(context,listen: true).language
          ),
          supportedLocales:const [
            Locale('en'),
            Locale('ar')],

          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.white,
                iconTheme: const IconThemeData(
                    color: Colors.black
                ),
                titleTextStyle:GoogleFonts.tajawal(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                ),
              )
          ),
          initialRoute: '/launch_screen',
          routes: {
            '/launch_screen':(context) => const LaunchScreen(),
            '/login_screen':(context) => const LoginScreen(),
        '/register_screen':(context) => const RegisterScreen(),
        '/home_screen':(context) => const HomeScreen(),
          },
        );
      },
    );
  }
}
