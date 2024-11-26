

import 'package:flutter/material.dart';

class headerWidget extends StatelessWidget {
  const headerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      color: const Color(0xff10277C),
      child: Center(
        child: Text(
          'FINOPS',
          style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
    );
  }
}
