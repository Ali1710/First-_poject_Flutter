import 'package:flutter_application_1/repositories/crypto_coin/models/crypto_coin.dart';
import 'package:flutter_application_1/repositories/crypto_coin/models/crypto_coin_details.dart';

abstract class AbstractCoinsRepository {
  Future<List<CryptoCoin>> getCoinsList();
  Future<CryptoCoinDetail> getCoinDetails(String currencyCode);
}