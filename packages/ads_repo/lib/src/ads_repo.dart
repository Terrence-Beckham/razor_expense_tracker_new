import 'package:ads_client/ads_client.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:settings_repo/settings_repo.dart';

import 'ads_repo_patterns.dart';

/// {@template ads_repo}
/// Repository class handling Ad serving
/// by leveraging the lower level [AdsClient].
/// {@endtemplate}
class AdsRepo {
  /// {@macro ads_repo}
  AdsRepo({
    required AdsClient adsClient,
    required SettingsRepo settingsRepo,
  })  : _adsClient = adsClient,
        _logger = Logger(),
        _settingsRepo = settingsRepo;

  final AdsClient _adsClient;
  final SettingsRepo _settingsRepo;
  final Logger _logger;

  /// Gets an interstitial Ad displayed in the Counter Page
  ///  when users increment the counter to a given positive threshold.
  Future<InterstitialAdPattern> getInterstitialAd({
    required VoidCallback onAdDismissedFullScreenContent,
  }) async {
    try {
      final interstitialAd = await _adsClient.getInterstitial(
        onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
      );
      await interstitialAd.show();
      await _settingsRepo.resetAdCounter();

      return (failure: null, value: interstitialAd);
    } catch (e, st) {
      return (
        failure: (
          error: e,
          stackTrace: st,
          optional: 'Exception caught in InterstitialAd',
        ),
        value: null,
      );
    }
  }
}
