import 'package:get_it/get_it.dart';
import 'package:nasa_apis/presentation/bloc/blocs.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../data/data_sources_impl/get_one_image_day_datasource_impl/get_one_image_day_datasource_impl.dart';
import '../../data/repositories_impl/get_image_day_repositorie_impl/get_image_day_repositorie_impl.dart';
import '../../domain/data_sources/data_sources.dart';
import '../../domain/repositories/repositories.dart';
import '../../use_cases/use_case.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  //? DataSources
  locator.registerLazySingleton<GetOneImageDayDataSource>(
      () => GetOneImageDayDataSourceImpl());

  //? Repositories
  locator.registerLazySingleton<GetImageDayRepositorie>(() =>
      GetImageDayRepositorieImpl(
          getOneImageDayDataSource: locator<GetOneImageDayDataSource>()));

  //? UseCases
  locator.registerLazySingleton<GetImageDayUseCase>(
    () => GetImageDayUseCaseImpl(
      getOneImageDayRepository: locator<GetImageDayRepositorie>(),
    ),
  );

  //? Blocs
  locator.registerLazySingleton<MenuPrincipalBloc>(() =>
      MenuPrincipalBloc(getImageDayUseCase: locator<GetImageDayUseCase>()));
  //? Cubits
  locator.registerLazySingleton<ImagesMenuPrincipalCubit>(
    () => ImagesMenuPrincipalCubit(
      getImageDayUseCase: locator<GetImageDayUseCase>(),
    ),
  );

  locator.registerLazySingleton<TextMaxLinesCubit>(() => TextMaxLinesCubit());
  locator.registerLazySingleton<MoreTextCubit>(() => MoreTextCubit());

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
