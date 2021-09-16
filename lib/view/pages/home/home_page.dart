import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:revista_way2/services/database.dart';
import 'package:revista_way2/theme/app_colors.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_text_styles.dart';
import 'package:revista_way2/view/pages/send_page/componentes/title_widget.dart';
import 'package:revista_way2/view/widgets/custom_drawer_widget.dart';

class HomePage extends StatelessWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  final database = Database();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: const CustomDrawerWidget(),
        body: NestedScrollView(
          headerSliverBuilder: (context, bool a) {
            return [
              SliverAppBar(
                centerTitle: true,
                floating: true,
                elevation: AppSize.defaultElevation,
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
          body: const ListArticles(),
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
      ),
    );
  }
}

class ListArticles extends StatelessWidget {
  const ListArticles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      
      separatorBuilder: (_, index){
        return SizedBox(height: AppSize.defaultPadding * 0.8,);
      },
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: AppSize.defaultPadding * 0.8),
      itemCount: 20,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return ListTile(
          onTap: () {
            Navigator.pushNamed(context, "/article");
          },
          title: Text(
            "Uso de tecnlogia no ambito empresarial",
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles.titleListTile,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: AppSize.defaultPadding * 0.3),
                child: Text(
                  "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available",
                  style: AppTextStyles.trailingRegular,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: AppSize.defaultPadding * 0.3),
                child: Text(
                  "Autor: Andressa",
                  style: AppTextStyles.buttonHeading,
                ),
              ),
            ],
          ),
          isThreeLine: true,
        );
      },
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