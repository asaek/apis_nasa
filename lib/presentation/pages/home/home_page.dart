import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/blocs.dart';

class HomePage extends StatelessWidget {
  static const routerName = '/HomePage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const _Titulo(),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: 5,
              itemBuilder: (context, index) {
                return const _ItemList();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ItemList extends StatelessWidget {
  const _ItemList();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: const EdgeInsets.all(5),
      alignment: Alignment.centerLeft,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/control_zenith.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: ListTile(
        title: Text(
          "Titulo",
          style: Theme.of(context).textTheme.titleMedium!.merge(
                const TextStyle(
                  color: Colors.white,
                ),
              ),
        ),
      ),
    );
  }
}

class _Titulo extends StatelessWidget {
  const _Titulo();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: GestureDetector(
        onTap: () {
          context.read<ImagesMenuPrincipalCubit>().cargarImagenes();
          print('Hola we :v');
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Text(
            "Nasa api's",
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
    );
  }
}
