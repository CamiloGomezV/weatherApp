import 'package:flutter/material.dart';

import 'DB.dart';
import 'body.dart';
/*
class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
    );
  }
}
*/

// ignore: must_be_immutable
class WelcomeScreen extends StatelessWidget {
  List<Color> _background = [Colors.blue, Colors.yellow.shade600, Colors.black];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              _background[0],
              _background[1],
            ],
          ),
        ),
        child: FutureBuilder<List<Cities>>(
          future: DatabaseHelper.instance.getCities(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Cities>> snapshot) {
            if (!snapshot.hasData) {
              return Center(child: Text('Loading ...'));
            }
            return snapshot.data.isEmpty
                ? Center(
                    child: Text('No cities on favorites.'),
                  )
                : ListView(
                    children: snapshot.data.map((city) {
                      return Column(
                        children: [
                          ListTile(
                            title: Text(city.name),
                          ),
                        ],
                      );
                    }).toList(),
                  );
          },
        ),
      ),
    );
  }
}
