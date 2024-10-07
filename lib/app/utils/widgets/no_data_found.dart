import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class NoDataFound extends StatelessWidget {
  const NoDataFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Lottie.asset('assets/lottie/no_data.json'),
          const SizedBox(height: 5),
          const Text(
            'No Data Found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}
