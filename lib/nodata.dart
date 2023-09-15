import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class nodata extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, // Make the container take up the full width of the screen
        height: double.infinity, // Make the container take up the full height of the screen
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.purple],
          ),
        ),
        child: Center(
          child: Lottie.asset(
            'assets/animation.json',
            fit: BoxFit.cover,
            reverse: false,
            repeat: false,
          ),
        ),
      ),
    );
  }
}
