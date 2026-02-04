import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/features/crypto_list/bloc/crypto_list_bloc.dart';
import 'package:flutter_application_1/features/crypto_list/widgets/crypto_coin_tile.dart';
import 'package:flutter_application_1/repositories/crypto_coin/abstract_coin_repository.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';

@RoutePage()
class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});
  
  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  late final CryptoListBloc _bloc;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _bloc = CryptoListBloc(GetIt.I<AbstractCoinsRepository>());
    _bloc.add(LoadCryptoList());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _bloc.close();
    super.dispose();
  }

  Future<void> _refresh() async {
    final completer = Completer();
    _bloc.add(LoadCryptoList(completer: completer));
    await completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        title: const Text('Crypto'),
        actions: [
          IconButton( 
            onPressed: () {
              // ПРАВИЛЬНЫЙ ВАРИАНТ: 
              // Для внешних экранов, которых нет в AppRouter, используем Navigator.
              // Если добавишь TalkerScreen в AppRouter, тогда вызывай context.pushRoute(const TalkerRoute())
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => TalkerScreen(talker: GetIt.I<Talker>()),
                ),
              );
            },
            icon: const Icon(Icons.document_scanner_outlined),
          ),
        ],
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        color: Colors.yellowAccent,
        child: BlocBuilder<CryptoListBloc, CryptoListState>(
          bloc: _bloc,
          builder: (context, state) {
            // 1) УСПЕХ
            if (state is CryptoListLoaded) {
              return ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(top: 8, bottom: 12),
                itemCount: state.coinsList.length,
                itemBuilder: (context, i) => CryptoCoinTile(coin: state.coinsList[i]),
              );
            }

            // 2) ОШИБКА
            if (state is CryptoListLoadingFailure) {
              return ListView(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  const SizedBox(height: 80),
                  const Icon(Icons.error_outline, color: Colors.redAccent, size: 64),
                  const SizedBox(height: 12),
                  const Center(
                    child: Text(
                      'Failed to load crypto list',
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Please check your internet connection or tap below to retry.',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14, color: Colors.white54),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.yellowAccent),
                      onPressed: () => _bloc.add(LoadCryptoList()), 
                      child: const Text('Retry', style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ],
              );
            }

            // 3) ЗАГРУЗКА
            return ListView(
              controller: _scrollController,
              physics: const AlwaysScrollableScrollPhysics(),
              children: const [
                SizedBox(height: 120),
                Center(child: CircularProgressIndicator(color: Colors.yellowAccent)),
              ],
            );
          },
        ),
      ),
    );
  }
}