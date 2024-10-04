import 'package:flutter/material.dart';
import '../app_localizations.dart';
import 'sport_result_page.dart';
import 'league_API.dart';


class FutballLeague extends StatefulWidget {
  const FutballLeague({super.key});

  @override
  State<FutballLeague> createState() {
    return _FutballLeagueState();
  }
}

class _FutballLeagueState extends State<FutballLeague> {

  @override
  void initState(){
    super.initState();
    futureTeams = fetchLeagueData();
    
  }

  late Future<List<Team>> futureTeams;
  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            localizations.translate('leagues')!,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
          ),
          Expanded(
            child: FutureBuilder<List<Team>>(
              future: futureTeams,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Bir hata oluştu: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text(localizations.translate('veri yok')!));
                } else {
                  final teams = snapshot.data!;
                  return ListView.builder(
                    itemCount: teams.length,
                    itemBuilder: (context, index) {
                      final team = teams[index];
                      return ListTile(
                        title: Text('${team.rank}. ${team.team}'),
                        subtitle: Text(
                          'Oynanan: ${team.play} | Kazanilan: ${team.win} | Kaybedilen: ${team.lose} | Puan: ${team.point}',
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
          const Expanded(child: SportResultsPage()),
          // const Expanded(child: ),
        ],
      ),
    );
  }
}
