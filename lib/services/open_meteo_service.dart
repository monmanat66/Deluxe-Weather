import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/forecast.dart';

class OpenMeteoService {
  static const _base = 'api.open-meteo.com';

  static const List<String> _hourly = [
    'temperature_2m',
    'relative_humidity_2m',
    'precipitation',
    'wind_speed_10m',
  ];

  static const List<String> _current = [
    'temperature_2m',
    'relative_humidity_2m',
    'is_day',
    'weather_code',
    'wind_speed_10m',
  ];

  static const List<String> _daily = [
    'temperature_2m_max',
    'temperature_2m_min',
    'precipitation_sum',
    'sunrise',
    'sunset',
  ];

  Future<ForecastResponse> fetchForecast({
    required double latitude,
    required double longitude,
    String timezone = 'auto',
    int forecastDays = 7,
  }) async {
    final params = <String, String>{
      'latitude': latitude.toStringAsFixed(4),
      'longitude': longitude.toStringAsFixed(4),
      'hourly': _hourly.join(','),
      'current': _current.join(','),
      'daily': _daily.join(','),
      'forecast_days': forecastDays.toString(),
      'timezone': timezone,
    };

    final uri = Uri.https(_base, '/v1/forecast', params);
    final resp = await http.get(uri);
    if (resp.statusCode != 200) {
      throw Exception('HTTP ${resp.statusCode}: ${resp.reasonPhrase}\n${resp.body}');
    }
    final map = json.decode(resp.body) as Map<String, dynamic>;
    if (map['error'] == true) {
      throw Exception('API Error: ${map['reason']}');
    }
    return ForecastResponse.fromJson(map);
  }
}
