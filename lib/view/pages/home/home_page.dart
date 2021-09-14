import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:revista_way2/services/database.dart';
import 'package:revista_way2/theme/app_colors.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_text_styles.dart';
import 'package:revista_way2/view/widgets/custom_drawer_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  final database = Database();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawerWidget(),
      body: NestedScrollView(
        headerSliverBuilder: (context, bool a) {
          return [
            SliverAppBar(
              centerTitle: true,
              title: RichText(
                text: TextSpan(
                  text: "Revista",
                  style: AppTextStyles.titleRegular,
                  children: [
                    TextSpan(
                      text: "WAY",
                      style: AppTextStyles.titleLight,
                    )
                  ],
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  icon: const Icon(Icons.person),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.more_vert_rounded),
                ),
                SizedBox(width: AppSize.defaultPadding / 3),
              ],
            )
          ];
        },
        body: Container(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/send");
          },
          icon: const Icon(Icons.upload_rounded),
        ),
      ),
    );
  }
}



/*

return Scaffold(
      drawer: CustomDrawerWidget(),
      body: NestedScrollView(
      
        headerSliverBuilder: (context, bool a) {
          return [
            SliverAppBar(
              centerTitle: true,
              title: RichText(
                text: TextSpan(
                    text: "Revista", children: [TextSpan(text: "WAY")]),
              ),
              actions: [
                IconButton(onPressed: () {}, icon: Icon(Icons.upload_file))
              ],
            )
          ];
        },
        body: Container(),
      ),
    );

*/