import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:toonflix/models/webtoon_detail_model.dart';
import 'package:toonflix/models/webtoon_episode_model.dart';
import 'package:toonflix/models/webtoon_model.dart';

class ApiService {
  static const String baseURL =
      "https://webtoon-crawler.nomadcoders.workers.dev";
  static const String today = "today";

  static Future<List<WebtoonModel>> getTodaysToon() async {
    List<WebtoonModel> webtoonsInstances = [];
    final url = Uri.parse('$baseURL/$today');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> webtoons = jsonDecode(response.body);
      for (var webtoon in webtoons) {
        final intance = WebtoonModel.fromJson(webtoon);
        webtoonsInstances.add(intance);
      }
      return webtoonsInstances;
    }
    throw Error();
  }

  static Future<WebtoonDetailModel> getToonById(String id) async {
    final url = Uri.parse("$baseURL/$id");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final webtoon = json.decode(response.body);
      return WebtoonDetailModel.fromJson(webtoon);
    }
    throw Error();
  }

  static Future<List<WebtoonEpisode>> getLatestEpisodeById(String id) async {
    List<WebtoonEpisode> episodesInstances = [];
    final url = Uri.parse("$baseURL/$id/episodes");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final episodes = json.decode(response.body);
      for (var episode in episodes) {
        episodesInstances.add(WebtoonEpisode.fromJson(episode));
      }
      return episodesInstances;
    }
    throw Error();
  }
}
