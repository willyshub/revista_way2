import 'package:flutter/material.dart';

import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_text_styles.dart';
import 'package:revista_way2/theme/app_colors.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

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
                  style: AppTextStyles.titleRegular,
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
    padding: EdgeInsets.symmetric(horizontal: AppSize.defaultPadding * 2),
    child: ListView(
      children: [
        SizedBox(
          height: 30.0,
        ),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Seu nome completo',
            prefixIcon: Icon(Icons.person),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        SizedBox(height: AppSize.defaultPadding * 2),
        TextFormField(
          enableSuggestions: true,
          enableInteractiveSelection: true,
          decoration: InputDecoration(
            hintText: 'Onde você estuda?',
            prefixIcon: Icon(Icons.school_rounded),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
        ),
        SizedBox(height: AppSize.defaultPadding * 2),
        TextButton(
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
        ),
        SizedBox(height: AppSize.defaultPadding * 2),
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
        SizedBox(height: AppSize.defaultPadding * 2),
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

      // fieldViewBuilder: (
      //   context,
      //   textEditingController,
      //   focusNode,

      // ) {
      //   return Container();
      // },
      onSelected: (String selection) {
        print('You just selected ${_displayStringForOption(selection)}');
      },
    );
  }
}
