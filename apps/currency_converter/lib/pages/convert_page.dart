import 'package:flutter/material.dart';

class ConvertPage extends StatefulWidget {
  const ConvertPage({
    super.key,
    required this.priceUSD,
    required this.priceEuro,
  });

  final double priceUSD;
  final double priceEuro;

  @override
  State<ConvertPage> createState() => _ConvertPageState();
}

class _ConvertPageState extends State<ConvertPage> {
  final TextEditingController realController = TextEditingController();
  final TextEditingController usdController = TextEditingController();
  final TextEditingController euroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 9),
        child: Column(
          children: [
            const Icon(
              Icons.currency_exchange_rounded,
              size: 60,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: realController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Real R\$',
                  hintText: 'R\$',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: usdController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Dolar \$',
                  hintText: '\$',
                  border: OutlineInputBorder()),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: euroController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                  labelText: 'Euro €',
                  hintText: '€',
                  border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
    );
  }
}
