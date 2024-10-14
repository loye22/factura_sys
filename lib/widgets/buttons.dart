import 'package:flutter/material.dart';

class CustomButtons extends StatefulWidget {
  final String label;
  final VoidCallback onPressed; // Callback function
  double width ;
  double higth ;

   CustomButtons({
    super.key,
    required this.label,
    required this.onPressed, // Add this
    this.width = 250 ,
    this.higth = 50
  });

  @override
  State<CustomButtons> createState() => _CustomButtonsState();
}

class _CustomButtonsState extends State<CustomButtons> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.higth,
      child: ElevatedButton(
        onPressed: widget.onPressed, // Use the provided callback
        child: Center(
          child: Text(
            widget.label, // Use the provided label
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15), // Sharp edges
          ),
          backgroundColor: Color(0xFF337AB7),
          minimumSize: Size(double.infinity, 50),
        ),
      ),
    );
  }
}
