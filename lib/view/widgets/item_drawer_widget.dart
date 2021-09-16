import 'package:flutter/material.dart';
import 'package:revista_way2/theme/app_size.dart';

class ItemDrawerWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback fun;
  const ItemDrawerWidget(
      {Key? key, required this.text, required this.icon, required this.fun})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSize.defaultPadding * 4,
      child: TextButton(
        onPressed: fun,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
        ),
        child: Padding(
          padding: EdgeInsets.all(AppSize.defaultPadding),
          child: Row(
            children: [
              Icon(
                icon,
                color: Colors.grey[800],
              ),
              SizedBox(
                width: AppSize.defaultPadding / 2,
              ),
              Text(
                text,
                style: TextStyle(
                  fontSize: 18.0,
                  color: Colors.grey[800],
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
