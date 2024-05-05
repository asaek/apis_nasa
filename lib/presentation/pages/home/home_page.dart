import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/entities.dart';
import '../../bloc/blocs.dart';
import '../pages.dart';

List<String> titulos = [
  "APOD",
  "Imagen 2",
  "Imagen 3",
  "Imagen 4",
  "Imagen 5",
];

class HomePage extends StatelessWidget {
  static const routerName = '/HomePage';
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          _Titulo(),
          _Listview(),
        ],
      ),
    );
  }
}
// context.read<ImagesMenuPrincipalCubit>().cargarImagenes();

class _Listview extends StatefulWidget {
  const _Listview();

  @override
  State<_Listview> createState() => _ListviewState();
}

class _ListviewState extends State<_Listview> {
  @override
  void initState() {
    context
        .read<ImagesMenuPrincipalCubit>()
        .loadImagesWithLoading(cantidadImages: 5);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ImagesMenuPrincipalCubit, ImagesMenuPrincipalState>(
        builder: (context, state) {
          if (state is ImagesMenuPrincipalLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ImagesMenuPrincipalLoaded) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.images.length,
              itemBuilder: (context, index) {
                return _ItemList(
                  image: state.images[index],
                  index: index,
                );
              },
            );
          }
          return const Center(
            child: Text("Error Desconocido"),
          );
        },
      ),
    );
  }
}

class _ItemList extends StatelessWidget {
  final ImageDayEntitie image;
  final int index;
  const _ItemList({
    required this.image,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return ImageFiltered(
      imageFilter: ColorFilter.mode(
        Colors.transparent.withOpacity(0.1),
        BlendMode.softLight,
      ),
      child: Container(
        height: 200,
        margin: const EdgeInsets.all(5),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: (image.url == null)
                ? const AssetImage('assets/images/no-image.jpg')
                    as ImageProvider
                : NetworkImage(image.url!),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: ListTile(
          onTap: () {
            context.push(ApiUnageDayPage.routerName);
          },
          title: Text(
            titulos[index],
            style: Theme.of(context).textTheme.titleMedium!.merge(
                  const TextStyle(
                    color: Colors.white,
                  ),
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
    );
  }
}
