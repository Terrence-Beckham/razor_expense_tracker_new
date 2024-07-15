import 'package:isar/isar.dart';

part 'local_setting.g.dart';

///This is the Settings object from the Database
@collection
class LocalSetting {
  Id id = 1;
  int adCounterNumber = 0;

  int adCounterThreshold = 5;
}

//
// Future<Settings?> init() async {
//   final settings =
//   await _isar.settings.filter().nameMatches('SETTINGS').findFirst();
//   _logger.i('This is the settings object $settings');
//   if (settings == null) {
//     await initSettingsDB();
//   }
//   return settings;
//
