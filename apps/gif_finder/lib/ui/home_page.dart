import 'package:flutter/material.dart';
import 'package:gif_finder/api.dart';
import 'package:gif_finder/widgets/table_gifs.dart';

const URL_APPBAR =
    'https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _search;
  int _offset = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.network(URL_APPBAR),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          const Padding(
            padding:
                EdgeInsetsDirectional.symmetric(horizontal: 6, vertical: 10),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Pesquise Aqui!',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
            future: Api.getGifs(_offset, _search),
            builder: (context, snapshot) {
              return const TableGifs();
            },
          ))
        ],
      ),
    );
  }
}
