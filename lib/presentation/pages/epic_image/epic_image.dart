import 'package:flutter/material.dart';

class EpicImage extends StatefulWidget {
  static String routerName = '/EpicImage';

  const EpicImage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<EpicImage> {
  final List<String> _imageUrls = [
    'https://api.nasa.gov/EPIC/archive/natural/2019/05/30/png/epic_1b_20190530011359.png?api_key=C47bfmbseXdJm1LOe5mgUhYLh8rgPHeNoTfQ7kGW',
    'https://api.nasa.gov/EPIC/archive/natural/2019/05/30/png/epic_1b_20190530021927.png?api_key=C47bfmbseXdJm1LOe5mgUhYLh8rgPHeNoTfQ7kGW',
    'https://api.nasa.gov/EPIC/archive/natural/2019/05/30/png/epic_1b_20190530032454.png?api_key=C47bfmbseXdJm1LOe5mgUhYLh8rgPHeNoTfQ7kGW',
  ];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Cambiar imagen cada 2 segundos
    Future.delayed(Duration.zero, () {
      _startImageAnimation();
    });
  }

  void _startImageAnimation() async {
    while (true) {
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _currentIndex = (_currentIndex + 1) % _imageUrls.length;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
        child: SizedBox(
          height: double.infinity,
          child: Image.network(
            _imageUrls[_currentIndex],
            key: ValueKey<int>(_currentIndex),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
