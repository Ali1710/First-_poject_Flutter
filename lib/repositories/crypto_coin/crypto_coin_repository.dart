import 'package:flutter_application_1/repositories/crypto_coin/models/crypto_coin.dart';
import 'package:dio/dio.dart';
import 'package:flutter_application_1/repositories/crypto_coin/abstract_coin_repository.dart';

class CryptoCoinRepository implements AbstractCoinRepository {
  CryptoCoinRepository({required this.dio});

  final Dio dio;

  

  @override
  Future<List<CryptoCoin>> getCoinList() async {
    final response = await dio.get(
          'https://min-api.cryptocompare.com/data/pricemultifull?fsyms=BTC,ETH,BNB,AVAX,AID,SOL,DOGE,DOW&tsyms=USD');
        
    final data = response.data as Map<String, dynamic>;
    final dataRaw = data['RAW'] as Map<String, dynamic>;
    final cryptoCoinList = dataRaw.entries
        .map((e) { 
          final usdData = (e.value as Map<String, dynamic>)['USD'] as Map<String, dynamic>;
          final price = usdData['PRICE'];
          final imageUrl = usdData['IMAGEURL'];
          return CryptoCoin(
            name: e.key,
            priceInUSD: price,
            imageUrl: 'https://www.cryptocompare.com/$imageUrl',
          );
        })
        .toList();
    return cryptoCoinList;
  }
}