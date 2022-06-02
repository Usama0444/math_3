import 'package:shared_preferences/shared_preferences.dart';

class UserSharePreference {
  static SharedPreferences? preference;
  static Future init() async =>
      preference = await SharedPreferences.getInstance();

  static Future setChapterDownload(String _key, String flag) async {
    var pre = await SharedPreferences.getInstance();
    await pre.setString(_key, flag);
  }

  static Future IsDownloaded(String _key) async {
    var flag = await preference!.getString('$_key');

    return flag;
  }
}
