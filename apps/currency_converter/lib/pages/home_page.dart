import 'package:currency_converter/api.dart';
import 'package:currency_converter/pages/convert_page.dart';
import 'package:currency_converter/pages/error_page.dart';
import 'package:currency_converter/pages/loading_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Conversor de Moedas!'),
      ),
      body: FutureBuilder<Map>(
        future: API.getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const LoadingPage();
            default:
              if (!snapshot.hasError) {
                return ConvertPage(
                  priceUSD: double.parse(snapshot.data?['USDBRL']['ask']),
                  priceEuro: double.parse(snapshot.data?['EURBRL']['ask']),
                );
              } else {
                return const ErrorPage();
              }
          }
        },
      ),
    );
  }
}
