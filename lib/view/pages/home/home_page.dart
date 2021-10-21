import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revista_way2/theme/app_colors.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/theme/app_text_styles.dart';
import 'package:revista_way2/view-model/home_vm.dart';
import 'package:revista_way2/view/pages/article/article_page.dart';
import 'package:revista_way2/view/widgets/custom_drawer_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: scaffoldKey,
        drawer: const CustomDrawerWidget(),
        body: NestedScrollView(
          physics: const NeverScrollableScrollPhysics(),
          headerSliverBuilder: (context, bool a) {
            return [
              SliverAppBar(
                backgroundColor: AppColors.primary,
                centerTitle: true,
                floating: true,
                elevation: AppSize.defaultElevation,
                title: RichText(
                  text: TextSpan(
                    text: "Revista",
                    style: AppTextStyles.titleLight,
                    children: [
                      TextSpan(
                        text: "WAY",
                        style: AppTextStyles.titleRegular,
                      )
                    ],
                  ),
                ),
                actions: [
                  IconButton(
                    tooltip: "Usuário logado",
                    onPressed: () {
                      Navigator.pushNamed(context, "/login");
                    },
                    icon: Visibility(
                      replacement: const Icon(Icons.person),
                      visible: false,
                      child: ClipOval(
                        child: Material(
                          color: AppColors.primary.withOpacity(0.3),
                          child: Image.network(
                            "",
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: AppSize.defaultPadding / 3),
                ],
              )
            ];
          },
          body: const ListArticles(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Firebase.initializeApp();
            final User? user = FirebaseAuth.instance.currentUser;

            if (user != null) {
              if (!mounted) return;
              // ja ta logado, go to send page
              Navigator.pushNamed(context, "/send");
            } else {
              if (!mounted) return;
              await Navigator.pushNamed(context, "/login").then((value) {
                Navigator.pushReplacementNamed(context, "/home");
              });
            }
          },
          backgroundColor: AppColors.primary,
          child: const Icon(Icons.upload_rounded),
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
    final providerNotListen = Provider.of<HomeVM>(context, listen: false);

    return FutureBuilder<QuerySnapshot>(
        future: providerNotListen.loadAllArticles(),
        builder: (context, futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                SizedBox(height: AppSize.defaultPadding * 5),
                const Center(
                  child: SizedBox(
                    height: 50.0,
                    width: 50.0,
                    child: CircularProgressIndicator(
                      strokeWidth: 1.5,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                SizedBox(height: AppSize.defaultPadding),
                Text(
                  "Carregando...",
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.titleListTile,
                )
              ],
            );
          }

          if (futureSnapshot.connectionState == ConnectionState.done &&
              providerNotListen.allArticles.isNotEmpty) {
            return RefreshIndicator(
              edgeOffset: 10.0,
              displacement: 20.0,
              triggerMode: RefreshIndicatorTriggerMode.anywhere,
              onRefresh: () async {
                final provider = Provider.of<HomeVM>(context, listen: false);
                await provider.loadAllArticles();
              },
              child: ListView.separated(
                separatorBuilder: (_, index) {
                  return SizedBox(
                    height: AppSize.defaultPadding * 0.8,
                  );
                },
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.only(top: AppSize.defaultPadding * 0.8),
                itemCount: Provider.of<HomeVM>(context, listen: true)
                    .allArticles
                    .length,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSize.defaultPadding),
                    child: Card(
                      elevation: 2,
                      child: ListTile(
                        contentPadding: EdgeInsets.all(AppSize.defaultPadding),
                        selectedTileColor: AppColors.primary.withOpacity(0.1),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArticlePage(
                                      article: providerNotListen
                                          .allArticles[index])));
                        },
                        title: Text(
                          providerNotListen.allArticles[index].title,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.titleListTile,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: EdgeInsets.only(
                                    top: AppSize.defaultPadding * 0.3),
                                child: Text(
                                  providerNotListen.allArticles[index].abstract,
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyles.trailingRegular,
                                )),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: AppSize.defaultPadding * 0.3),
                              child: RichText(
                                  text: TextSpan(
                                      text: "Autor: ",
                                      style: AppTextStyles.buttonBoldHeading,
                                      children: [
                                    TextSpan(
                                      text: providerNotListen
                                          .allArticles[index].authors[0],
                                      style: AppTextStyles.buttonHeading,
                                    ),
                                  ])),
                            ),
                          ],
                        ),
                        isThreeLine: true,
                      ),
                    ),
                  );
                },
              ),
            );
          }
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Não foi possível carregar os artigos. Entre em contato com os administradores",
                textAlign: TextAlign.center,
                style: AppTextStyles.titleListTile,
              ),
            ),
          );
        });
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