import 'package:vp18_data_app/database/db_operations.dart';
import 'package:vp18_data_app/models/note.dart';

class NoteDbController extends DbOperations<Note>{
  @override
  Future<int> create(Note model) {
   // return database.rawInsert("INERT INTO note (title,info,user_id) VALUE(?,?,?)",
    //[model.title,model.info,model.userId]);

    return database.insert(Note.tableName, model.toMap());
  }

  @override
  Future<bool> delete(int id)async {
    // int countOfDeletedRow= await database.rawDelete("DELETE FROM notes WHERE id=?",
    // [id]);

    int countOfDeletedRow= await database.delete(Note.tableName,where: 'id=?',whereArgs: [id]);

    return countOfDeletedRow>0;

  }

  @override
  Future<List<Note>> read()async {
   // List<Map<String,dynamic>>rows=await database.rawQuery("SELECT * FROM notes");
    List<Map<String,dynamic>>rows=await database.query(Note.tableName);
   return rows.map((rowMap) => Note.fromMap(rowMap)).toList();
  }

  @override
  Future<Note?> show(int id)async {
  // List<Map<String,dynamic>>rows=await database.rawQuery("SELECT * FROM notes WHERE id=?",[id]);

    List<Map<String,dynamic>>rows=await database.query(Note.tableName,where: 'id=?',whereArgs: [id]);
  return rows.isNotEmpty?Note.fromMap(rows.first):null;
  }

  @override
  Future<bool> update(Note model)async {
   // int countOfUpdatedRow= await database.rawUpdate("UPDATE notes SET title=?,info=?,user_id=? WHERE id=?",
   // [model.title,model.info,model.userId,model.id]);

    int countOfUpdatedRow= await database.update(Note.tableName, model.toMap(),where: 'id=?',whereArgs: [model.id]);

   return countOfUpdatedRow==1;
  }
  



}