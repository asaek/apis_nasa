import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/data_sources/data_sources.dart';
import '../../../use_cases/get_search_result_use_case/get_search_result_use_case.dart';

part 'search_result_event.dart';
part 'search_result_state.dart';

typedef SendSearchResult = void Function({required String keyword});

class SearchResultBloc extends Bloc<SearchResultEvent, SearchResultState> {
  final SendSearchResult? sendSearchResult;
  final GetSearchResultUseCaseResult getSearchResultUseCaseResult;
  SearchResultBloc(
      {this.sendSearchResult, required this.getSearchResultUseCaseResult})
      : super(SearchResultInitial()) {
    // on<SearchResultEvent>((event, emit) {});
    on<GetSearchResult>(_getSearchResult);
  }
  void _getSearchResult(
      GetSearchResult event, Emitter<SearchResultState> emit) async {
    final List<SearchResultEntity> searchResult =
        await getSearchResultUseCaseResult.callGetSearchResult(
            search: event.search);
    print(searchResult);
    emit(SearchResultLoaded(searchResult: searchResult));
  }

  //*  llamados eventos
  void getSearchResult({required String search}) {
    add(GetSearchResult(search: search));
  }

  //* Comunicacion bloc envio de keyword
  void sendKeyword({required String keyword}) {
    sendSearchResult?.call(keyword: keyword);
  }
}
