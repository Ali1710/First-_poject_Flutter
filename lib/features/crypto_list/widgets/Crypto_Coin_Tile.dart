// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/repositories/crypto_coin/models/crypto_coin.dart';

class Cryptocointile extends StatelessWidget {
  const Cryptocointile({
    super.key,
    required this.coin,
  });

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    return ListTile(
    leading: Image.network(coin.imageUrl),
    title: 
    Text(coin.name,
      style: 
      Theme.of(context).textTheme.bodyMedium,
    ),
    subtitle: 
    Text('${coin.priceInUSD}\$',
      style: 
      Theme.of(context).textTheme.bodySmall,
    ),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.of(context).pushNamed('/coin',
      arguments: coin,
      );
    },
      );
  }
}
 