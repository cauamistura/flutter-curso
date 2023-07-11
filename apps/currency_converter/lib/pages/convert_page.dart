import 'dart:ffi';

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
  // ignore: no_logic_in_create_state
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
    if (!_validateContent(value)) {
      return;
    }
    double valueReal = double.parse(value);
    usdController.text = (valueReal / priceUSD).toStringAsFixed(2);
    euroController.text = (valueReal / priceEuro).toStringAsFixed(2);
  }

  void _usdChanged(value) {
    if (!_validateContent(value)) {
      return;
    }
    double valueUSD = double.parse(value);
    realController.text = (valueUSD * priceUSD).toStringAsFixed(2);
    euroController.text =
        ((valueUSD * priceUSD) / priceEuro).toStringAsFixed(2);
  }

  void _euroChanged(value) {
    if (!_validateContent(value)) {
      return;
    }
    double valueEuro = double.parse(value);
    realController.text = (valueEuro * priceEuro).toStringAsFixed(2);
    usdController.text =
        ((valueEuro * priceEuro) / priceUSD).toStringAsFixed(2);
  }

  void _clearAll() {
    realController.text = "";
    usdController.text = "";
    euroController.text = "";
  }

  bool _validateContent(String value) {
    if (value.isEmpty) {
      _clearAll();
      return false;
    }
    return true;
  }
}
