import 'package:flutter/material.dart';
import 'futball_league_pages.dart';
import 'settings_page.dart';
import '../app_localizations.dart';
import 'news_page.dart';
import 'weather_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  static const List<Widget> pages = [
    Center(
      child: Icon(
        Icons.home,
        color: Color.fromARGB(255, 249, 18, 18),
        size: 100.0,
      ),
    ),
    NewsPage(),
    WeatherPage(),
    FutballLeague()
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('home_page')!),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 249, 18, 18),
              ),
              child: Text('Yooo'),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: Text(localizations.translate('settings')!),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsPage()),
                );
              },
            ),
          ],
        ),
      ),
      
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color.fromARGB(255, 249, 18, 18),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: localizations.translate('home')!,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.newspaper),
            label: localizations.translate('news')!,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.cloud),
            label: localizations.translate('weather')!,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.sports),
            label: localizations.translate('futball')!,
          ),
        ],
        currentIndex: selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
