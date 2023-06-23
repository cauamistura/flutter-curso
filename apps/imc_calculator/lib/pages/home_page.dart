import 'package:flutter/material.dart';

const String ERROR_MESSAGE = 'Preencha os dados corretamente';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _resultText = 'Informe seus dados';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de IMC'),
        actions: [
          IconButton(
            onPressed: _resetFields,
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.person, size: 120),
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Altura (CM)',
                ),
                validator: (value) {
                  if (value == '') {
                    return 'Insira seu peso';
                  }
                },
              ),
              TextFormField(
                controller: _weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Peso (Kg)',
                ),
                validator: (value) {
                  if (value == '') {
                    return 'Insira sua altura';
                  }
                },
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                child: SizedBox(
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _calculate();
                      }
                    },
                    child: const Text('Calcular'),
                  ),
                ),
              ),
              Text(
                _resultText,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.blue, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _resetFields() {
    _heightController.text = '';
    _weightController.text = '';
    setState(() {
      _resultText = 'Informe seus dados';
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    double imc = 0;
    try {
      double height = double.parse(_heightController.text) / 100;
      double weight = double.parse(_weightController.text);
      imc = weight / (height * height);
      // ignore: empty_catches
    } catch (e) {
      return;
    }

    String result = '';
    if (imc < 18.6) {
      result = 'Abaixo do peso';
    } else if (imc >= 18.6 && imc < 24.9) {
      result = 'Peso ideal';
    } else if (imc >= 24.9 && imc < 29.9) {
      result = 'Acima do peso';
    } else if (imc >= 29.9 && imc < 34.9) {
      result = 'Obesidade grau I';
    } else if (imc >= 34.9 && imc < 39.9) {
      result = 'Obesidade grau II';
    } else if (imc >= 39.9) {
      result = 'Obesidade grau III';
    }

    setState(() {
      _resultText = '$result (${imc.toStringAsPrecision(3)})';
    });
  }
}
