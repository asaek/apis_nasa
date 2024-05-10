part of 'boton_search_keyword_cubit.dart';

class BotonSearchKeywordState extends Equatable {
  final String keyword;
  const BotonSearchKeywordState({required this.keyword});

  BotonSearchKeywordState copyWith({
    required String keyword,
  }) {
    return BotonSearchKeywordState(
      keyword: keyword,
    );
  }

  @override
  List<Object> get props => [keyword];
}
