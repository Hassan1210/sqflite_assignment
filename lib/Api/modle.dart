

class Employee{

  int? id;
  String? name;
  String? body;


  Employee({this.id,this.name,this.body});


  Map<String,dynamic> toMap()=>{
    "id" : id as String,
    "title": name,
    "body" : body
  };


  Employee.fromMap(Map<dynamic,dynamic> map){
    id = map['id'];
    name = map['name'];
    body = map['body'];
  }


}