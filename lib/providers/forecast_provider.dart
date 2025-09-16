import 'package:flutter/foundation.dart';
import '../models/forecast.dart';
import '../services/open_meteo_service.dart';

enum ForecastStatus { idle, loading, loaded, error }

class ForecastProvider extends ChangeNotifier {
  final _service = OpenMeteoService();

  ForecastStatus status = ForecastStatus.idle;
  ForecastResponse? data;
  String? error;

  double latitude = 13.7563;
  double longitude = 100.5018;

  Future<void> load({double? lat, double? lon}) async {
    if (lat != null) latitude = lat;
    if (lon != null) longitude = lon;
    status = ForecastStatus.loading;
    error = null;
    notifyListeners();

    try {
      data = await _service.fetchForecast(
        latitude: latitude,
        longitude: longitude,
        timezone: 'auto',
        forecastDays: 7,
      );
      status = ForecastStatus.loaded;
    } catch (e) {
      error = e.toString();
      status = ForecastStatus.error;
    }
    notifyListeners();
  }
}
