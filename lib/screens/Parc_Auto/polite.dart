import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class polite extends StatefulWidget {
  const polite({super.key});

  @override
  State<polite> createState() => _politeState();
}

class _politeState extends State<polite> {
  @override
  Widget build(BuildContext context) {
    return Container( child: Center(child: Text("polite page ")),);
  }
}
