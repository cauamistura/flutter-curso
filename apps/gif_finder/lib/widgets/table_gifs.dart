import 'package:flutter/material.dart';
import 'package:gif_finder/ui/gif_page.dart';
import 'package:share_plus/share_plus.dart';
import 'package:transparent_image/transparent_image.dart';

class TableGifs extends StatelessWidget {
  const TableGifs({
    super.key,
    required this.context,
    required this.snapshot,
  });

  final BuildContext context;
  final AsyncSnapshot snapshot;

  Widget _createItemTable(context, index) {
    if (index < snapshot.data['data'].length) {
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      GifPage(gitData: snapshot.data['data'][index])));
        },
        onLongPress: () => Share.share(
            snapshot.data['data'][index]['images']['fixed_height']['url']),
        child: FadeInImage.memoryNetwork(
            height: 300,
            fit: BoxFit.cover,
            placeholder: kTransparentImage,
            image: snapshot.data['data'][index]['images']['fixed_height']
                ['url']),
      );
    } else {
      return Image.network(
        'https://static.thenounproject.com/png/504708-200.png',
        height: 300,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: 14,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: _createItemTable,
    );
  }
}
