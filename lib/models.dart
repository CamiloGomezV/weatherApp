/*
{
  "weather": [
    {
      "description": "clear sky",
      "icon": "01d"
    }
  ],
  "main": {
    "temp": 282.55,
    "feels_like":66.27,
    "humidity":49
  },
  "wind": {
    "speed":2.3,
  }
  "name": "Mountain View",
}                     
 */

class WeatherInfo {
  final String description;
  final String icon;
  final int id;

  WeatherInfo({this.description, this.icon, this.id});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    final description = json['description'];
    final icon = json['icon'];
    final id = json['id'];
    return WeatherInfo(description: description, icon: icon, id: id);
  }
}

class TemperatureInfo {
  final temperature;

  TemperatureInfo({this.temperature});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final temperature = json['temp'];
    return TemperatureInfo(temperature: temperature);
  }
}

class FeelsLike {
  final double feelsLike;

  FeelsLike({this.feelsLike});

  factory FeelsLike.fromJson(Map<String, dynamic> json) {
    final feelsLike = json['feels_like'];
    return FeelsLike(feelsLike: feelsLike);
  }
}

class Humidity {
  final int humidity;

  Humidity({this.humidity});

  factory Humidity.fromJson(Map<String, dynamic> json) {
    final humidity = json['humidity'];
    return Humidity(humidity: humidity);
  }
}

class Wspeed {
  final double windSpeed;

  Wspeed({this.windSpeed});

  factory Wspeed.fromJson(Map<String, dynamic> json) {
    final windSpeed = json['speed'];
    return Wspeed(windSpeed: windSpeed);
  }
}

class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;
  final FeelsLike feelsInfo;
  final Humidity humidityInfo;
  final Wspeed windSpeedInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/wn/${weatherInfo.icon}@2x.png';
  }

  WeatherResponse(
      {this.cityName,
      this.tempInfo,
      this.weatherInfo,
      this.feelsInfo,
      this.humidityInfo,
      this.windSpeedInfo});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);
    final feelsInfo = FeelsLike.fromJson(tempInfoJson);
    final humidityInfo = Humidity.fromJson(tempInfoJson);

    final windInfoJson = json['wind'];
    final windSpeedInfo = Wspeed.fromJson(windInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    return WeatherResponse(
        cityName: cityName,
        tempInfo: tempInfo,
        weatherInfo: weatherInfo,
        feelsInfo: feelsInfo,
        humidityInfo: humidityInfo,
        windSpeedInfo: windSpeedInfo);
  }
}
