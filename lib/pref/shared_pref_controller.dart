import 'package:shared_preferences/shared_preferences.dart';
import 'package:vp18_data_app/models/user.dart';


enum Prefkey{loggedIn,id ,fullName,email,language}

class SharedPrefController{

  late SharedPreferences _sharedPreferences;

 static SharedPrefController? _instance;

  SharedPrefController._();

  factory SharedPrefController(){
    return _instance??=SharedPrefController._();
  }
    Future<void>initPreferences()async{
    _sharedPreferences=await SharedPreferences.getInstance();

    }



   Future<void > save(User user)async{
   await _sharedPreferences.setBool(Prefkey.loggedIn.name, true);
   await _sharedPreferences.setInt(Prefkey.id.name,user.id);
   await _sharedPreferences.setString(Prefkey.fullName.name, user.fullName);
   await _sharedPreferences.setString(Prefkey.email.name, user.email);


    }

    bool get loggedIn=> _sharedPreferences.getBool(Prefkey.loggedIn.name)??false;

  T? getValue<T>(String key){
    if(_sharedPreferences.containsKey(key)){
      return _sharedPreferences.get(key) as T;
    }
    return null;

  }

Future<bool> removeValueFor(String key)async{
    if(_sharedPreferences.containsKey(key)){
      return _sharedPreferences.remove(key);
    }
    return false;

}




Future<bool> clear ()async{
    return _sharedPreferences.clear();
}

}