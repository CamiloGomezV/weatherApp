import 'package:flutter/material.dart';

// [ Oscuro, Claro]

List<Color> getBackgroundColor(var condition) {
  if (condition == '01d')
    return [Colors.blue.shade400, Colors.deepOrange.shade300, Colors.black];
  else if (condition == '02d')
    return [Colors.blue.shade600, Colors.deepOrange, Colors.black];
  else if (condition == '03d')
    return [Colors.blue.shade400, Colors.blueGrey, Colors.black];
  else if (condition == '04d')
    return [Colors.blue.shade400, Colors.blueGrey.shade800, Colors.white];
  else if (condition == '09d')
    return [Colors.blueGrey.shade400, Colors.blueGrey.shade900, Colors.white];
  else if (condition == '10d')
    return [Colors.blueGrey.shade700, Colors.deepOrange.shade400, Colors.white];
  else if (condition == '11d')
    return [Colors.blueGrey.shade900, Colors.grey.shade600, Colors.white];
  else if (condition == '13d')
    return [Colors.grey.shade700, Colors.grey.shade300, Colors.white];
  else if (condition == '50d')
    return [Colors.grey.shade700, Colors.grey.shade300, Colors.white];
  else if (condition == '01n')
    return [Colors.blueGrey.shade700, Colors.indigo.shade900, Colors.white];
  else if (condition == '02n')
    return [Colors.grey.shade800, Colors.indigo.shade700, Colors.white];
  else if (condition == '03n')
    return [Colors.grey.shade700, Colors.blueGrey.shade900, Colors.white];
  else if (condition == '04n')
    return [Colors.grey.shade700, Colors.blueGrey.shade900, Colors.white];
  else if (condition == '09n')
    return [Colors.grey.shade700, Colors.blueGrey.shade900, Colors.white];
  else if (condition == '10n')
    return [Colors.grey.shade700, Colors.blueGrey.shade900, Colors.white];
  else if (condition == '11n')
    return [Colors.blueGrey.shade900, Colors.grey.shade600, Colors.white];
  else if (condition == '13n')
    return [Colors.grey.shade700, Colors.grey.shade300, Colors.white];
  else if (condition == '50n')
    return [Colors.grey.shade700, Colors.grey.shade300, Colors.white];
  else
    return [Colors.blue, Colors.yellow.shade600, Colors.black];
}
