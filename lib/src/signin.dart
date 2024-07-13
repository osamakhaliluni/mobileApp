import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:assignment_1/SqlDb.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SignIn extends StatefulWidget {
  final SqlDb? sqlDb;
  final List<Map>? user;
  const SignIn({super.key, required this.user, required this.sqlDb});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> formstat = GlobalKey();

  File? file;
  String? base64;
  Uint8List? bytes;
  List<Map>? result;

  String? name, gender, email, image;
  int? level;

  @override
  void initState() {
    name = widget.user![0]['name'];
    gender = widget.user![0]['gender'];
    email = widget.user![0]['email'];
    level = widget.user![0]['level'];
    image = widget.user![0]['image'];
    if (widget.user![0]['image'] != null) {
      bytes = base64Decode(widget.user![0]['image']);
    }
    super.initState();
  }

  createuser() async {
    result = await widget.sqlDb!
        .readData("SELECT * FROM users WHERE id = ${widget.user![0]['id']}");
    name = result![0]['name'];
    print("creating user");
  }

  Future pickerCamera() async {
    final myfile = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      file = File(myfile!.path);
      base64 = base64Encode(file!.readAsBytesSync());
      image = base64;
      bytes = base64Decode(base64!);
    });
    int response = await widget.sqlDb!.updateData(
        "UPDATE users SET image = '$base64' WHERE id = ${widget.user![0]['id']}");
    print(response);
  }

  Uint8List getbytes() {
    String img = image!;
    bytes = base64Decode(img);
    return bytes!;
  }

  bool nameedit = false,
      emailedit = false,
      genderedit = false,
      leveledit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign in Page!'),
      ),
      body: Form(
        key: formstat,
        child: Column(
          children: [
            bytes == null
                ? Image.asset(
                    "images/image.jpg",
                    width: 150,
                  )
                : Image.memory(
                    getbytes(),
                    width: 150,
                  ),
            IconButton(
                onPressed: () {
                  pickerCamera();
                },
                icon: Icon(Icons.edit)),
            nameedit == false
                ? Card(
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            nameedit = true;
                          });
                        },
                      ),
                      title: const Text("Name"),
                      subtitle: Text("$name"),
                    ),
                  )
                : Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        onSaved: (newValue) async {
                          await widget.sqlDb!.updateData(
                              "UPDATE users SET name = '$newValue' WHERE id = ${widget.user![0]['id']}");
                          name = newValue;
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "mandatory field!";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: '*Name',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.0,
                                )),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.blueAccent,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.0,
                                ))),
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (formstat.currentState!.validate()) {
                            formstat.currentState!.save();
                            setState(() {
                              nameedit = false;
                            });
                          }
                        },
                        child: Text("Done"),
                        color: Colors.red,
                        textColor: Colors.white,
                      )
                    ],
                  ),
            emailedit == false
                ? Card(
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            emailedit = true;
                          });
                        },
                      ),
                      title: const Text("Email"),
                      subtitle: Text("$email"),
                    ),
                  )
                : Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        onSaved: (newValue) async {
                          await widget.sqlDb!.updateData(
                              "UPDATE users SET email = '$newValue' WHERE id = ${widget.user![0]['id']}");
                          email = newValue;
                          setState(() {});
                        },
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "mandatory field!";
                          }
                          if (!value.endsWith("@stud.fci-cu.edu.eg")) {
                            return "wrong email, ....@stud.fci-cu.edu.eg";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                            hintText: '*Email',
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.0,
                                )),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: const BorderSide(
                                color: Colors.blueAccent,
                                width: 1.0,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: const BorderSide(
                                  color: Colors.blueAccent,
                                  width: 1.0,
                                ))),
                      ),
                      MaterialButton(
                        onPressed: () {
                          if (formstat.currentState!.validate()) {
                            formstat.currentState!.save();
                            setState(() {
                              emailedit = false;
                            });
                          }
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: const Text("Done"),
                      )
                    ],
                  ),
            genderedit == false
                ? Card(
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            genderedit = true;
                          });
                        },
                      ),
                      title: const Text("Gender"),
                      subtitle: Text("$gender"),
                    ),
                  )
                : Column(
                    children: [
                      RadioListTile(
                          title: const Text("Male"),
                          value: "male",
                          groupValue: gender,
                          onChanged: (val) {
                            setState(() {
                              gender = val;
                            });
                          }),
                      RadioListTile(
                          title: const Text("Female"),
                          value: "female",
                          groupValue: gender,
                          onChanged: (newValue) async {
                            await widget.sqlDb!.updateData(
                                "UPDATE users SET gender = '$newValue' WHERE id = ${widget.user![0]['id']}");
                            email = newValue;
                            setState(() {});
                          }),
                      MaterialButton(
                        onPressed: () {
                          if (formstat.currentState!.validate()) {
                            formstat.currentState!.save();
                            setState(() {
                              genderedit = false;
                            });
                          }
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: const Text("Done"),
                      )
                    ],
                  ),
            leveledit == false
                ? Card(
                    child: ListTile(
                      leading: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          setState(() {
                            leveledit = true;
                          });
                        },
                      ),
                      title: const Text("Level"),
                      subtitle: Text("$level"),
                    ),
                  )
                : Column(
                    children: [
                      RadioListTile(
                          title: const Text("1"),
                          value: 1,
                          groupValue: level,
                          onChanged: (val) {
                            setState(() {
                              level = val;
                            });
                          }),
                      RadioListTile(
                          title: const Text("2"),
                          value: 2,
                          groupValue: level,
                          onChanged: (val) {
                            setState(() {
                              level = val;
                            });
                          }),
                      RadioListTile(
                          title: const Text("3"),
                          value: 3,
                          groupValue: level,
                          onChanged: (val) {
                            setState(() {
                              level = val;
                            });
                          }),
                      RadioListTile(
                          title: const Text("4"),
                          value: 4,
                          groupValue: level,
                          onChanged: (val) {
                            setState(() {
                              level = val;
                            });
                          }),
                      MaterialButton(
                        onPressed: () {
                          if (formstat.currentState!.validate()) {
                            formstat.currentState!.save();
                            setState(() {
                              leveledit = false;
                            });
                          }
                        },
                        color: Colors.red,
                        textColor: Colors.white,
                        child: const Text("Done"),
                      )
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
