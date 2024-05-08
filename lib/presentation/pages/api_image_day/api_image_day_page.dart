import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_apis/presentation/bloc/service_locator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../domain/entities/entities.dart';
import '../../bloc/blocs.dart';
import '../../widgets/widgets.dart';

class ApiUnageDayPage extends StatefulWidget {
  static const routerName = '/ApiUnageDayPage';

  const ApiUnageDayPage({super.key});

  @override
  State<ApiUnageDayPage> createState() => _ApiUnageDayPageState();
}

class _ApiUnageDayPageState extends State<ApiUnageDayPage> {
  final PageController _pageController = PageController();

  @override
  void initState() {
    context
        .read<ImagesMenuPrincipalCubit>()
        .loadImagesWithLoading(cantidadImages: 6);

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ImagesMenuPrincipalCubit, ImagesMenuPrincipalState>(
        builder: (context, state) {
          if (state is ImagesMenuPrincipalLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is ImagesMenuPrincipalLoaded) {
            final List<ImageDayEntitie> images = state.images;

            return PageView.builder(
              itemCount: images.length,
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              controller: _pageController,
              itemBuilder: (context, index) {
                if (index == images.length - 2) {
                  context
                      .read<ImagesMenuPrincipalCubit>()
                      .loadImagesWithoutLoading(cantidadImages: 2);
                }
                return Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    SizedBox(
                      height: double.infinity,
                      child: (images[index].url == null)
                          ? const _ErroImageNull()
                          : (images[index].mediaType == 'video')
                              ? _YoutubeVideoPlayer(images[index].url!)
                              : _ImageNetwork(
                                  images: images,
                                  index: index,
                                ),
                    ),
                    SafeArea(
                      bottom: true,
                      top: false,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: BlocBuilder<TextMaxLinesCubit, bool>(
                          builder: (context, state) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    SafeArea(
                                      bottom: false,
                                      child: BackButtonPersonalizado(
                                        onBackPress: () =>
                                            Navigator.pop(context),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                _Titulo(images[index].title!),
                                const SizedBox(height: 15),
                                _Parrafo(images[index].explanation!),
                                if (state)
                                  TextButton(
                                    onPressed: () {
                                      context.read<MoreTextCubit>().moreText();
                                    },
                                    child: Text(
                                      'Ver más',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .merge(
                                            const TextStyle(
                                              color: Colors.lightBlue,
                                            ),
                                          ),
                                    ),
                                  ),
                                const SizedBox(height: 15),
                                _Fecha(images[index].date!),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
          return const Center(
            child: Text("Error Desconocido"),
          );
        },
      ),
    );
  }
}

class _YoutubeVideoPlayer extends StatelessWidget {
  final String videoId;
  const _YoutubeVideoPlayer(this.videoId);

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller:
          locator<YoutubePlayerController>(param1: extractYouTubeId(videoId)),
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.red,
      progressColors: const ProgressBarColors(
        playedColor: Colors.red,
        handleColor: Colors.red,
      ),
    );
  }
}

class _ImageNetwork extends StatelessWidget {
  const _ImageNetwork({
    required this.images,
    required this.index,
  });

  final List<ImageDayEntitie> images;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      images[index].url!,
      fit: BoxFit.cover,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) {
          return child; // Imagen cargada
        }
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
      errorBuilder:
          (BuildContext context, Object exception, StackTrace? stackTrace) {
        return const Center(
          child: Text('No se pudo cargar la imagen de la Direccion'),
        ); // En caso de error
      },
    );
  }
}

class _ErroImageNull extends StatelessWidget {
  const _ErroImageNull({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/git_image_null.gif',
            fit: BoxFit.cover,
          ),
          Text(
            'No se pudo cargar la imagen',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
        ],
      ),
    );
  }
}

class _Fecha extends StatelessWidget {
  final DateTime fecha;
  const _Fecha(this.fecha);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Material(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 3,
          ),
          child: Text(
            '${fecha.year}-${fecha.month}-${fecha.day}',
            style: Theme.of(context).textTheme.headlineLarge!.merge(
                  const TextStyle(
                    color: Colors.white,
                  ),
                ),
          ),
        ),
      ),
    );
  }
}

class _Parrafo extends StatelessWidget {
  final String parrafo;
  const _Parrafo(this.parrafo);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoreTextCubit, bool>(
      builder: (context, state) {
        return TextOverflowDetector(
          text: parrafo,
          maxLines: (state) ? 23 : 4,
          style: Theme.of(context).textTheme.bodyLarge!.merge(
                const TextStyle(
                  color: Colors.white,
                ),
              ),
        );
      },
    );
  }
}

class _Titulo extends StatelessWidget {
  final String titulo;
  const _Titulo(this.titulo);

  @override
  Widget build(BuildContext context) {
    return Text(
      titulo,
      style: Theme.of(context).textTheme.displaySmall!.merge(
            const TextStyle(
              color: Colors.white,
            ),
          ),
    );
  }
}

//* Este widget se encarga de detectar si el texto excede el número de líneas permitidas
class TextOverflowDetector extends StatelessWidget {
  final String text;
  final TextStyle style;
  final int maxLines;

  const TextOverflowDetector({
    Key? key,
    required this.text,
    required this.style,
    required this.maxLines,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final span = TextSpan(text: text, style: style);
        final tp = TextPainter(
          text: span,
          maxLines: maxLines,
          textDirection: TextDirection.ltr,
          // textAlign: TextAlign.justify,
        );

        tp.layout(maxWidth: constraints.maxWidth);

        if (tp.didExceedMaxLines) {
          context.read<TextMaxLinesCubit>().excedeMax();
          print('El texto excede las líneas permitidas');
        } else {
          // El texto no excede el número máximo de líneas
          print('El texto no excede las líneas permitidas');
        }

        return Text(
          text,
          maxLines: maxLines,
          style: style,
          textAlign: TextAlign.justify,
        );
      },
    );
  }
}

//* sacar el id de una url de youtube
String extractYouTubeId(String url) {
  var regExp = RegExp(
    r"^(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/(?:[^\/\n\s]+\/\S+\/|(?:v|e(?:mbed)?)\/|\S*?[?&]v=)|youtu\.be\/)([a-zA-Z0-9_-]{11})",
    caseSensitive: false,
    multiLine: false,
  );

  var match = regExp.firstMatch(url);
  return match?.group(1) ??
      ''; // Retorna el ID del video o una cadena vacía si no se encuentra.
}
