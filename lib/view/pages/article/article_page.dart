// import 'package:flutter/material.dart';
// import 'package:revista_way2/model/article_model.dart';
// import 'package:revista_way2/theme/app_size.dart';
// import 'package:revista_way2/theme/app_text_styles.dart';
// import 'package:revista_way2/view/widgets/title_widget.dart';
import '/exports/my_classes.dart';

import 'components/button_icon_text.dart';

class ArticlePage extends StatelessWidget {
  ArticlePage({Key? key, required this.article}) : super(key: key);
  final Article article;

  final List<String> authorsLocal = [
    "Wilys Silva dos Santos Pereira",
    "Wilys Silva dos Santos Pereira",
    "Wilys Silva dos Santos Pereira",
    "Wilys Silva dos Santos Pereira",
    "Wilys Silva dos Santos Pereira",
  ];

  final List<String> refsLocal = [
    "https://bloclibrary.dev/",
    "https://bloclibrary.dev/",
    "https://bloclibrary.dev/",
    "https://bloclibrary.dev/",
    "https://bloclibrary.dev/",
    "https://bloclibrary.dev/",
    "https://bloclibrary.dev/",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 60,
            expandedHeight: 100.0,
            collapsedHeight: 60.0,
            floating: true,
            pinned: true,
            centerTitle: true,
            leading: TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: Text(
                "Artigo",
                style: AppTextStyles.titleRegular,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSize.defaultPadding,
                    vertical: AppSize.defaultPadding,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleWidget(
                        title: article.title,
                      ),
                      Text(
                        article.abstract,
                        style: AppTextStyles.trailingRegular,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: AppSize.defaultPadding / 3,
                        ),
                        child: Row(
                          children: [
                            ButtonIconTextWidget(
                              icon: Icons.menu_book_rounded,
                              text: "LER ARTIGO",
                              function: () {},
                            ),
                            SizedBox(
                              width: AppSize.defaultPadding / 3,
                            ),
                            ButtonIconTextWidget(
                              icon: Icons.download_rounded,
                              text: "BAIXAR",
                              function: () {},
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: AppSize.defaultPadding,
                      ),
                      Text(
                        "Autores: ",
                        style: AppTextStyles.buttonBoldHeading,
                      ),
                      Column(
                        children: article.authors
                            .map(
                              (name) => Text(
                                name,
                                style: AppTextStyles.buttonGray,
                              ),
                            )
                            .toList(),
                      ),
                      SizedBox(
                        height: AppSize.defaultPadding,
                      ),
                      Text(
                        "Referências: ",
                        style: AppTextStyles.buttonBoldHeading,
                      ),
                      Column(
                        children: article.ref
                            .map(
                              (name) => Text(
                                name,
                                style: AppTextStyles.buttonGray,
                              ),
                            )
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: AppColors.primary,
      //   child: IconButton(
      //     onPressed: () {},
      //     icon: const Icon(Icons.download_rounded),
      //   ),
      // ),
    );
  }
}
