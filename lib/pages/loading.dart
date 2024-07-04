import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[200],
        body: Center(
          child: SpinKitSpinningLines(
            color: Colors.white,
            size: 80.0,
          ),
        )
    );
  }
}
class LoadingScroll extends StatelessWidget {
  const LoadingScroll({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          color: Colors.lightBlue[100],
          child: Center(
            child: SpinKitWave(
              color: Colors.white,
              size: 30.0,
            ),
          ),
        ),
      ],
    );
  }
}
