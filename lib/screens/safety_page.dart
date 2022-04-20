import 'package:flutter/material.dart';

class SafetyPage extends StatefulWidget {
  const SafetyPage({Key? key}) : super(key: key);

  @override
  State<SafetyPage> createState() => _SafetyPageState();
}

class _SafetyPageState extends State<SafetyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Safety'),
      ),
      body: const Center(
        child: Text('Safety'),
      ),
    );
  }
}
