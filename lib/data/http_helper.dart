import 'package:globo_fitness/data/weather.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpHelper {

  //467d6a8b990bc191b64e63351f2b2c7b
  //  api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

  final String authority = 'api.openweathermap.org';
  final String path = '/data/2.5/weather';
  final String apiKey = '467d6a8b990bc191b64e63351f2b2c7b';

  //use Future for async methods

  Future<Weather> getWeather(String location) async {
    Map<String, dynamic> parameters = {'q': location, 'appid': apiKey};
    Uri uri = Uri.https(authority, path, parameters);
    http.Response result = await http.get(uri);

    Map<String, dynamic> data = json.decode(result.body);
    Weather weather = Weather.fromJson(data);
    return weather;
  }
}
