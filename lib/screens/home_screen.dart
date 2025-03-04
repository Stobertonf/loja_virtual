import 'package:flutter/material.dart';
import 'package:loja_virtual/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Scaffold(
          appBar: AppBar(
            title: const Text("Produtos"),
            centerTitle: true,
          ),
          drawer:const CustomDrawer(),
          body: ProducsTab,
        ),
        Container(
          color: Colors.yellow,
           child: const Text('Texto 1',
          style: TextStyle(color: Colors.white,)
          ),
        ),
        Container(
          color: Colors.red,
            child: const Text('Texto 2',
            style: TextStyle(color: Colors.white,)
          ),
        ),
        Container(
          color: Colors.green,
          child: const Text('Texto 3',
          style: TextStyle(color: Colors.white,)
          ),
        ),
      ],
    );
  }
}
