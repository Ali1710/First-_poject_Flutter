import 'package:flutter_application_1/features/crypto_coin/crypto_coin.dart';
import 'package:flutter_application_1/features/crypto_list/crypto_list.dart';

final routes = {
  '/': (context) => const CryptoListScreen(title: 'Crypto'),
  '/coin': (context) => const CryptoCoinScreen(),
};