import 'package:flutter/material.dart';
import 'package:flutter_application_1/repositories/crypto_coin/models/crypto_coin.dart';

class CryptoCoinTile extends StatelessWidget {
  const CryptoCoinTile({super.key, required this.coin});

  final CryptoCoin coin;

  @override
  Widget build(BuildContext context) {
    return CryptoCardTile(
      leading: Image.network(
        coin.imageUrl,
        width: 36,
        height: 36,
        errorBuilder: (_, __, ___) =>
            const Icon(Icons.currency_bitcoin, color: Colors.white70),
      ),
      title: coin.name,
      subtitle: '${coin.priceInUSD}\$',
      onTap: () => Navigator.of(context).pushNamed('/coin', arguments: coin),
    );
  }
}

class RetryTile extends StatelessWidget {
  const RetryTile({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CryptoCardTile(
      leading: const Icon(Icons.refresh, color: Colors.white70, size: 28),
      title: 'Try Again',
      subtitle: 'Tap to reload crypto list',
      onTap: onTap,
    );
  }
}

/// ОДИН универсальный “бокс”
/// Он и есть “коробка”. Она ВНУТРИ списка => будет двигаться вместе со списком.
class CryptoCardTile extends StatelessWidget {
  const CryptoCardTile({
    super.key,
    required this.leading,
    required this.title,
    this.subtitle,
    this.onTap,
  });

  final Widget leading;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Material(
        color: const Color(0xFF1C1C1C),
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: const Color(0xFF2A2A2A)),
            ),
            child: Row(
              children: [
                SizedBox(width: 40, height: 40, child: Center(child: leading)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: const TextStyle(
                            color: Colors.white54,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: Colors.white54),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
