import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  static const routerName = '/SearchPage';
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const _TextField(),
        Expanded(
          child: ListView.builder(
            itemCount: 30,
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            // itemExtent: 40.0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(
                  height: 40,
                  child: Material(
                    color: Colors.grey[200],
                    child: Text('Item $index'),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    ));
  }
}

class _TextField extends StatelessWidget {
  const _TextField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Key Word',
          fillColor: Colors.grey[100],
          filled: true,
          prefixIcon: const Icon(Icons.search),
          enabledBorder: InputBorder.none,
        ),
        onChanged: (val) {},
      ),
    );
  }
}
