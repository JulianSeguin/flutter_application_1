import 'package:shared_preferences/shared_preferences.dart';

class SettingsPersistence {
  Future<void> saveSettings(String username, String image) async {
    final prefs = await SharedPreferencesAsync();
    await prefs.setString('username', username);
    await prefs.setString('backgroundImage', image);
  }

  Future<Map<String, String>> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username') ?? '';
    final backgroundImage = prefs.getString('backgroundImage') ?? '';
    return {
      'username': username,
      'backgroundImage': backgroundImage,
    };
  }
}