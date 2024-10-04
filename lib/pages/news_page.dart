import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/constant.dart';
import '../app_localizations.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() {
    return _NewsPageState();
  }
}

class _NewsPageState extends State<NewsPage> {
  late Future<List<dynamic>> newsFuture;

  String selectedTag = 'general';
  String selectedCountry = 'tr';

  final List<String> tags = ['general', 'sport', 'technology'];
  final List<String> countries = ['tr', 'en', 'de'];

  @override
  void initState() {
    super.initState();
    newsFuture = fetchNews(tag: selectedTag, country: selectedCountry);
  }

  Future<List<dynamic>> fetchNews(
      {required String tag, required String country}) async {
    final uri = Uri.https(
      'api.collectapi.com',
      '/news/getNews',
      {
        'tag': tag,
        'country': country,
      },
    );

    final response = await http.get(
      uri,
      headers: {
        'content-type': 'application/json',
        'authorization': apikey,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['result'];
    } else {
      throw Exception('Haberler alinamadi');
    }
  }

  void searchNews() {
    setState(() {
      newsFuture = fetchNews(tag: selectedTag, country: selectedCountry);
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('news')!),
      ),
      body: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: 200,
                child: DropdownButtonFormField<String>(
                  value: selectedTag,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  items: tags.map((String tag) {
                    return DropdownMenuItem<String>(
                      value: tag,
                      child: Text(tag),
                    );
                  }).toList(),
                  onChanged: (String? newTag) {
                    setState(() {
                      selectedTag = newTag!;
                    });
                  },
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 50,
                width: 200,
                child: DropdownButtonFormField<String>(
                  value: selectedCountry,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  items: countries.map((String country) {
                    return DropdownMenuItem<String>(
                      value: country,
                      child: Text(country),
                    );
                  }).toList(),
                  onChanged: (String? newCountry) {
                    setState(() {
                      selectedCountry = newCountry!;
                    });
                  },
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: searchNews,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              localizations.translate('haberleri getir')!,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: newsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text('Bir hata oluştu: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final newsList = snapshot.data!;
                  return ListView.builder(
                    itemCount: newsList.length,
                    itemBuilder: (context, index) {
                      final news = newsList[index];
                      return ListTile(
                        leading: Image.network(news['image'],
                            width: 100, height: 100, fit: BoxFit.cover),
                        title: Text(news['name']),
                        subtitle: Text(news['description']),
                        onTap: () {},
                      );
                    },
                  );
                } else {
                  return Center(
                      child:
                          Text(localizations.translate('Haber bulunamadi')!));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
