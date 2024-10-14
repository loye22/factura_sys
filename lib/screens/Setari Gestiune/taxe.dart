import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class taxe extends StatefulWidget {
  const taxe({super.key});

  @override
  State<taxe> createState() => _taxeState();
}

class _taxeState extends State<taxe> {
  @override
  Widget build(BuildContext context) {
    return Container( child: Center(child: Text("taxe page ")),);
  }
}
