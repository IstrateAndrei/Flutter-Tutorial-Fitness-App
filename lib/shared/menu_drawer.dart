// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:globo_fitness/screens/training_screen.dart';
import 'package:globo_fitness/screens/weather_screen.dart';
import '../screens/bmi_screen.dart';
import '../screens/intro_screen.dart';



class MenuDrawer extends StatelessWidget {
  const MenuDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: buildMenuItems(context),
      ),
    );
  }
}

List<Widget> buildMenuItems(BuildContext context) {

  List<String> menuTitles = [
    'Home',
    'BMI Calculator',
    'Weather',
    'Training'
  ];

  List<Widget> menuItems = [];

  menuItems.add(DrawerHeader(
      decoration: BoxDecoration(color: Colors.blueGrey),
      child: Text('Globo Fitness',
          style: TextStyle(color: Colors.white, fontSize: 28))));

  menuTitles.forEach((element) {
    Widget screen = Container();
    menuItems.add(ListTile(
      title: Text(element,
        style: TextStyle(fontSize: 18)),
        onTap: () {

        switch(element){
          case 'Home':
            screen = IntroScreen();
            break;
          case 'BMI Calculator':
            screen = BmiScreen();
            break;
          case 'Weather':
            screen = WeatherScreen();
            break;
          case 'Training':
            screen = SessionScreen();
            break;
        }
        Navigator.of(context).pop();
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => screen)
        );

        }));
  });

  return menuItems;
}
