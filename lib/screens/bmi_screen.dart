// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:globo_fitness/shared/bottom_nav_bar.dart';
import 'package:globo_fitness/shared/menu_drawer.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  String result = '';
  bool isMetric = true;
  bool isImperial = false;
  double height = 0.0;
  double weight = 0.0;
  late List<bool> isSelected;
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  String heightMessage = '';
  String weightMessage = '';

  @override
  void initState() {
    isSelected = [isMetric, isImperial];
  }

  @override
  Widget build(BuildContext context) {
    heightMessage =
        'Please insert your height in ' + ((isMetric) ? 'meters' : 'inches');
    weightMessage =
        'Please insert your height in ' + ((isMetric) ? 'kilos' : 'pounds');
    return Scaffold(
      appBar: AppBar(title: Text('BMI Calculator')),
      bottomNavigationBar: BottomNavBar(),
      drawer: MenuDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: ToggleButtons(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Metric',
                        style: TextStyle(fontSize: 18, color: Colors.grey))),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text('Imperial',
                        style: TextStyle(fontSize: 18, color: Colors.grey))),
              ],
              isSelected: [isMetric, isImperial],
              onPressed: toggleMeasure,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: heightMessage),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: weightMessage),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
                child: Text(
                  'Calculate BMI',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  setState(() {
                    findBMI();
                  });
                }),
          ),
          Text(
            result,
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }

  void toggleMeasure(index) {
    setState(() {
      if (index == 0) {
        isMetric = true;
        isImperial = false;
      } else {
        isImperial = true;
        isMetric = false;
      }
    });
  }

  void findBMI(){
    double bmi = 0;
    double height = double.tryParse(heightController.text) ?? 0;
    double weight = double.tryParse(weightController.text) ?? 0;

    if(isMetric){
      bmi = weight/(height * height);
    } else {
      bmi = weight * 703/ (height * height);
    }

    setState(() {
      result = 'Your BMI is ' + bmi.toStringAsFixed(2);
    });
  }
}
