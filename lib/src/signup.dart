import 'package:assignment_1/SqlDb.dart';
import 'package:assignment_1/src/signin.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final SqlDb? sqlDb;

  const SignUp({super.key, required this.sqlDb});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formstat = GlobalKey();

  String? gender;
  int? level;

  String? name;
  String? email;
  String? pass;
  int? id;

  saveData() async {
    if (widget.sqlDb == null) {
      print("no tables");
      return;
    }
    int response = await widget.sqlDb!.insertData(
        "INSERT INTO users (id, name, password, gender, level, email) VALUES ($id, '$name', '$pass', '$gender', $level, '$email')");
    print(response);
    if (response > 0) {
      List<Map> result = await widget.sqlDb!.readData(
          "SELECT * FROM users WHERE id = $id AND password = '$pass'");
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return SignIn(
          user: result,
          sqlDb: widget.sqlDb,
        );
      }));
    }
  }

  bool exist = false;

  checkData() async {
    List<Map> result =
        await widget.sqlDb!.readData("SELECT * FROM users WHERE id = $id");
    if (result.isEmpty) {
      exist = false;
      saveData();
    } else {
      exist = true;
      print("id exists");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 40,
        ),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            autovalidateMode: AutovalidateMode.always,
            key: formstat,
            child: Column(
              children: <Widget>[
                // MaterialButton(
                //     color: Colors.red,
                //     textColor: Colors.white,
                //     onPressed: () async {
                //       List<Map> result =
                //           await widget.sqlDb!.readData("SELECT * FROM 'users'");
                //       print(result);
                //     },
                //     child: const Text("read data")),
                const Text(
                  'Enter Your Name Please,',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  onSaved: (newValue) {
                    name = newValue;
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
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Enter Your Email Please,',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (newValue) {
                    email = newValue;
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
                      hintText: '*EX: 20002000@stud.fc-cu.edu.eg',
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
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Enter Your Password Please,',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  onSaved: (newValue) {
                    pass = newValue;
                  },
                  onChanged: (value) {
                    pass = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "mandatory field!";
                    }
                    if (value.length < 8) {
                      return "short password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: '*at least 8 characters',
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
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Confirm Your Password Please,',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (value) {
                    if (value != pass) {
                      return "no matching";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: '*same',
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
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Choose Your Gender Please,',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
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
                    onChanged: (val) {
                      setState(() {
                        gender = val;
                      });
                    }),
                const Text(
                  'Choose Your Level Please,',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                RadioListTile(
                  title: const Text("1"),
                  value: 1,
                  onChanged: (val) {
                    setState(() {
                      level = val;
                    });
                  },
                  groupValue: level,
                ),
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
                const Text(
                  'Enter Your Student ID Please,',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  onSaved: (newValue) {
                    id = int.parse(newValue!);
                    checkData();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "mandatory field!";
                    }
                    if (value.length != 8) {
                      return "wrong ID";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: '*Ex: 20001234',
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
                exist == true
                    ? const Text(
                        "This id is used",
                        style: TextStyle(color: Colors.red),  
                      )
                    : const Text(""),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: MaterialButton(
                      elevation: 5.0,
                      color: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 80),
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      onPressed: () {
                        if (formstat.currentState!.validate()) {
                          formstat.currentState!.save();
                        }
                        setState(() {});
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 23,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
