import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/data_sources/data_sources.dart';
import '../../bloc/blocs.dart';
import '../../widgets/widgets.dart';

class SearchPage extends StatelessWidget {
  static const routerName = '/SearchPage';
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SafeArea(
          bottom: false,
          child: Row(
            children: [
              BackButtonPersonalizado(
                onBackPress: () => context.pop(),
              ),
              const _TextField(),
              const _ButtonSearch(),
            ],
          ),
        ),
        Expanded(
          child: BlocBuilder<SearchResultBloc, SearchResultState>(
            builder: (context, state) {
              if (state is SearchResultInitial) {
                return const Center(
                  child: Text('Ingrese una palabra clave'),
                );
              }

              if (state is SearchResultLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (state is SearchResultLoaded) {
                final List<SearchResultEntity> searchResult =
                    state.searchResult;
                return ListView.builder(
                  itemCount: searchResult.length,
                  scrollDirection: Axis.vertical,
                  padding: EdgeInsets.zero,
                  // itemExtent: 40.0,
                  itemBuilder: (context, index) {
                    final SearchResultEntity searchResultEntity =
                        searchResult[index];
                    return _TarjetaResultados(searchResultEntity);
                  },
                );
              }

              return const Center(
                child: Text('No hay resultados'),
              );
            },
          ),
        ),
      ],
    ));
  }
}

class _ButtonSearch extends StatelessWidget {
  const _ButtonSearch();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Material(
            color: Colors.grey[200],
            child: InkWell(
              child: const Icon(Icons.search),
              onTap: () {
                final String keyword =
                    context.read<BotonSearchKeywordCubit>().state.keyword;
                print(keyword);
                context
                    .read<SearchResultBloc>()
                    .getSearchResult(search: keyword);
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _TarjetaResultados extends StatelessWidget {
  final SearchResultEntity searchResultEntity;
  const _TarjetaResultados(this.searchResultEntity);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        child: Material(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(
                  searchResultEntity.urlImage!,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception,
                      StackTrace? stackTrace) {
                    return const Center(
                      child: Text('No se pudo cargar la imagen'),
                    );
                  },
                ),
                Text(searchResultEntity.title!,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium),
                Text(searchResultEntity.center!),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        "${searchResultEntity.dateCreated!.year}-${searchResultEntity.dateCreated!.month}-${searchResultEntity.dateCreated!.day}"),
                    // Text(searchResultEntity.nasaId!),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  const _TextField();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Key Word',
            fillColor: Colors.grey[100],
            filled: true,
            // prefixIcon: const Icon(Icons.search),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
          ),
          onChanged: (value) => context
              .read<BotonSearchKeywordCubit>()
              .changeKeyword(keyword: value),
          onSubmitted: (value) {
            print("El usuario ha ingresado: $value");
            context.read<SearchResultBloc>().getSearchResult(search: value);
          },
        ),
      ),
    );
  }
}
