import 'package:flutter/material.dart';
import 'package:gif_finder/api.dart';
import 'package:gif_finder/widgets/loading_animation.dart';
import 'package:gif_finder/widgets/table_gifs.dart';

const URL_APPBAR =
    'https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController controllerSearch = TextEditingController();

  String? _search;
  int _offset = 0;

  @override
  void initState() {
    super.initState();
  }

  void _onSubmittedSearch(String value) {
    setState(() {
      if (value != null && value.isNotEmpty) {
        _search = value;
      } else if (value.isEmpty) {
        _search = null;
      }
    });
  }

  void _clickButtonClear() {
    controllerSearch.text = '';
    setState(() {
      _search = null;
    });
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
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: 6,
              vertical: 10,
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controllerSearch,
                    decoration: const InputDecoration(
                      labelText: 'Pesquise Aqui!',
                      hintText: 'Pesquise Aqui!',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onSubmitted: _onSubmittedSearch,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ElevatedButton(
                    onPressed: _clickButtonClear,
                    child: const Icon(Icons.cleaning_services),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: Api.getGifs(_offset, _search),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                  case ConnectionState.none:
                    return const LoadingPage();
                  default:
                    if (snapshot.hasError) {
                      return Container();
                    } else {
                      return TableGifs(
                        context: context,
                        snapshot: snapshot,
                      );
                    }
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
