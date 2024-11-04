

import 'package:factura_sys/models/staticVar.dart';
import 'package:factura_sys/widgets/notidicationsAnimationIcon.dart';
import 'package:factura_sys/widgets/settingAnimationIcon.dart';
import 'package:flutter/material.dart';

class footer extends StatelessWidget {
  const footer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: staticVar.fullhigth(context) * .055,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.grey[800], // Matches the footer background color
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SettingsIcon(),
          CircleAvatar(
            radius: 16, // Adjust the size as needed
            backgroundImage: AssetImage(
                'assets/avatar.png'), // Replace with your avatar image path
          ),
          NotificationIcon(), // Notification icon with dropdown menu
        ],
      ),
    );
  }
}