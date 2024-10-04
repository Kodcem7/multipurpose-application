import 'package:flutter/material.dart';
import 'league_API.dart';


class SportResultsPage extends StatefulWidget {
  const SportResultsPage({super.key});

  @override
  State<SportResultsPage> createState() => _SportResultsPageState();
}

class _SportResultsPageState extends State<SportResultsPage> {
  late Future<List<dynamic>> resultsFuture;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    resultsFuture = apiService.fetchSportResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Süper Lig Sonuçları'),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: resultsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final results = snapshot.data!;
            return ListView.builder(
              itemCount: results.length,
              itemBuilder: (context, index) {
                final match = results[index];
                return ListTile(
                  title: Text('${match['home']} vs ${match['away']}'),
                  subtitle: Text('${match['date']} \nSkor: ${match['score']}'),
                );
              },
            );
          } else {
            return const Center(child: Text('Sonuç bulunamadi'));
          }
        },
      ),
    );
  }
}

class SportResult {
  final bool success;
  final List<MatchResult> result;

  SportResult({
    required this.success,
    required this.result,
  });

  factory SportResult.fromJson(Map<String, dynamic> json) {
    return SportResult(
      success: json['success'],
      result: List<MatchResult>.from(
        json['result'].map((data) => MatchResult.fromJson(data)),
      ),
    );
  }
}

class MatchResult {
  final String score;
  final String date;
  final String away;
  final String home;

  MatchResult({
    required this.score,
    required this.date,
    required this.away,
    required this.home,
  });

  factory MatchResult.fromJson(Map<String, dynamic> json) {
    return MatchResult(
      score: json['score'],
      date: json['date'],
      away: json['away'],
      home: json['home'],
    );
  }
}