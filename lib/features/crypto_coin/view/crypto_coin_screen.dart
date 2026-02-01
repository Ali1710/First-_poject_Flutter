import 'package:flutter/material.dart';

class CryptoCoinScreen extends StatefulWidget {
  const CryptoCoinScreen({super.key});

  @override
  State<CryptoCoinScreen> createState() => _CryptoCoinScreenState();
}

class _CryptoCoinScreenState extends State<CryptoCoinScreen> {
  String? coinName;
  @override
  void didChangeDependencies() {
    final args = ModalRoute.of(context)?.settings.arguments;
    assert(args != null && args is String,
        'You must provide a non-null String argument to CryptoCoinScreen');
    // ignore: dead_code
    coinName = args as String;
    setState(() {
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final Object? args = ModalRoute.of(context)?.settings.arguments;
    final String? coinId = args is String
        ? args
        : (args is Map && args['id'] is String ? args['id'] as String : null);

    if (coinId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Coin')),
        body: const Center(child: Text('No coin id provided')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(coinName ?? '...')),
      body: Container(), // Placeholder for the existing UI using coinId
    );
  }
}