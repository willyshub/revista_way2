import 'package:flutter/material.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_colors.dart';
import 'package:revista_way2/view-model/auth/auth_firebase.dart';
import 'package:revista_way2/view/pages/login/google_sign_in_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.body,
      body: Center(child: body(context)),
    );
  }
}

Widget body(BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: AppSize.defaultPadding * 2),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: AppSize.defaultPadding),
                  child: Image.asset(
                    'assets/images/logo.png',
                    filterQuality: FilterQuality.high,
                    height: 300.0,
                  ),
                ),
              ],
            ),
          ),
          FutureBuilder(
            future: AuthFirebase.initializeFirebase(context),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Erro ao inicializar o Firebase');
              } else if (snapshot.connectionState == ConnectionState.done) {
                return GoogleSignInButton();
              }
              return const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.body,
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

class AutocompleteForm extends StatelessWidget {
  const AutocompleteForm({
    Key? key,
  }) : super(key: key);

  static const List<String> _userOptions = [
    "oi",
    "Universidade Federal do Vale do São Francisco",
  ];

  static String _displayStringForOption(String option) => option;

  @override
  Widget build(BuildContext context) {
    return Autocomplete<String>(
      displayStringForOption: _displayStringForOption,
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text == '') {
          return const Iterable<String>.empty();
        }
        return _userOptions.where((String option) {
          return option.toString().toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
        });
      },
      onSelected: (String selection) {
        print('You just selected ${_displayStringForOption(selection)}');
      },
    );
  }
}



   // fieldViewBuilder: (
      //   context,
      //   textEditingController,
      //   focusNode,

      // ) {
      //   return Container();
      // },

/*  RichText(
                  text: const TextSpan(
                    text: 'Revista',
                    style:
                        TextStyle(fontWeight: FontWeight.w800, fontSize: 50.0),
                    children: [
                      TextSpan(
                        text: 'WAY',
                        style: TextStyle(fontWeight: FontWeight.w300),
                      ),
                    ],
                  ),
                ), */

                /* return TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.all(AppSize.defaultPadding),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: AppSize.defaultPadding),
                        child: Image.asset(
                          'assets/images/google.png',
                          filterQuality: FilterQuality.high,
                          height: 30.0,
                          width: 30.0,
                        ),
                      ),
                      Text(
                        "Cadastre-se com o Google",
                        style: AppTextStyles.titleRegular,
                      )
                    ],
                  ),
                ); */

                 /* TextFormField(
            decoration: InputDecoration(
              hintText: 'Seu nome completo',
              prefixIcon: const Icon(Icons.person),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          SizedBox(height: AppSize.defaultPadding * 2),
          TextFormField(
            decoration: InputDecoration(
              hintText: 'Onde você estuda?',
              prefixIcon: const Icon(Icons.school_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ), */
          //SizedBox(height: AppSize.defaultPadding * 2),