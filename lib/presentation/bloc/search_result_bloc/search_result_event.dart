part of 'search_result_bloc.dart';

sealed class SearchResultEvent extends Equatable {
  const SearchResultEvent();

  @override
  List<Object> get props => [];
}

class GetSearchResult extends SearchResultEvent {
  final String search;
  const GetSearchResult({required this.search});

  @override
  List<Object> get props => [search];
}
