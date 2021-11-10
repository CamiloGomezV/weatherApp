import 'package:day11_weather_app/data_service.dart';
import 'package:flutter/material.dart';
import 'backgroundcolor.dart';

import 'models.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _cityTextController = TextEditingController();
  final _dataService = DataService();
  List<Color> _background = [Colors.blue, Colors.yellow.shade600, Colors.black];
  WeatherResponse _response;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          height: 700,
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
                              hintText: 'Ciudad',
                              hintStyle: TextStyle(color: Colors.black),
                              border: OutlineInputBorder(),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: _background[1])),
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
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: _background[1]),
                    padding: EdgeInsets.all(40),
                    child: Column(
                      children: [
                        Image.network(_response.iconUrl),
                        Text(_response.weatherInfo.description,
                            style: TextStyle(color: _background[2])),
                        SizedBox(
                          height: 20,
                        ),
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
                                      fontSize: 40, color: _background[2]),
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
                                      fontSize: 40, color: _background[2]),
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
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() {
      _response = response;
      _background = getBackgroundColor(_response.weatherInfo.icon);
    });
  }
}