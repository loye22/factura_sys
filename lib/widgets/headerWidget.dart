

import 'package:flutter/material.dart';

class headerWidget extends StatelessWidget {
  const headerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: const Color(0xff444444),
      child: Row(
        children: [
          Icon(Icons.description, color: Colors.white, size: 35),
          SizedBox(width: 10),
          Text(
            'FinoPro',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ],
      ),
    );
  }
}
