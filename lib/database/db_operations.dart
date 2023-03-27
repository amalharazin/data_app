import 'package:sqflite/sqflite.dart';
import 'package:vp18_data_app/database/db_controller.dart';

abstract class DbOperations<Model>{


Database database=DbController().database;

  Future<int>create(Model model);

  Future<List<Model>> read ();

  Future<Model?>show(int id);

  Future<bool>update (Model model);

  Future<bool> delete(int id);

}