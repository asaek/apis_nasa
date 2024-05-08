import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/epic_image_bloc/epic_image_bloc.dart';
import '../../widgets/widgets.dart';

class EpicImage extends StatelessWidget {
  static String routerName = '/EpicImage';

  const EpicImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        BlocBuilder<EpicImageBloc, EpicImageState>(
          builder: (context, state) {
            print('ACtualizacion');
            if (state is EpicImageInicial) {
              return const Center(
                child: Text('Selecciona un dia para ver las imagenes'),
              );
            }

            if (state is EpicImageLoaded) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },
                child: SizedBox(
                  height: double.infinity,
                  key: ValueKey<int>(int.parse(state.epicImage.identifier!)),
                  child: Image.network(
                    state.epicImage.imageURLComplete!,
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
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace? stackTrace) {
                      return const Center(
                        child:
                            Text('No se pudo cargar la imagen de la Direccion'),
                      ); // En caso de error
                    },
                  ),
                ),
              );
            }

            return const Center(
              child: Text('Sin imagenes'),
            );
          },
        ),
        SafeArea(
          bottom: false,
          child: Row(
            children: [
              BackButtonPersonalizado(
                onBackPress: () {
                  print('Presionado');
                  // context.read<EpicImageBloc>().reseteoListasIndex();
                  context.read<EpicImageBloc>().stopSlider();
                  Navigator.pop(context);
                },
              ),
              const Spacer(
                flex: 2,
              ),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: const Text('Seleccionar Fecha'),
              ),
              const Spacer(
                flex: 5,
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

Future<void> _selectDate(BuildContext context) async {
  final DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(), // Fecha inicial seleccionada
    firstDate: DateTime(2000), // Fecha mínima disponible
    lastDate: DateTime(2025), // Fecha máxima disponible
  );
  if (pickedDate != null) {
    // if (pickedDate != null && pickedDate != DateTime.now()) {
    context.read<EpicImageBloc>().reseteoListasIndex();
    context.read<EpicImageBloc>().getEpicImage(dia: pickedDate);

    // Haz algo con la fecha elegida
    print("La fecha seleccionada es: $pickedDate");
  }
}

//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: AnimatedSwitcher(
//         duration: const Duration(milliseconds: 500),
//         transitionBuilder: (Widget child, Animation<double> animation) {
//           return FadeTransition(
//             opacity: animation,
//             child: child,
//           );
//         },
//         child: SizedBox(
//           height: double.infinity,
//           child: Image.network(
//             _imageUrls[_currentIndex],
//             key: ValueKey<int>(_currentIndex),
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }
