import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/entities.dart';
import '../../bloc/blocs.dart';
import '../pages.dart';

List<String> titulos = [
  "APOD",
  "EPIC",
  "Search",
  "Imagen 4",
  "Imagen 5",
];

List<String> rutas = [
  ApiUnageDayPage.routerName,
  EpicImage.routerName,
  SearchPage.routerName,
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
    context.read<MenuPrincipalBloc>().loadMenuImagesPrincipal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<MenuPrincipalBloc, MenuPrincipalState>(
        builder: (context, state) {
          if (state is MenuPrincipalLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is MenuPrincipalLoaded) {
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
      child: InkWell(
        onTap: () => context.push(rutas[index]),
        child: Container(
          height: 200,
          margin: const EdgeInsets.all(5),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
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
            title: Text(
              titulos[index],
              style: Theme.of(context).textTheme.displaySmall!.merge(
                    const TextStyle(
                      color: Colors.white,
                    ),
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
