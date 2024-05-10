part of 'search_result_bloc.dart';

sealed class SearchResultState extends Equatable {
  const SearchResultState();

  @override
  List<Object> get props => [];
}

class SearchResultInitial extends SearchResultState {}

class SearchResultLoading extends SearchResultState {}

class SearchResultLoaded extends SearchResultState {
  final List<SearchResultEntity> searchResult;
  const SearchResultLoaded({required this.searchResult});

  @override
  List<Object> get props => [searchResult];
}
