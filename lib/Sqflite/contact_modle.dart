



class Table{
  static String columnId = "id";
  static String columnPhone = "phone";
  static String columnName = "name";


  static String tableName = "Contact";

}



class Contact{

  int? id;
  String? contact;
  String? name;


  Contact({this.id,this.name,this.contact,});


  Map<String,dynamic> toMap()=>{
    Table.columnId : id,
    Table.columnName: name,
    Table.columnPhone:contact,
  };


  Contact.fromMap(Map<dynamic,dynamic> map){
    id = map[Table.columnId];
    name = map[Table.columnName];
    contact = map[Table.columnPhone];
  }


}