import 'package:flutter/material.dart';
import '../theme_provider.dart';
import '../localization_provider.dart';
import 'package:provider/provider.dart';
import '../app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final localizationProvider = Provider.of<LocalizationProvider>(context);
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.translate('settings')!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(localizations.translate('theme')!, style: const TextStyle(fontSize: 18)),
            SwitchListTile(
              title: Text(localizations.translate('dark_theme')!),
              value: themeProvider.isDarkMode,
              onChanged: (bool value) {
                themeProvider.toggleTheme(value);
              },
            ),
            const SizedBox(height: 20),
            Text(localizations.translate('language')!, style: const TextStyle(fontSize: 18)),
            DropdownButton<String>(
              value: localizationProvider.currentLanguage,
              items: [
                DropdownMenuItem(value: 'en', child: Text(localizations.translate('english')!)),
                DropdownMenuItem(value: 'tr', child: Text(localizations.translate('turkish')!)),
              ],
              onChanged: (String? newValue) {
                localizationProvider.changeLanguage(newValue!);
              },
            ),
          ],
        ),
      ),
    );
  }
}

