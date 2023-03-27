import 'package:flutter/material.dart';

class LanguageProvider extends ChangeNotifier{
  String language ='en';

  void changeLanguage(String language){
   this. language=language;
    notifyListeners();

}

}