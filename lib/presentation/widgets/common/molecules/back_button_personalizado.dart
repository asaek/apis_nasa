import 'package:flutter/material.dart';

class BackButtonPersonalizado extends StatelessWidget {
  final VoidCallback onBackPress;
  const BackButtonPersonalizado({
    super.key,
    required this.onBackPress,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Material(
        color: Colors.grey.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
        child: const Padding(
          padding: EdgeInsets.all(4.0),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
      onPressed: () => onBackPress(),
    );
  }
}
