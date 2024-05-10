import '../../../domain/data_sources/data_sources.dart';
import '../../../domain/repositories/get_search_result_repositorie/get_search_result_repositorie.dart';

class GetSearchResultRepositorieImpl implements GetSearchResultRepositorie {
  final GetSearchResultDataSource datasource;

  GetSearchResultRepositorieImpl({required this.datasource});

  @override
  Future<List<SearchResultEntity>> getSearchResult(
          {required String search}) async =>
      await datasource.getSearchResult(parameters: search);
}
