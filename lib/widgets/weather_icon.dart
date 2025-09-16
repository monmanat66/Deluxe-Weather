import 'package:flutter/material.dart';

IconData iconFromWeatherCode(int? code, {bool isDay = true}) {
  if (code == null) return Icons.device_thermostat;
  switch (code) {
    case 0: return isDay ? Icons.wb_sunny : Icons.nights_stay;
    case 1:
    case 2:
    case 3: return Icons.cloud_queue;
    case 45:
    case 48: return Icons.foggy;
    case 51:
    case 53:
    case 55: return Icons.grain;
    case 61:
    case 63:
    case 65: return Icons.umbrella;
    case 66:
    case 67: return Icons.ac_unit;
    case 71:
    case 73:
    case 75: return Icons.snowing;
    case 77: return Icons.ac_unit;
    case 80:
    case 81:
    case 82: return Icons.beach_access;
    case 85:
    case 86: return Icons.downhill_skiing;
    case 95:
    case 96:
    case 97: return Icons.thunderstorm;
    default: return Icons.cloud;
  }
}
