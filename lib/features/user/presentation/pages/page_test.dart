import 'package:flutter/material.dart';

class PageTest extends StatelessWidget {
  const PageTest({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Teste"),
      ),
      body: const Center(
        child: Text('Login feito com sucesso'),
      ),
    );
  }
}
