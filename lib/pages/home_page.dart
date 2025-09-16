import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../providers/forecast_provider.dart';
import '../widgets/quick_stat.dart';
import '../widgets/weather_icon.dart';
import '../widgets/temp_chart.dart';
import '../models/forecast.dart';
import '../data/th_provinces.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _latCtl;
  late final TextEditingController _lonCtl;

  Province? _selectedProvince;

  @override
  void initState() {
    super.initState();
    final p = context.read<ForecastProvider>();
    _latCtl = TextEditingController(text: p.latitude.toStringAsFixed(4));
    _lonCtl = TextEditingController(text: p.longitude.toStringAsFixed(4));
  }

  @override
  void dispose() {
    _latCtl.dispose();
    _lonCtl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final p = context.watch<ForecastProvider>();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFB3A6FF), Color(0xFFE7E7FF), Color(0xFFF5F6FB)],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text('Deluxe Weather'),
          actions: [
            IconButton(
              tooltip: 'รีเฟรช',
              onPressed: p.status == ForecastStatus.loading
                  ? null
                  : () => p.load(),
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildProvinceDropdown(context),
                const SizedBox(height: 12),
                _buildLocationRow(context, p),
                const SizedBox(height: 16),
                _buildStatus(context, p),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ---------- Province Dropdown ----------
  Widget _buildProvinceDropdown(BuildContext context) {
    return DropdownButtonFormField<Province>(
      value: _selectedProvince,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.location_city),
        labelText: 'เลือกจังหวัด',
        border: OutlineInputBorder(),
      ),
      isExpanded: true,
      items: provincesTH
          .map(
            (p) => DropdownMenuItem<Province>(
              value: p,
              child: Text('${p.nameTh} (${p.nameEn})'),
            ),
          )
          .toList(),
      onChanged: (Province? p) {
        if (p == null) return;
        setState(() => _selectedProvince = p);
        _latCtl.text = p.lat.toStringAsFixed(4);
        _lonCtl.text = p.lon.toStringAsFixed(4);
        context.read<ForecastProvider>().load(lat: p.lat, lon: p.lon);
      },
    );
  }

  // ---------- Manual Lat/Lon + Load ----------
  Widget _buildLocationRow(BuildContext context, ForecastProvider p) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _latCtl,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            decoration: const InputDecoration(
              labelText: 'Latitude',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.place_outlined),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextField(
            controller: _lonCtl,
            keyboardType: const TextInputType.numberWithOptions(
              signed: true,
              decimal: true,
            ),
            decoration: const InputDecoration(
              labelText: 'Longitude',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.place_outlined),
            ),
          ),
        ),
        const SizedBox(width: 12),
        FilledButton.icon(
          onPressed: () {
            final lat = double.tryParse(_latCtl.text);
            final lon = double.tryParse(_lonCtl.text);
            if (lat == null || lon == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('กรุณาใส่ตัวเลขให้ถูกต้อง')),
              );
              return;
            }
            context.read<ForecastProvider>().load(lat: lat, lon: lon);
          },
          icon: const Icon(Icons.cloud_download),
          label: const Text('โหลด'),
        ),
      ],
    );
  }

  // ---------- State to UI ----------
  Widget _buildStatus(BuildContext context, ForecastProvider p) {
    switch (p.status) {
      case ForecastStatus.loading:
        return const Expanded(
          child: Center(child: CircularProgressIndicator()),
        );
      case ForecastStatus.error:
        return Expanded(
          child: Center(
            child: Text(
              p.error ?? 'เกิดข้อผิดพลาด',
              style: const TextStyle(color: Colors.red),
            ),
          ),
        );
      case ForecastStatus.loaded:
        return _buildDashboard(context, p);
      default:
        return const SizedBox.shrink();
    }
  }

  // ---------- Glass container ----------
  Widget _glass({required Widget child}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withOpacity(0.5)),
          ),
          child: child,
        ),
      ),
    );
  }

  // ---------- Dashboard ----------
  Widget _buildDashboard(BuildContext context, ForecastProvider p) {
    final data = p.data;
    if (data == null) return const Expanded(child: SizedBox());
    final current = data.current;
    final hourly = data.hourly;
    final daily = data.daily;
    final dfDate = DateFormat('EEE d MMM');
    final dfTime = DateFormat('HH:mm');

    return Expanded(
      child: ListView(
        children: [
          _glass(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 34,
                    backgroundColor: Colors.white,
                    child: Icon(
                      iconFromWeatherCode(current?.weatherCode, isDay: true),
                      size: 40,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Timezone: ${data.timezone} (${data.timezoneAbbreviation})',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          current?.temperatureC != null
                              ? '${current!.temperatureC!.toStringAsFixed(1)}°C'
                              : '--°C',
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          current?.time != null
                              ? '${dfDate.format(current!.time)} • ${dfTime.format(current.time)}'
                              : '',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),

          Row(
            children: [
              Expanded(
                child: QuickStat(
                  icon: Icons.water_drop,
                  label: 'ความชื้น',
                  value: current?.humidity != null
                      ? '${current!.humidity} %'
                      : '-',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: QuickStat(
                  icon: Icons.air,
                  label: 'ลม',
                  value: current?.windSpeedKmh != null
                      ? '${current!.windSpeedKmh!.toStringAsFixed(0)} km/h'
                      : '-',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: QuickStat(
                  icon: Icons.grain,
                  label: 'ฝน (วันนี้)',
                  value: _todayPrecip(daily),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _glass(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'อุณหภูมิ 24 ชั่วโมง',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 12),
                  TempChart(hourly: hourly),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),

          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: daily.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (_, i) {
                final d = daily[i];
                return SizedBox(
                  width: 140,
                  child: _glass(
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateFormat('EEE d MMM').format(d.date),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Row(
                            children: [
                              const Icon(Icons.thermostat, size: 18),
                              const SizedBox(width: 6),
                              Text(
                                '${d.tMin?.toStringAsFixed(0) ?? '-'}° / ${d.tMax?.toStringAsFixed(0) ?? '-'}°',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(Icons.umbrella, size: 18),
                              const SizedBox(width: 6),
                              Text(
                                '${d.precipitationSum?.toStringAsFixed(1) ?? '-'} mm',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          _glass(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
                    child: Text(
                      'รายชั่วโมง (48 ชม.)',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  const Divider(height: 1),
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: hourly.length.clamp(0, 48),
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, i) {
                      final h = hourly[i];
                      return ListTile(
                        leading: const Icon(Icons.schedule),
                        title: Text(
                          DateFormat('EEE d MMM HH:mm').format(h.time),
                        ),
                        subtitle: Text(_subtitle(h)),
                        trailing: Text(
                          h.temperatureC != null
                              ? '${h.temperatureC!.toStringAsFixed(1)}°C'
                              : '-',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _subtitle(HourlyWeather h) {
    final parts = <String>[];
    if (h.humidity != null) parts.add('RH ${h.humidity}%');
    if (h.precipitationMm != null) {
      parts.add('Rain ${h.precipitationMm!.toStringAsFixed(1)} mm');
    }
    if (h.windSpeedKmh != null) {
      parts.add('Wind ${h.windSpeedKmh!.toStringAsFixed(0)} km/h');
    }
    return parts.join(' • ');
  }

  String _todayPrecip(List<DailyWeather> daily) {
    if (daily.isEmpty) return '-';
    final today = DateTime.now();
    final d = daily.firstWhere(
      (e) =>
          e.date.year == today.year &&
          e.date.month == today.month &&
          e.date.day == today.day,
      orElse: () => daily.first,
    );
    return d.precipitationSum != null
        ? '${d.precipitationSum!.toStringAsFixed(1)} mm'
        : '-';
  }
}
