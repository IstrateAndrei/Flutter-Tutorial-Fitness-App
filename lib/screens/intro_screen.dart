// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:globo_fitness/shared/bottom_nav_bar.dart';
import 'package:globo_fitness/shared/menu_drawer.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Global Fitness'),
        ),
        bottomNavigationBar: BottomNavBar(),
        drawer: MenuDrawer(),
        body: Container(decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/globo_fitness_background.jpg'),
              fit: BoxFit.cover,
            )
        ),
          child: Center(
            child:
            Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white70,
                ),
                child: Text(
                  'Commit to be fit, dare to be great \nwith Globo Fitness',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                      shadows: [
                        Shadow(
                          offset: Offset(1.0,1.0),
                          blurRadius: 2.0,
                          color: Colors.grey,
                        )
                      ]),
                )
            ),
          ),
        )
    );
  }
}
