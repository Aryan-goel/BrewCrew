import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.brown[500],
      child: Center(
        child: SpinKitWave(
          color: Colors.brown[900],
          size: 60,
        ),
      ),
    );
  }
}
