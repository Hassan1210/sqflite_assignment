import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sqlite_assingnment/Api/api_services.dart';
import 'package:sqlite_assingnment/Api/modle.dart';
import 'package:velocity_x/velocity_x.dart';

class Api extends StatefulWidget {
  const Api({Key? key}) : super(key: key);

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  State<Api> createState() => _ApiState();
}

class _ApiState extends State<Api> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  final nameController = TextEditingController();

  final phoneController = TextEditingController();

  EmployeeApi employeeApi = EmployeeApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(
                  height: 35,
                ),
                Card(
                  elevation: 5,
                  child: Form(
                    key: Api.formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 30,
                          ),
                          "Enter Details".text.size(20).bold.make(),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: nameController,
                            validator:
                                RequiredValidator(errorText: "*Required"),
                            decoration: InputDecoration(
                              labelText: "Name",
                              hintText: "Enter Name",
                              labelStyle: const TextStyle(color: Colors.black),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            validator:
                                RequiredValidator(errorText: "*Required"),
                            decoration: InputDecoration(
                              labelText: "Phone",
                              hintText: "Enter Phone No",
                              labelStyle: const TextStyle(color: Colors.black),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 16),
                              fillColor: Colors.white,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 2,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (Api.formKey.currentState!.validate()) {
                                await save();
                                nameController.clear();
                                phoneController.clear();
                              }
                            },
                            child: "Add Contact ".text.make(),
                            style:
                                ElevatedButton.styleFrom(primary: Colors.black),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  save() async {
    Employee employee =
        Employee(id: 1, name: nameController.text, body: phoneController.text);
    await employeeApi.save(employee);
  }
  getData()async{
  await employeeApi.getData();
  }
}

//

// }
