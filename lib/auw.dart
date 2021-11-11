import 'package:day11_weather_app/Item_card_controller.dart';
import 'package:day11_weather_app/body.dart';
import 'package:flutter/material.dart';
import 'DB.dart';
import 'backgroundcolor.dart';
import 'data_service.dart';
import 'models.dart';

class BodyD extends StatefulWidget {
  const BodyD({Key key}) : super(key: key);

  @override
  _BodyDState createState() => _BodyDState();
}

class _BodyDState extends State<BodyD> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  List<Color> _background = [
    Colors.cyan.shade800,
    Colors.cyan.shade800,
    Colors.white
  ];
  WeatherResponse _response;
  Icon fav = Icon(Icons.favorite_border);
  bool aux = true;
  int selectedId;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: SizedBox(
                width: 250,
                height: 38,
                child: TextField(
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _background[2]),
                    cursorColor: _background[1],
                    controller: _cityTextController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      hintText: 'Ciudad',
                      hintStyle: TextStyle(color: _background[2]),
                      border: OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: _background[2])),
                    )),
              ),
            ),
            ElevatedButton(
              onPressed: _search,
              child: Icon(Icons.search),
              style: ElevatedButton.styleFrom(primary: _background[1]),
            ),
          ],
        ),
      ),
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
            if (!snapshot.hasData && _response == null) {
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
                          SizedBox(
                            height: 20,
                          ),
                          ListTile(
                            title: TextButton(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.transparent),
                                onPressed: () {
                                  _research(city.name);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Body()));
                                },
                                onLongPress: () {
                                  setState(() {
                                    DatabaseHelper.instance.remove(city.id);
                                  });
                                },
                                child: Text(
                                  city.name,
                                  style: TextStyle(color: _background[2]),
                                )),
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

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(
      () {
        _response = response;
        _background = getBackgroundColor(_response.weatherInfo.icon);
      },
    );
  }

  void _research(String name) async {
    final response = await _dataService.getWeather(name);
    setState(
      () {
        _response = response;
        _background = getBackgroundColor(_response.weatherInfo.icon);
      },
    );
  }

  Icon _fav(fav) {
    setState(
      () {
        if (aux) {
          fav = Icon(Icons.favorite);
          aux = !aux;
        } else {
          fav = Icon(Icons.favorite_border);
          aux = !aux;
        }
      },
    );
    return fav;
  }
}
