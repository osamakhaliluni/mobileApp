import 'package:assignment_1/SqlDb.dart';
import 'package:assignment_1/src/signin.dart';
import 'package:assignment_1/src/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScrean extends StatefulWidget {
  final SqlDb? sqlDb;

  const LoginScrean({super.key, required this.sqlDb});

  @override
  State<LoginScrean> createState() => _LoginScreanState();
}

class _LoginScreanState extends State<LoginScrean> {
  GlobalKey<FormState> formstat = GlobalKey();

  int? id;
  String? pass;

  searchData() async {
    List<Map> result = await widget.sqlDb!
        .readData("SELECT * FROM users WHERE id = $id AND password = '$pass'");
    print(result);
    if (result.isEmpty) {
      print("error");
    } else {
      //AudioPlayer player = AudioPlayer();
      //Source path = AssetSource("bolbol.mp3");
      //player.play(path);
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return SignIn(user: result, sqlDb: widget.sqlDb);
      }));
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
            key: formstat,
            child: Column(
              children: <Widget>[
                MaterialButton(
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: () async {
                      List<Map> result =
                          await widget.sqlDb!.readData("SELECT * FROM 'users'");
                      print(result);
                    },
                    child: const Text("read data")),
                const Image(
                  image: AssetImage(
                    'assets/fci.PNG',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  onSaved: (val) {
                    id = int.parse(val!);
                  },
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter YOur ID";
                    }
                    if (value.length != 8) {
                      return "wrong ID";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: '*ID',
                      prefixIcon: const Icon(Icons.email),
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
                  height: 30,
                ),
                TextFormField(
                  onSaved: (val) {
                    pass = val;
                    searchData();
                  },
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Enter Your Password";
                    }
                    if (value.length < 8) {
                      return "short password";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintText: '*Password',
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
                  height: 30,
                ),
                MaterialButton(
                    onPressed: () {
                      if (formstat.currentState!.validate()) {
                        formstat.currentState!.save();
                      }
                    },
                    elevation: 5.0,
                    color: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 80),
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'Dont have an account ? Create one :D ,'
                  ' it is easy ',
                  style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 30,
                ),
                MaterialButton(
                    elevation: 5.0,
                    color: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 70),
                    shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none),
                    onPressed: () {
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return SignUp(sqlDb: widget.sqlDb);
                      }));
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
