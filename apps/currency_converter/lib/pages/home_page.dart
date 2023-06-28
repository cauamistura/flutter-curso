import 'dart:ffi';

import 'package:currency_converter/api.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:loading_animation_widget/loading_animation_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double priceUSD = 0;
  double priceEuro = 0;

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
              return Center(
                  child: LoadingAnimationWidget.fallingDot(
                      color: Colors.black, size: 75));
            default:
              if (!snapshot.hasError) {
                priceUSD = double.parse(snapshot.data?['USDBRL']['ask']);
                priceEuro = double.parse(snapshot.data?['EURBRL']['ask']);
                print('$priceEuro, $priceUSD');
                return const Center(
                  child: Text('Carregado...'),
                );
              } else {
                return const Center(
                  child: Text('Erro'),
                );
              }
          }
        },
      ),
    );
  }
}
