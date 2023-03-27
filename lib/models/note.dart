class Note{
  late  int id;
  late String title;
  late String info;
  late String userId;

  Note();
  static const String tableName ="notes";

  Note.fromMap(Map<String,dynamic>rowMap){
    id=rowMap['id'];
    title=rowMap['title'];
    info=rowMap['info'];
    userId=rowMap['user_id'];

  }

 Map<String,dynamic> toMap(){
    Map<String,dynamic>map=<String,dynamic>{};
    map['title']=title;
    map['info']=info;
    map['user_id']=userId;


    return map;
 }

}