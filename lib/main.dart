import 'package:assignment_1/SqlDb.dart';
import 'package:assignment_1/src/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final SqlDb sqlDb = SqlDb();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: sqlDb.initDb(), // Await the initDb() method call
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // Database initialization is complete, return MaterialApp
          return MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
            ),
            home: LoginScrean(sqlDb: sqlDb),
          );
        } else {
          // Show loading indicator while database is being initialized
          return CircularProgressIndicator();
        }
      },
    );
  }
}
