import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';

Future<List<Team>> fetchLeagueData() async {
  final url = Uri.parse(
      'https://api.collectapi.com/sport/league?data.league=super-lig');

  final headers = {
    'content-type': 'application/json',
    'authorization': apikey,
  };

  final response = await http.get(url, headers: headers);

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    // print(data);
    List<Team> teams = (data['result'] as List)
        .map((teamJson) => Team.fromJson(teamJson))
        .toList();
    return teams;
  } else {
    throw ('Error: ${response.statusCode}');
  }
}

class Team {
  final int rank;
  final String team;
  final int win;
  final int lose;
  final int play;
  final int point;

  Team(
    this.rank,
    this.team,
    this.win,
    this.lose,
    this.play,
    this.point,
  );

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      json['rank'],
      json['team'],
      json['win'],
      json['lose'],
      json['play'],
      json['point'],
    );
  }
}

Future<List<dynamic>> fetchLeagues() async {
  final response = await http.get(
    Uri.parse('https://api.collectapi.com/sport/leaguesList'),
    headers: {
      'content-type': 'application/json',
      'authorization': apikey,
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    print(data);
    print(response.body);
    return data['result'];
  } else {
    throw ('Error: ${response.statusCode}');
  }
}

class ApiService {
  Future<List<dynamic>> fetchSportResults() async {
    final uri = Uri.https(
        'api.collectapi.com', '/sport/results', {'data.league': 'super-lig'});
    // final uri = Uri.parse(
    //     'api.collectapi.com/sport/results'  // burada model belirtmeden bu şekilde kullanma
    //   );

    final response = await http.get(
      uri,
      headers: {
        'content-type': 'application/json',
        'authorization': apikey,
      },
    );

    if (response.statusCode == 200) {
      print(response.statusCode);
      final data = jsonDecode(response.body);
      print(response.body);
      print(data);
      return data['result'];
    } else {
      throw ('Error: ${response.statusCode}');
    }
  }
}
