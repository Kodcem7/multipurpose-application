import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';
import '../app_localizations.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() {
    return _WeatherPageState();
  }
}

class _WeatherPageState extends State<WeatherPage> {
  String selectedCity = 'Paris';
  String selectedLanguage = 'en';

  final List<String> cities = [
    'Paris',
    'London',
    'Berlin',
    'Istanbul',
    'Ankara',
    'Antalya',
    'Warsaw',
    'Hamburg',
    'Moscow',
    'Riga',
    'New York',
    'Boston',
    'Liverpool',
    'Tokyo',
    'Seul'
  ];
  final List<String> languages = ['tr', 'en', 'de'];

  List<dynamic>? weatherData;
  bool isLoading = false;

  Future<void> fetchWeather() async {
    setState(() {
      isLoading = true;
    });

    var url = Uri.https('api.collectapi.com', '/weather/getWeather', {
      'data.lang': selectedLanguage,
      'data.city': selectedCity,
    });

    var response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'authorization': apikey,
      },
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        weatherData = data['result'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Request failed with status: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('hava durumu')!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
              width: 200,
              child: DropdownButtonFormField<String>(
                value: selectedCity,
                decoration: InputDecoration(
                  labelText: localizations.translate('şehir')!,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                items: cities.map((String city) {
                  return DropdownMenuItem<String>(
                    value: city,
                    child: Text(city),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedCity = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 50,
              width: 200,
              child: DropdownButtonFormField<String>(
                value: selectedLanguage,
                decoration: InputDecoration(
                  labelText: localizations.translate('dil (tr/en vb.)')!,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                items: languages.map((String language) {
                  return DropdownMenuItem<String>(
                    value: language,
                    child: Text(language),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedLanguage = newValue!;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: fetchWeather,
              child: Text(localizations.translate('hava durumu getir')!),
            ),
            const SizedBox(height: 16),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : weatherData != null
                    ? Expanded(
                        child: ListView.builder(
                          itemCount: weatherData!.length,
                          itemBuilder: (context, index) {
                            var dayData = weatherData![index];
                            return Card(
                              child: ListTile(
                                leading: Image.network(dayData['icon'],
                                    width: 100, height: 100, fit: BoxFit.cover),
                                title: Text(
                                    '${dayData['day']} - ${dayData['date']}'),
                                subtitle: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        '${localizations.translate('durum')!}: ${dayData['description']}'),
                                    Text(
                                        '${localizations.translate('sicaklik')!}: ${dayData['degree']}°C'),
                                    Text(
                                        '${localizations.translate('min')!}: ${dayData['min']}°C'),
                                    Text(
                                        '${localizations.translate('max')!}: ${dayData['max']}°C'),
                                    Text(
                                        '${localizations.translate('gece')!}: ${dayData['night']}°C'),
                                    Text(
                                        '${localizations.translate('nem')!}: ${dayData['humidity']}%'),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    : Text(localizations.translate('veri yüklenemedi')!),
          ],
        ),
      ),
    );
  }
}



// class _WeatherPageState extends State<WeatherPage> {
//   String selectedCity = 'Paris';
//   String selectedLanguage = 'en';

//   final List<String> languages = ['tr', 'en', 'de'];

//   String city = "";
//   String lang = "tr";
//   List<dynamic>? weatherData;
//   bool isLoading = false;

//   final TextEditingController cityController = TextEditingController();
//   final TextEditingController langController = TextEditingController();

//   Future<void> fetchWeather() async {
    
//     setState(() {
//       isLoading = true;
//     });

//     var url = Uri.https('api.collectapi.com', '/weather/getWeather', {
//       'data.lang': lang,
//       'data.city': city,
//     });

//     var response = await http.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//         'authorization': apikey,
//       },
//     );

//     if (response.statusCode == 200) {
//       var data = jsonDecode(response.body);
//       setState(() {
//         weatherData = data['result'];
//         isLoading = false;
//       });
//     } else {
//       setState(() {
//         isLoading = false;
//       });
//       print('Request failed with status: ${response.statusCode}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final localizations = AppLocalizations.of(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(localizations.translate('hava durumu')!),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             TextField(
//               controller: cityController,
//               decoration: InputDecoration(
//                 labelText: localizations.translate('şehir')!,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12.0),
//                 ),
//               ),
//               onChanged: (value) {
//                 city = value;
//               },
//             ),
//             const SizedBox(
//               height: 5,
//             ),
//             TextField(
//               controller: langController,
//               decoration: InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(12.0),
//                   ),
//                   labelText: localizations.translate('dil (tr/en vb.)')!),
//               onChanged: (value) {
//                 lang = value;
//               },
//             ),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: fetchWeather,
//               child: Text(localizations.translate('hava durumu getir')!),
//             ),
//             const SizedBox(height: 16),
//             isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : weatherData != null
//                     ? Expanded(
//                         child: ListView.builder(
//                           itemCount: weatherData!.length,
//                           itemBuilder: (context, index) {
//                             var dayData = weatherData![index];
//                             return Card(
//                               child: ListTile(
//                                 leading: Image.network(dayData['icon'],
//                                     width: 100, height: 100, fit: BoxFit.cover),
//                                 title: Text(
//                                     '${dayData['day']} - ${dayData['date']}'),
//                                 subtitle: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                         '${localizations.translate('durum')!}: ${dayData['description']}'),
//                                     Text(
//                                         '${localizations.translate('sicaklik')!}: ${dayData['degree']}°C'),
//                                     Text(
//                                         '${localizations.translate('min')!}: ${dayData['min']}°C'),
//                                     Text(
//                                         '${localizations.translate('max')!}: ${dayData['max']}°C'),
//                                     Text(
//                                         '${localizations.translate('gece')!}: ${dayData['night']}°C'),
//                                     Text(
//                                         '${localizations.translate('nem')!}: ${dayData['humidity']}%'),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                     : Text(localizations.translate('veri yüklenemedi')!),
//           ],
//         ),
//       ),
//     );
//   }
// }
