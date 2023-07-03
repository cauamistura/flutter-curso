import 'package:currency_converter/widgets/edit_currency.dart';
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
  State<ConvertPage> createState() => _ConvertPageState(priceUSD, priceEuro);
}

class _ConvertPageState extends State<ConvertPage> {
  _ConvertPageState(this.priceUSD, this.priceEuro);

  final double priceUSD;
  final double priceEuro;

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
            TextFieldCurr(
              controller: realController,
              labelText: 'Real R\$',
              prefix: 'R\$',
              changedFunction: _realChanged,
            ),
            const SizedBox(height: 12),
            TextFieldCurr(
              controller: usdController,
              labelText: 'Dolar UD\$',
              prefix: 'US\$',
              changedFunction: _usdChanged,
            ),
            const SizedBox(height: 12),
            TextFieldCurr(
              controller: euroController,
              labelText: 'Euro €',
              prefix: '€',
              changedFunction: _euroChanged,
            ),
          ],
        ),
      ),
    );
  }

  void _realChanged(value) {
    double valueReal = double.parse(value);
    usdController.text = (valueReal/priceUSD).toStringAsFixed(2);
    euroController.text = (valueReal/priceEuro).toStringAsFixed(2);
  }

  void _usdChanged(value) {
    double valueUSD = double.parse(value);
  }

  void _euroChanged(value) {
    double valueEuro = double.parse(value);
  }
}
