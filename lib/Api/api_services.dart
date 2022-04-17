import 'package:http/http.dart' as http;
import 'package:sqlite_assingnment/Api/modle.dart';

class EmployeeApi {

  save(Employee employee) async {
    try {
      var response = await http.post(Uri.https("reqres.in", "api/users"), body: {
        "id" : "3",
        "name": employee.name,
        "job": employee.body,
      });
      if (response.statusCode == 201) {
        print("ok");
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  getData() async {
    try {
      var response = await http
          .get(Uri.https("reqres.in", "api/users?page=2"));
      if (response.statusCode == 200) {
        print(response.body);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
