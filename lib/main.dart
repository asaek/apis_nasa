import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nasa_apis/config/go_router/router.dart';
import 'package:nasa_apis/presentation/bloc/blocs.dart';

import 'presentation/bloc/epic_image_bloc/epic_image_bloc.dart';
import 'presentation/bloc/service_locator.dart';

void main() async {
  await dotenv.load(
    fileName: "assets/.env",
  );
  setupLocator();
  runApp(const BlocsProviders());
}

class BlocsProviders extends StatelessWidget {
  const BlocsProviders({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ImagesMenuPrincipalCubit>(
          create: (BuildContext context) => locator<ImagesMenuPrincipalCubit>(),
        ),
        BlocProvider<TextMaxLinesCubit>(
          create: (BuildContext context) => locator<TextMaxLinesCubit>(),
        ),
        BlocProvider<MoreTextCubit>(
          create: (BuildContext context) => locator<MoreTextCubit>(),
        ),
        BlocProvider<MenuPrincipalBloc>(
          create: (BuildContext context) => locator<MenuPrincipalBloc>(),
        ),
        BlocProvider<EpicImageBloc>(
          create: (BuildContext context) => locator<EpicImageBloc>(),
        ),
        BlocProvider<SearchResultBloc>(
          create: (BuildContext context) => locator<SearchResultBloc>(),
        ),
        BlocProvider<BotonSearchKeywordCubit>(
          create: (BuildContext context) => locator<BotonSearchKeywordCubit>(),
        ),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "Api's Nasa",
      routerConfig: appRouter,
    );
  }
}
