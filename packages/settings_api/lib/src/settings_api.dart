import '../models/local_setting.dart';

/// {@template settings_api}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
abstract class SettingsApi {
  /// {@macro settings_api}
  const SettingsApi();

  ///reset AdCounter to Zero
  Future<void> resetAdCounter();

  /// Provides a [Stream] of all Settings.
  Stream<LocalSetting?> settingsStream();

  /// If a [Setting] with the same id already exists, it will be replaced.

  Future<void> saveSettings(
    LocalSetting setting,
  );

  ///Queries transactions and adds them to the stream
  Future<void> addSettingsToStream();

  /// Closes the client and frees up any resources.
  Future<void> close();

  /// This increments the AddCounter
  Future<void> incrementAdCounter();

  ///This method changes the threshold on which ads will be shown
  Future<void> setAdCounterThreshold(int newThreshold);
}

/// Error thrown when a [Setting] with a given id is not found.
class SettingsNotFoundException implements Exception {}
