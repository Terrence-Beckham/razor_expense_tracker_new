import 'package:ads_client/ads_client.dart';
import 'package:flutter/foundation.dart';

import 'ads_repo_patterns.dart';

/// {@template ads_repo}
/// Repository class handling Ad serving
/// by leveraging the lower level [AdsClient].
/// {@endtemplate}
class AdsRepo {
  /// {@macro ads_repo}
  const AdsRepo({required AdsClient adsClient}) : _adsClient = adsClient;

  final AdsClient _adsClient;

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
     print('This is the interstitial ad: ${interstitialAd.responseInfo}');
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
