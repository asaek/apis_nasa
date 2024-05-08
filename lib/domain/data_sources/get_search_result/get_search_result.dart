import '../data_sources.dart';

abstract class GetSearchResultDataSource {
  Future<List<SearchResultEntity>> getSearchResult(
      {required String parameters});
}
