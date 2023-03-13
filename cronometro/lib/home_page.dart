import 'package:flutter/material.dart';

import 'cronometro.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required String title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blue[900],
        alignment: Alignment.center,
        child: const Cronometro(),
      ),
    );
  }
}
