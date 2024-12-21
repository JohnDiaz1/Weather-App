import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CustomBottomNavigation extends StatelessWidget {

  final int currentIndex;

  const CustomBottomNavigation({
    super.key,
    required this.currentIndex
  });

  void onItemTapped( BuildContext context, int index ) {
    // context.go('');
    switch(index) {
      case 0:
        context.go('/home/0');
        break;

      case 1:
        context.go('/home/1');
        break;

      case 2:
        context.go('/home/2');
        break;

      case 3:
        context.go('/home/3');
        break;
    }
  }


  @override
  Widget build(BuildContext context) {

    return BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (value) => onItemTapped(context, value),
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              icon: Icon( Icons.wb_cloudy_outlined ),
              label: 'Diario'
          ),
          BottomNavigationBarItem(
              icon: Icon( Icons.wb_sunny_outlined ),
              label: 'Pronóstico actual'
          ),
          BottomNavigationBarItem(
              icon: Icon( Icons.map_outlined ),
              label: 'Mapa'
          ),
          BottomNavigationBarItem(
              icon: Icon( Icons.favorite_outline ),
              label: 'Favoritos'
          ),
        ]
    );
  }
}