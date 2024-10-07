import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.grey.withOpacity(0.2),
      child: Center(
        child: Lottie.asset('assets/lottie/Loader.json', height: 120, width: 120),
      ),
    );
  }
}
