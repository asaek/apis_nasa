import '../../data_sources/data_sources.dart';

abstract class GetSearchResultRepositorie {
  Future<List<SearchResultEntity>> getSearchResult({required String search});
}
