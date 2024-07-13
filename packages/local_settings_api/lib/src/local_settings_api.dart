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
      BehaviorSubject<List<LocalSetting>>.seeded(const []);

  ///Initializes the Settings DataBase
  Future<void> initSettingsDB() async {
    final settings =
        await _isarDb.localSettings.filter().idEqualTo(1).findAll();
    if (settings.isEmpty) {
      final settings = LocalSetting();
      await _isarDb.writeTxn(() async => _isarDb.localSettings.put(settings));
    }
    _settingsStreamController.add(settings);
  }

  @override
  Future<void> close() {
    // TODO: implement close
    throw UnimplementedError();
  }

  @override
  Future<void> saveSettings(LocalSetting setting) async {
    await _isarDb.writeTxn(() async => _isarDb.localSettings.put(setting));
    final settings = await _isarDb.localSettings.where().findAll();
    _settingsStreamController.add(settings);
  }

  @override
  Stream<List<LocalSetting>> settingStream() {
    return _settingsStreamController.asBroadcastStream();
  }

  @override
  Future<void> getSettings() async {
    final settings =
        await _isarDb.localSettings.filter().idEqualTo(1).findAll();
    _settingsStreamController.add(settings);
  }

  ///This needs to be added to the repo
  Future<void> incrementAdCounter() async {
    final settings =
        await _isarDb.localSettings.filter().idEqualTo(1).findFirst();
    settings?.adCounterNumber += 1;
    await saveSettings(settings!);
  }

  @override
  Future<void> updateSettingsToDB(LocalSetting settings) async {}

  Future<void> setAdCounterThreshold(int newThreshold) async {
    final settings =
        await _isarDb.localSettings.filter().idEqualTo(1).findFirst();
    settings!.adCounterThreshold = newThreshold;

    await saveSettings(settings);
  }
}
