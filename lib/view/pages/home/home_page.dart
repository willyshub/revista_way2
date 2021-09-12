import 'package:flutter/material.dart';
import 'package:revista_way2/theme/app_size.dart';
import 'package:revista_way2/view/widgets/custom_drawer_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawerWidget(),
      body: NestedScrollView(
        headerSliverBuilder: (context, bool a) {
          return [
            SliverAppBar(
              centerTitle: true,
              title: RichText(
                text: TextSpan(
                  text: "Revista",
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20.0),
                  children: [
                    TextSpan(
                        text: "WAY",
                        style: TextStyle(fontWeight: FontWeight.w300))
                  ],
                ),
              ),
              actions: [
                IconButton(onPressed: () {
                  Navigator.pushNamed(context, "/send");
                }, icon: Icon(Icons.upload_rounded)),
                SizedBox(width: AppSize.defaultPadding),
                IconButton(onPressed: () {
                  Navigator.pushNamed(context, "/login");
                }, icon: Icon(Icons.person)),
                SizedBox(width: AppSize.defaultPadding),
              ],
            )
          ];
        },
        body: Container(),
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