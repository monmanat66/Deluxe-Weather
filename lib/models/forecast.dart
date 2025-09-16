class CurrentWeather {
  final DateTime time;
  final double? temperatureC;
  final num? humidity;
  final int? weatherCode;
  final double? windSpeedKmh;

  CurrentWeather({
    required this.time,
    this.temperatureC,
    this.humidity,
    this.weatherCode,
    this.windSpeedKmh,
  });
}

class HourlyWeather {
  final DateTime time;
  final double? temperatureC;
  final num? humidity;
  final double? precipitationMm;
  final double? windSpeedKmh;

  HourlyWeather({
    required this.time,
    this.temperatureC,
    this.humidity,
    this.precipitationMm,
    this.windSpeedKmh,
  });
}

class DailyWeather {
  final DateTime date;
  final double? tMax;
  final double? tMin;
  final double? precipitationSum;
  final DateTime? sunrise;
  final DateTime? sunset;

  DailyWeather({
    required this.date,
    this.tMax,
    this.tMin,
    this.precipitationSum,
    this.sunrise,
    this.sunset,
  });
}

class ForecastResponse {
  final String timezone;
  final String timezoneAbbreviation;
  final CurrentWeather? current;
  final List<HourlyWeather> hourly;
  final List<DailyWeather> daily;

  ForecastResponse({
    required this.timezone,
    required this.timezoneAbbreviation,
    required this.current,
    required this.hourly,
    required this.daily,
  });

  factory ForecastResponse.fromJson(Map<String, dynamic> json) {
    final tz = json['timezone'] as String? ?? 'GMT';
    final tza = json['timezone_abbreviation'] as String? ?? 'GMT';

    CurrentWeather? current;
    if (json['current'] != null) {
      final c = json['current'] as Map<String, dynamic>;
      current = CurrentWeather(
        time: DateTime.parse(c['time']),
        temperatureC: (c['temperature_2m'] as num?)?.toDouble(),
        humidity: c['relative_humidity_2m'] as num?,
        weatherCode: c['weather_code'] as int?,
        windSpeedKmh: (c['wind_speed_10m'] as num?)?.toDouble(),
      );
    }

    List<HourlyWeather> hourlyItems = [];
    final h = json['hourly'] as Map<String, dynamic>?;
    if (h != null) {
      final times = (h['time'] as List).cast<String>().map(DateTime.parse).toList();
      List<double?> pickD(String key) {
        final arr = h[key];
        if (arr is List) return arr.map((e) => (e as num?)?.toDouble()).toList();
        return List<double?>.filled(times.length, null);
      }
      List<num?> pickN(String key) {
        final arr = h[key];
        if (arr is List) return arr.map((e) => e as num?).toList();
        return List<num?>.filled(times.length, null);
      }
      final temp = pickD('temperature_2m');
      final rh = pickN('relative_humidity_2m');
      final pr = pickD('precipitation');
      final ws = pickD('wind_speed_10m');

      for (var i = 0; i < times.length; i++) {
        hourlyItems.add(HourlyWeather(
          time: times[i],
          temperatureC: i < temp.length ? temp[i] : null,
          humidity: i < rh.length ? rh[i] : null,
          precipitationMm: i < pr.length ? pr[i] : null,
          windSpeedKmh: i < ws.length ? ws[i] : null,
        ));
      }
    }

    List<DailyWeather> dailyItems = [];
    final d = json['daily'] as Map<String, dynamic>?;
    if (d != null) {
      final dates = (d['time'] as List).cast<String>().map(DateTime.parse).toList();
      List<double?> pickD(String key) {
        final arr = d[key];
        if (arr is List) return arr.map((e) => (e as num?)?.toDouble()).toList();
        return List<double?>.filled(dates.length, null);
      }
      List<DateTime?> pickDT(String key) {
        final arr = d[key];
        if (arr is List) return arr.map((e) => e == null ? null : DateTime.parse(e)).toList();
        return List<DateTime?>.filled(dates.length, null);
      }
      final tmax = pickD('temperature_2m_max');
      final tmin = pickD('temperature_2m_min');
      final prcp = pickD('precipitation_sum');
      final sunrise = pickDT('sunrise');
      final sunset = pickDT('sunset');

      for (var i = 0; i < dates.length; i++) {
        dailyItems.add(DailyWeather(
          date: dates[i],
          tMax: i < tmax.length ? tmax[i] : null,
          tMin: i < tmin.length ? tmin[i] : null,
          precipitationSum: i < prcp.length ? prcp[i] : null,
          sunrise: i < sunrise.length ? sunrise[i] : null,
          sunset: i < sunset.length ? sunset[i] : null,
        ));
      }
    }

    return ForecastResponse(
      timezone: tz,
      timezoneAbbreviation: tza,
      current: current,
      hourly: hourlyItems,
      daily: dailyItems,
    );
  }
}
