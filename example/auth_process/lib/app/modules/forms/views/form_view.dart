import 'package:flutter/material.dart';

class FormView extends StatelessWidget {
  const FormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("FormView")),
      body: const Column(
        children: [
          Text("data"),
        ],
      ),
    );
  }
}
