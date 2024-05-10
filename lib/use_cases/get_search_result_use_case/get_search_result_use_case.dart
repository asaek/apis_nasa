import '../../domain/data_sources/data_sources.dart';
import '../../domain/repositories/get_search_result_repositorie/get_search_result_repositorie.dart';

sealed class GetSearchResultUseCaseResult {
  Future<List<SearchResultEntity>> callGetSearchResult(
      {required String search});
}

class GetSearchResultUseCaseImpl implements GetSearchResultUseCaseResult {
  final GetSearchResultRepositorie getSearchResultRepositorie;

  GetSearchResultUseCaseImpl({required this.getSearchResultRepositorie});

  @override
  Future<List<SearchResultEntity>> callGetSearchResult(
          {required String search}) =>
      getSearchResultRepositorie.getSearchResult(search: search);
}
