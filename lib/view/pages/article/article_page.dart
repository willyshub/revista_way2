import 'package:flutter/material.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_text_styles.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

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
                  text: "Nome do artigo",
                  style: AppTextStyles.titleRegular,
                  children: const [
                    TextSpan(
                      text: "",
                    )
                  ],
                ),
              ),
            )
          ];
        },
        body: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: AppSize.defaultPadding,
            vertical: AppSize.defaultPadding,
          ),
          shrinkWrap: true,
          children: const [],
        ),
      ),
    );
  }
}
