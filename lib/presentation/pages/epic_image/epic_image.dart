import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/epic_image_bloc/epic_image_bloc.dart';

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
                duration: const Duration(milliseconds: 500),
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
                  ),
                ),
              );
            }

            return const Center(
              child: Text('Sin imagenes'),
            );
          },
        ),
        Align(
          alignment: Alignment.topCenter,
          child: SafeArea(
            bottom: false,
            child: ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text('Seleccionar Fecha'),
            ),
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
