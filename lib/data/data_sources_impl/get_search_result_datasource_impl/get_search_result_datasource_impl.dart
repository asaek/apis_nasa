import 'package:dio/dio.dart';

import '../../../domain/data_sources/data_sources.dart';
import '../../models/search_result_model/search_result_model.dart';

class GetSearchResultDataSourceImpl extends GetSearchResultDataSource {
  late final Dio dio;
  GetSearchResultDataSourceImpl() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://images-api.nasa.gov/search',
        // queryParameters: {
        //   'keyword': parameters,
        //   'media_type': 'image',
        // },
      ),
    );
  }

  @override
  Future<List<SearchResultEntity>> getSearchResult(
      {required String parameters}) async {
    try {
      final response = await dio.get('', queryParameters: {
        'keyword': parameters,
        'media_type': 'image',
      });
      if (response.statusCode == 200) {
        List<SearchResultEntity> searchResultEntity = [];
        final List<SearchResultModel> searchResultModel =
            (response.data['collection']['items'] as List)
                .map((e) => SearchResultModel.fromJson(e))
                .toList();

        for (SearchResultModel searchResultModel in searchResultModel) {
          searchResultEntity.add(
            _mapperSearchResultModelToSearchResultEntity(
              searchResultModel: searchResultModel,
            ),
          );
        }

        return searchResultEntity;
      } else {
        return [
          SearchResultEntity(
            center: null,
            title: null,
            nasaId: null,
            dateCreated: null,
            keywords: null,
            description508: null,
            urlImage: null,
            error: 'Error en la petición (Código: ${response.statusCode})',
          ),
        ];
      }
    } catch (e) {
      return [
        SearchResultEntity(
          center: null,
          title: null,
          nasaId: null,
          dateCreated: null,
          keywords: null,
          description508: null,
          urlImage: null,
          error: 'Error en la petición: $e',
        ),
      ];
    }
  }
}

SearchResultEntity _mapperSearchResultModelToSearchResultEntity(
    {required SearchResultModel searchResultModel}) {
  return SearchResultEntity(
    center: searchResultModel.data[0].center,
    title: searchResultModel.data[0].title,
    nasaId: searchResultModel.data[0].nasaId,
    dateCreated: searchResultModel.data[0].dateCreated,
    keywords: searchResultModel.data[0].keywords,
    description508: searchResultModel.data[0].description,
    urlImage: searchResultModel.links[0].href,
    error: null,
  );
}
