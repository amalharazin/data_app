import 'package:sqflite/sqflite.dart';
import 'package:vp18_data_app/database/db_controller.dart';
import 'package:vp18_data_app/models/process_response.dart';
import 'package:vp18_data_app/models/user.dart';
import 'package:vp18_data_app/pref/shared_pref_controller.dart';

class UserDbController{


  /**
 * Operations
 * 1) register
 * 2)Login
  *3)CheckIfEmailExisted
   */

  final Database _database=DbController().database;

  Future<ProcessResponse>login(String email,String password)async{
    List<Map<String,dynamic>>rows=await _database.query(User.tableName,where: 'email=?,password=?',whereArgs:
    [email,password]);

    if(rows.isNotEmpty){
      User user=User.fromMap(rows.first);
     await SharedPrefController().save(user);
      return ProcessResponse('Logged in successfully');
    }
    return ProcessResponse('Login failed ,check credentials',false);
  }




  Future<ProcessResponse> register(User user)async {
    if (!await _checkIfEmailExisted(user.email)) {
      int newRowId = await _database.insert(User.tableName, user.toMap());
      return ProcessResponse(
          newRowId != 0 ? 'Registered successful' : 'Registration failed');
    }
   return ProcessResponse('Email registered ,user another',false);
  }




   Future<bool> _checkIfEmailExisted(String email)async{
    List<Map<String,dynamic>>rows= await _database.query(User.tableName,where: 'email=?',whereArgs: [email]);

    return rows.isNotEmpty;
   }
}