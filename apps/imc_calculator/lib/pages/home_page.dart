import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.person, size: 120),
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Altura (CM)'),
            ),
            const TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Peso (Kg)'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 3),
              child: SizedBox(
                height: 40,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Calcular'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
