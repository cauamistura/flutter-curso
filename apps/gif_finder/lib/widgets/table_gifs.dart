import 'package:flutter/material.dart';
import 'package:gif_finder/ui/gif_page.dart';

class TableGifs extends StatelessWidget {
  const TableGifs({
    super.key,
    required this.context,
    required this.snapshot,
  });

  final BuildContext context;
  final AsyncSnapshot snapshot;

  Widget _createItemTable(context, index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    GifPage(gitData: snapshot.data['data'][index])));
      },
      child: Image.network(
        snapshot.data['data'][index]['images']['fixed_height']['url'],
        height: 300,
        fit: BoxFit.cover,
      ),
    );
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
