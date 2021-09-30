import 'package:flutter/material.dart';
import 'package:revista_way2/theme/app_colors.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_text_styles.dart';

import 'item_drawer_widget.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSize.getWidth(context) * 0.7,
      height: AppSize.getHeight(context),
      color: Colors.white.withOpacity(0.9),
      child: ListView(
        children: [
          ItemDrawerWidget(
            fun: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Scaffold(
                  body: Stack(
                    children: [
                      Container(
                        height: AppSize.getHeight(context),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft,
                              colors: [
                                AppColors.primary.withOpacity(0.6),
                                AppColors.primary,
                              ]),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: AppSize.getHeight(context) * 0.1),
                        width: AppSize.getWidth(context),
                        height: AppSize.getHeight(context),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              "DESENVOLVEDOR",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.titleRegular,
                            ),
                            Text(
                              "Willys Silva",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.titleRegular,
                            ),
                            Text(
                              "willysangelo@gmail.com",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.titleRegular,
                            ),
                            const Divider(), // ----------------------
                            Text(
                              "EDITOR",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.titleRegular,
                            ),
                            Text(
                              "Andressa Menezes",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.titleRegular,
                            ),
                            Text(
                              "andressa.menezes@discente.univasf.edu.br",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.titleRegular,
                            ),
                            const Divider(), // ----------------------
                            Text(
                              "EDITOR",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.titleRegular,
                            ),
                            Text(
                              "Yure Santos",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.titleRegular,
                            ),
                            Text(
                              "yure.santos@discente.univasf.edu.br",
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                              style: AppTextStyles.titleRegular,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }));
            },
            icon: Icons.contacts,
            text: "Contatos",
          ),
          ItemDrawerWidget(
            fun: () {},
            icon: Icons.notes,
            text: "Sobre (Em breve)",
          ),
          ItemDrawerWidget(
            fun: () {},
            icon: Icons.bookmarks_rounded,
            text: "Meus artigos (Em breve)",
          ),
          ItemDrawerWidget(
            fun: () {},
            icon: Icons.admin_panel_settings,
            text: "Painel ADM (Em breve)",
          ),
        ],
      ),
    );
  }
}
