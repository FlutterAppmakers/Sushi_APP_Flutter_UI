import 'package:flutter/material.dart';

class SushiBackground extends StatelessWidget {
  const SushiBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Image.asset('assets/futomaki/futomaki01.jpg',
          fit: BoxFit.cover,
          colorBlendMode: BlendMode.darken,
          color: Colors.black.withOpacity(0.2),
        )
    );
  }
}

