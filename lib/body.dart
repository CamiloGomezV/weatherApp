import 'package:flutter/material.dart';
import 'package:day11_weather_app/data_service.dart';
import 'backgroundcolor.dart';
import 'models.dart';
import 'DB.dart';

class Body extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final cityTextController = TextEditingController();
  final dataService = DataService();
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: _background[2],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 50),
                    child: SizedBox(
                      width: 250,
                      height: 38,
                      child: TextField(
                          textAlign: TextAlign.center,
                          style: TextStyle(color: _background[2]),
                          cursorColor: _background[1],
                          controller: cityTextController,
                          decoration: InputDecoration(
                            hintText: 'Ciudad',
                            hintStyle: TextStyle(color: _background[2]),
                            border: OutlineInputBorder(),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: _background[1])),
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
              if (_response != null)
                Container(
                  width: size.width - 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: _background[1]),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () async {
                              selectedId != null
                                  ? await DatabaseHelper.instance.update(
                                      Cities(
                                          id: selectedId,
                                          name: cityTextController.text),
                                    )
                                  : await DatabaseHelper.instance.add(
                                      Cities(name: cityTextController.text),
                                    );
                              fav = _fav(fav);
                            },
                            icon: fav,
                          ),
                        ],
                      ),
                      Image.network(_response.iconUrl),
                      Text(_response.weatherInfo.description,
                          style: TextStyle(color: _background[2])),
                      SizedBox(height: 50),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Temperatura: ",
                                style: TextStyle(color: _background[2]),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${_response.tempInfo.temperature}°',
                                style: TextStyle(
                                    fontSize: 30, color: _background[2]),
                              ),
                              SizedBox(height: 50),
                              Text(
                                "Humedad: ",
                                style: TextStyle(color: _background[2]),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${_response.humidityInfo.humidity}%',
                                style: TextStyle(
                                    fontSize: 30, color: _background[2]),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Sensación térmica: ",
                                style: TextStyle(color: _background[2]),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${_response.feelsInfo.feelsLike}°',
                                style: TextStyle(
                                    fontSize: 30, color: _background[2]),
                              ),
                              SizedBox(height: 50),
                              Text(
                                "Velocidad del viento: ",
                                style: TextStyle(color: _background[2]),
                              ),
                              SizedBox(height: 10),
                              Text(
                                '${_response.windSpeedInfo.windSpeed} km/h',
                                style: TextStyle(
                                    fontSize: 30, color: _background[2]),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _search() async {
    final __response = await dataService.getWeather(cityTextController.text);
    setState(
      () {
        _response = __response;
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
