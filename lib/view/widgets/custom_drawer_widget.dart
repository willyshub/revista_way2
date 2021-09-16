import 'package:flutter/material.dart';
import 'package:revista_way2/theme/app_size.dart';

import 'item_drawer_widget.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: AppSize.getHeight(context),
      color: Colors.white.withOpacity(0.9),
      child: ListView(
        children: [
          ItemDrawerWidget(
            fun: () {},
            icon: Icons.notes,
            text: "Sobre",
          ),
          ItemDrawerWidget(
            fun: () {},
            icon: Icons.contacts,
            text: "Contatos",
          ),
          ItemDrawerWidget(
            fun: () {},
            icon: Icons.bookmarks_rounded,
            text: "Meus artigos",
          ),
          ItemDrawerWidget(
            fun: () {},
            icon: Icons.admin_panel_settings,
            text: "Painel ADM",
          ),
        ],
      ),
    );
  }
}
