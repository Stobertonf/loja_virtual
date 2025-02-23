import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
          color: Colors.yellow,
          child: const Text('Oiiie Coisa Feia!',
          style: TextStyle(color: Colors.white,)
          ),
        ),
        Container(
          color: Colors.red,
          child: const Text('Oiiie Coisa Redonda!',
            style: TextStyle(color: Colors.white,)
          ),
        ),
        Container(
          color: Colors.green,
          child: const Text('Oiiie Coisa Comilona!',
          style: TextStyle(color: Colors.white,)
          ),
        ),
      ],
    );
  }
}
