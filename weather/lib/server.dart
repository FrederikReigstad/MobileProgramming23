import 'dart:convert';

import 'package:http/http.dart' as http;
import 'models.dart';

const String baseAssetURL =
    'https://dartpad-workshops-io2021.web.app/getting_started_with_slivers/assets';
const String headerImage = '${baseAssetURL}/header.jpeg';

const String baseForecastUrl =
    'https://api.open-meteo.com/v1/forecast?latitude=55.47&longitude=8.45&hourly=temperature_2m,apparent_temperature,precipitation_probability,precipitation&daily=weathercode,temperature_2m_max,temperature_2m_min&windspeed_unit=ms&timezone=auto';

class Server {
  static Map<String, dynamic>? _data;

  static refresh() async {
    final response = await http.get(Uri.parse(baseForecastUrl));
    final jsonString = response.body;
    _data = json.decode(jsonString);
  }

  static List<DailyForecast> getDailyForecast() {
    if (_data == null) return [];
    final daily = _data!['daily'] as Map<String, dynamic>;
    return DailyForecast.fromJson(daily);
  }

  static List<HourlyForecast> getHourlyForecast() {
    if (_data == null) return [];
    final hourly = _data!['hourly'] as Map<String, dynamic>;
    return HourlyForecast.fromJson(hourly);
  }
}
