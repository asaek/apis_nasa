import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nasa_apis/presentation/bloc/blocs.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../data/data_sources_impl/get_epic_image_datasource_impl/get_epic_image_datasource_impl.dart';
import '../../data/data_sources_impl/get_one_image_day_datasource_impl/get_one_image_day_datasource_impl.dart';
import '../../data/data_sources_impl/get_search_result_datasource_impl/get_search_result_datasource_impl.dart';
import '../../data/repositories_impl/get_epic_images_day_repositorie_impl/get_epic_images_day_repositorie_impl.dart';
import '../../data/repositories_impl/get_image_day_repositorie_impl/get_image_day_repositorie_impl.dart';
import '../../data/repositories_impl/repositories_impl.dart';
import '../../domain/data_sources/data_sources.dart';
import '../../domain/repositories/get_search_result_repositorie/get_search_result_repositorie.dart';
import '../../domain/repositories/repositories.dart';
import '../../use_cases/get_search_result_use_case/get_search_result_use_case.dart';
import '../../use_cases/use_case.dart';
import 'epic_image_bloc/epic_image_bloc.dart';

GetIt locator = GetIt.instance;
Dio dio = Dio();
void setupLocator() {
  //? Dio
  // Register Dio
  // Register Dio if not already registered
  if (!locator.isRegistered<Dio>()) {
    locator.registerLazySingleton<Dio>(() => Dio());
  }

  //? DataSources
  locator.registerLazySingleton<GetOneImageDayDataSource>(
      () => GetOneImageDayDataSourceImpl());

  locator.registerLazySingleton<GetEpicImageDataSource>(
      () => GetEpicImageDataSourceImpl(dio: locator<Dio>()));

  locator.registerLazySingleton<GetSearchResultDataSource>(
      () => GetSearchResultDataSourceImpl());

  //? Repositories
  locator.registerLazySingleton<GetImageDayRepositorie>(() =>
      GetImageDayRepositorieImpl(
          getOneImageDayDataSource: locator<GetOneImageDayDataSource>()));

  locator.registerLazySingleton<GetEpicImagesDayRepositorie>(() =>
      GetEpicImagesDayRepositorieImpl(
          datasource: locator<GetEpicImageDataSource>()));

  locator.registerLazySingleton<GetSearchResultRepositorie>(() =>
      GetSearchResultRepositorieImpl(
          datasource: locator<GetSearchResultDataSource>()));

  //? UseCases
  locator.registerLazySingleton<GetImageDayUseCase>(
    () => GetImageDayUseCaseImpl(
      getOneImageDayRepository: locator<GetImageDayRepositorie>(),
    ),
  );

  locator.registerLazySingleton<GetEpicImageUseCase>(
    () => GetEpicImageUseCaseImpl(
      getEpicImageRepository: locator<GetEpicImagesDayRepositorie>(),
    ),
  );

  locator.registerLazySingleton<GetSearchResultUseCaseResult>(
    () => GetSearchResultUseCaseImpl(
      getSearchResultRepositorie: locator<GetSearchResultRepositorie>(),
    ),
  );

  //? Blocs
  locator.registerLazySingleton<MenuPrincipalBloc>(() =>
      MenuPrincipalBloc(getImageDayUseCase: locator<GetImageDayUseCase>()));

  locator.registerLazySingleton<EpicImageBloc>(
      () => EpicImageBloc(getEpicImageUseCase: locator<GetEpicImageUseCase>()));

  locator.registerLazySingleton<SearchResultBloc>(() => SearchResultBloc(
      getSearchResultUseCaseResult: locator<GetSearchResultUseCaseResult>()));

  //? Cubits
  locator.registerLazySingleton<ImagesMenuPrincipalCubit>(
    () => ImagesMenuPrincipalCubit(
      getImageDayUseCase: locator<GetImageDayUseCase>(),
    ),
  );

  locator.registerLazySingleton<TextMaxLinesCubit>(() => TextMaxLinesCubit());
  locator.registerLazySingleton<MoreTextCubit>(() => MoreTextCubit());

  locator.registerLazySingleton<BotonSearchKeywordCubit>(
      () => BotonSearchKeywordCubit());

  //? Services
  //? Controller
  locator.registerFactoryParam<YoutubePlayerController, String, void>(
    (videoId, _) => YoutubePlayerController(
      initialVideoId: videoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: true,
      ),
    ),
  );
}
