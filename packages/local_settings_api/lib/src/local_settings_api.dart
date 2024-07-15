import 'package:isar/isar.dart';
import 'package:logger/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:settings_api/models/local_setting.dart';
import 'package:settings_api/settings_api.dart';

/// {@template local_settings_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class LocalSettingsApi extends SettingsApi {
  /// {@macro local_settings_api}
  LocalSettingsApi({required Isar isarDb})
      : _isarDb = isarDb,
        _logger = Logger() {
    initSettingsDB();
  }

  final Isar _isarDb;
  final Logger _logger;
  late final _settingsStreamController =
      BehaviorSubject<LocalSetting?>.seeded(null);

  /// Initializes the Settings DataBase
  Future<void> initSettingsDB() async {
    final settings = await getSettings();
    if (settings == null) {
      final newSettings = LocalSetting()..id = 1;
      await _isarDb
          .writeTxn(() async => _isarDb.localSettings.put(newSettings));
      _settingsStreamController.add(newSettings);
    } else {
      _settingsStreamController.add(settings);
    }
  }

  @override
  Future<void> close() async {
    await _settingsStreamController.close();
  }

  @override
  Future<void> saveSettings(LocalSetting setting) async {
    await _isarDb.writeTxn(() async => _isarDb.localSettings.put(setting));
    final updatedSetting = await getSettings();
    _settingsStreamController.add(updatedSetting);
  }

  @override
  Stream<LocalSetting?> settingsStream() {
    return _settingsStreamController.asBroadcastStream();
  }

  @override
  Future<void> addSettingsToStream() async {
    final settings = await getSettings();
    _settingsStreamController.add(settings);
  }

  /// This needs to be added to the repo
  @override
  Future<void> incrementAdCounter() async {
    final settings = await getSettings();
    if (settings != null) {
      settings.adCounterNumber += 1;
      await saveSettings(settings);
    }
  }

  @override
  Future<void> setAdCounterThreshold(int newThreshold) async {
    final settings = await getSettings();
    if (settings != null) {
      settings.adCounterThreshold = newThreshold;
      await saveSettings(settings);
    }
  }

  @override
  Future<void> resetAdCounter() async {
    final setting = await getSettings();
    setting!.adCounterNumber = 0;
    await saveSettings(setting);
  }

  ///Get the setting object from the DB
  Future<LocalSetting?> getSettings() async {
    return _isarDb.localSettings.filter().idEqualTo(1).findFirst();
  }
}
