import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:sqlite_assingnment/Sqflite/contact_modle.dart';
import 'package:sqlite_assingnment/Sqflite/dbh_helper.dart';
import 'package:velocity_x/velocity_x.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getContact();
  }

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  DbHelper dbHelper = DbHelper.intance;
  List<Contact> contactList = [];

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
                    key: formKey,
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
                              if (formKey.currentState!.validate()) {
                                await insert();
                                await getContact();
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
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                      itemCount: contactList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () async{
                            await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Update(
                                          doc: contactList[index],
                                        )));
                            getContact();
                          },
                          child: Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.all(10),
                              leading: const CircleAvatar(
                                backgroundColor: Colors.black,
                                radius: 20,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              trailing: InkWell(
                                onTap: () async {
                                  await delete(contactList[index].id);
                                  await getContact();
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: Colors.black,
                                ),
                              ),
                              title: contactList[index]
                                  .name
                                  .toString()
                                  .text
                                  .make(),
                              subtitle: contactList[index]
                                  .contact
                                  .toString()
                                  .text
                                  .make(),
                            ),
                          ),
                        );
                      }),
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

  insert() async {
    Contact contact =
        Contact(name: nameController.text, contact: phoneController.text);
    int id = await dbHelper.insert(contact);
    print(id);
  }

  getContact() async {
    List<Contact> x = await dbHelper.getContact();
    setState(() {
      contactList = x;
    });
  }

  delete(int? id) async {
    await dbHelper.delete(id);
  }
}

class Update extends StatefulWidget {
  const Update({Key? key, required this.doc}) : super(key: key);

  final dynamic doc;

  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      phoneController.text = widget.doc.contact;
      nameController.text = widget.doc.name;
    });
  }

  static GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  DbHelper dbHelper = DbHelper.intance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 35,
            ),
            Card(
              elevation: 5,
              child: Form(
                key: formKey,
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
                        validator: RequiredValidator(errorText: "*Required"),
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
                        validator: RequiredValidator(errorText: "*Required"),
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
                          if (formKey.currentState!.validate()) {
                            await update();
                            Navigator.pop(context);
                          }
                        },
                        child: "Update Contact ".text.make(),
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  update() async {
    Contact contact = Contact(
        id: widget.doc.id,
        name: nameController.text,
        contact: phoneController.text);
    await dbHelper.update(contact, widget.doc.id);
  }
}
