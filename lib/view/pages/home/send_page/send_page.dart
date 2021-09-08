import 'package:flutter/material.dart';

class SendPage extends StatelessWidget {
  const SendPage({Key? key}) : super(key: key);

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
                    text: "Enviar", children: [TextSpan(text: " Arquiv")]),
              ),
            )
          ];
        },
        body: Container(),
      ),
    );
  }
}
