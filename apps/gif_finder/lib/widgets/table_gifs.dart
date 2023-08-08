import 'package:flutter/material.dart';

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
      itemCount: 20,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: _createItemTable,
    );
  }
}
