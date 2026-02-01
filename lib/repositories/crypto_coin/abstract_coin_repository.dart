import 'package:flutter_application_1/repositories/crypto_coin/models/crypto_coin.dart';

abstract class AbstractCoinRepository {
  Future<List<CryptoCoin>> getCoinList();
}