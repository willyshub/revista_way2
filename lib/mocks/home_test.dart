import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:revista_way2/services/database.dart';
import 'package:revista_way2/theme/app_colors.dart';

class HomeTest extends StatelessWidget {
  HomeTest({
    Key? key,
    required this.initialization,
  }) : super(key: key);
  final Future<FirebaseApp> initialization;

  Database database = Database();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "RevistaWAY",
      theme: ThemeData(
        primaryColor: AppColors.primary,
      ),
      builder: (_, __) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("HOME TESTE"),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("data"),
              /*
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: Database.readUsers(),
                builder: (_, snapshot){
                return Text(snapshot.data['nome']);
              }),
              */
              TextButton(
                onPressed: () async {
                  Database.readUsers();
                  // await Database.addUser(
                  //     idade: 25, nome: "Novo nome", sobrenome: "Silva");
                },
                child: const Text("Add new user"),
              )
            ],
          ),
          
        );
      },
      // //home: LoginPage(),
    );
  }
}
