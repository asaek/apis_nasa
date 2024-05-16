import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_apis/presentation/bloc/blocs.dart';
import 'package:nasa_apis/presentation/bloc/service_locator.dart';
import 'package:nasa_apis/presentation/pages/pages.dart';

final fakeApp = MultiBlocProvider(
  providers: [
    BlocProvider<MenuPrincipalBloc>(
      create: (BuildContext context) => locator<MenuPrincipalBloc>(),
    ),
  ],
  child: const MaterialApp(
    home: HomePage(),
  ),
);

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(
    fileName: "assets/.env",
  );

  setupLocator();

  group('Encontrar todos los componentes en pantalla', () {
    testWidgets('HomePage shows CircularProgressIndicator when loading',
        (WidgetTester tester) async {
      await tester.pumpWidget(fakeApp);
    });
  });
  // group('Ser capaz de interactuar con los widgets en pantalla', () {});
  // group('Probar los escenarios de interaccion del usuario con los widgets',
  //     () {});
}
