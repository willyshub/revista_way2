import 'package:flutter/material.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/view/pages/home/send_page/app_colors.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, bool a) {
          return [
            SliverAppBar(
              centerTitle: true,
              title: RichText(
                text: TextSpan(
                  text: "Login",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
                  children: [
                    TextSpan(text: ""),
                  ],
                ),
              ),
              actions: [],
            )
          ];
        },
        body: body(context),
      ),
    );
  }
}

Widget body(BuildContext context) {
  return Container(
    padding: EdgeInsets.all(AppSize.defaultPadding * 2),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Login',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'Email',
            suffixIcon: Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            suffixIcon: Icon(Icons.visibility_off),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Esqueceu a senha?',
                style: TextStyle(fontSize: 12.0),
              ),
              TextButton(
                child: Text('Login'),
                onPressed: () {},
              ),
            ],
          ),
        ),
        SizedBox(height: 20.0),
        GestureDetector(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context)=>Second()));
          },
          child: Text.rich(
            TextSpan(text: 'Não tem uma conta? ', children: [
              TextSpan(
                text: 'Signup',
                style: TextStyle(color: AppColors.primary),
              ),
            ]),
          ),
        ),
      ],
    ),
  );
}
