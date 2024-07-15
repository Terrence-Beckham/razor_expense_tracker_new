import 'package:settings_api/models/local_setting.dart';
import 'package:settings_api/settings_api.dart';

/// {@template settings_repo}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class SettingsRepo {
  /// {@macro settings_repo}
  const SettingsRepo({required SettingsApi settingsApi})
      : _settingsApi = settingsApi;

  final SettingsApi _settingsApi;

  ///Provides a Stream of the Settings object
  Stream<LocalSetting?> settingsStream() => _settingsApi.settingsStream();

  ///Saves the settings object back to the database
  Future<void> saveSettings(LocalSetting settings) =>
      _settingsApi.saveSettings(settings);

  ///This increments the ad counter
  Future<void> incrementAdCounter() =>
      _settingsApi.incrementAdCounter();


///Reset the AdCounter to Zero
Future<void> resetAdCounter()=> _settingsApi.resetAdCounter();
}