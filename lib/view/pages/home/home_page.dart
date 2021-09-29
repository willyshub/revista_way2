import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revista_way2/services/database.dart';
import 'package:revista_way2/theme/app_colors.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_text_styles.dart';
import 'package:revista_way2/view-model/home_vm.dart';
import 'package:revista_way2/view/pages/article/article_page.dart';
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
            onPressed: () async {
              final User? user = FirebaseAuth.instance.currentUser;
              if (user != user) {
                Navigator.pushNamed(context, "/send");
              } else {
                await Navigator.pushNamed(context, "/login")
                    .then((value) => Navigator.pushReplacementNamed(context, "/send"));
              }
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
    final provider = Provider.of<HomeVM>(context, listen: false);

    return ListView.separated(
      separatorBuilder: (_, index) {
        return SizedBox(
          height: AppSize.defaultPadding * 0.8,
        );
      },
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: AppSize.defaultPadding * 0.8),
      itemCount: provider.allArticles.length,
      shrinkWrap: true,
      itemBuilder: (_, index) {
        return Card(
          elevation: 2,
          child: ListTile(
            contentPadding: EdgeInsets.all(AppSize.defaultPadding),
            selectedTileColor: AppColors.primary.withOpacity(0.1),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ArticlePage(article: provider.allArticles[index])));
            },
            title: Text(
              provider.allArticles[index].title,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.titleListTile,
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.only(top: AppSize.defaultPadding * 0.3),
                    child: Text(
                      provider.allArticles[index].abstract,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.trailingRegular,
                    )),
                Padding(
                  padding: EdgeInsets.only(top: AppSize.defaultPadding * 0.3),
                  child: RichText(
                      text: TextSpan(
                          text: "Autor: ",
                          style: AppTextStyles.buttonBoldHeading,
                          children: [
                        TextSpan(
                          text: provider.allArticles[index].authors[1],
                          style: AppTextStyles.buttonHeading,
                        ),
                      ])),
                ),
              ],
            ),
            isThreeLine: true,
          ),
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