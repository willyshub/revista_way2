import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revista_way2/view-model/auth/auth_firebase.dart';
import 'package:revista_way2/view-model/send_vm.dart';
import 'app_widget.dart';
import 'view-model/home_vm.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance
      .activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text("Algo deu Errado", overflow: TextOverflow.ellipsis,),
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            //return HomeTest(initialization: _initialization);
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<SendVM>(
                  create: (_) => SendVM(),
                  //lazy: true,
                ),
                ChangeNotifierProvider<HomeVM>(
                  create: (_) => HomeVM(),
                  lazy: false,
                ),
                ChangeNotifierProvider<AuthFirebase>(
                  create: (_) => AuthFirebase(),
                  lazy: false,
                ),
              ],
              child: AppWidget(
                initialization: _initialization,
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
    //return AppWidget();
  }
}
