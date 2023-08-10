import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

const URL_APPBAR =
    'https://developers.giphy.com/branch/master/static/header-logo-0fec0225d189bc0eae27dac3e3770582.gif';

class GifPage extends StatelessWidget {
  const GifPage({
    super.key,
    required this.gitData,
  });

  final Map gitData;

  void _onclickShare() {
    Share.share(gitData['images']['fixed_height']['url']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.network(URL_APPBAR),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: _onclickShare,
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Center(
        child: Image.network(gitData['images']['fixed_height']['url']),
      ),
    );
  }
}
