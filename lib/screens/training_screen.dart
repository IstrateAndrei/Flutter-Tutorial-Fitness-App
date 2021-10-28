// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:globo_fitness/shared/bottom_nav_bar.dart';
import 'package:globo_fitness/shared/menu_drawer.dart';
import '../data/sp_helper.dart';
import '../data/session.dart';

class SessionScreen extends StatefulWidget {
  const SessionScreen({Key? key}) : super(key: key);

  @override
  _SessionScreenState createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {

  List<Session> sessions = [];
  final TextEditingController txtDescription = TextEditingController();
  final TextEditingController txtDuration = TextEditingController();
  final SPHelper helper = SPHelper();


  @override
  void initState() {
    helper.init().then((value) {
      updateScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Training Sessions'),
      ),
      body: ListView(
        children: getContent(),
      ),
      drawer: MenuDrawer(),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showSessionDialog(context);
        },
      ),
    );
  }

  Future<dynamic> showSessionDialog(BuildContext context) async {
    return showDialog(context: context, builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Insert Training Session'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: txtDescription,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(hintText: 'Description'),
              ),
              TextField(
                controller: txtDuration,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(hintText: 'Duration'),
              ),
            ],
          )
        ),
        actions: [
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.pop(context);
              txtDuration.text = '';
              txtDescription.text = '';
            },
          ),
          ElevatedButton(onPressed: saveSession, child: Text('Save'))
        ],
      );
    });
  }

  Future saveSession() async {
    DateTime now = DateTime.now();
    String today = '${now.day}/${now.month}/${now.year}';
    int id = helper.getCounter();
    Session newSession = Session(id, today, txtDescription.text, int.tryParse(txtDuration.text) ?? 0);
    helper.writeSession(newSession).then((value) {
     updateScreen();
     helper.setCounter();
    });
    txtDescription.text = '';
    txtDuration.text = '';
    Navigator.of(context).pop();
  }

  List<Widget> getContent(){
    List<Widget> tiles = [];
    sessions.forEach((session) {
      tiles.add(Dismissible(
        key: UniqueKey(),
        onDismissed: (_) {
         helper.removeSession(session.id).then((value) => updateScreen());
        }
        ,
        child: ListTile(
          title: Text(session.description),
          subtitle: Text('date:${session.date} - duration:${session.duration} min'),
        ),
      ));
    });
    return tiles;
  }

  void updateScreen(){
    sessions = helper.getSessions();
    setState(() {

    });
  }
}
