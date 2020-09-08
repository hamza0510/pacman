import 'package:flutter/material.dart';

class MyPath extends StatelessWidget {
  final innercolor;
  final outercolor;
  final child;

  MyPath({this.innercolor, this.outercolor, this.child}) {}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: EdgeInsets.all(12),
          color: outercolor,
          child: ClipRRect(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(color: innercolor, child: Center(child: child)),
            ),
          ),
        ),
      ),
    );
  }
}
