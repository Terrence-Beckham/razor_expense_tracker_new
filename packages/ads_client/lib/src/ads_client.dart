import 'dart:async';
import 'dart:io';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';

import '../ads_client.dart';
import 'exceptions.dart';

/// {@template ads_client}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class AdsClient {
  /// {@macro ads_client}

  AdsClient() {
    _ads = _initializeAds();
  }

  late final Map<Ads, String> _ads;

  Map<Ads, String> _initializeAds() {
    final ads = <Ads, String>{};
    for (final ad in Ads.values) {
      if (Platform.isIOS) {
        if (kDebugMode) {
          ads[ad] = ad.iOSTest;
        } else {
          ads[ad] = ad.iOS;
        }
      } else {
        if (kDebugMode) {
          ads[ad] = ad.androidTest;
        } else {
          ads[ad] = ad.android;
        }
      }
    }

    return ads;
  }

  ///Gets an interstitial Add
  Future<InterstitialAd> getInterstitial({
    required VoidCallback onAdDismissedFullScreenContent,
  }) async {
    try {
      return await _populateInterstitialAd(
        adUnitId: _ads[Ads.interstitial]!,
        onAdDismissedFullScreenContent: onAdDismissedFullScreenContent,
      );
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(AdsClientException(error), stackTrace);
    }
  }


  Future<InterstitialAd> _populateInterstitialAd({
    required String adUnitId,
    required VoidCallback onAdDismissedFullScreenContent,
  }) async {
    try {
      final adCompleter = Completer<Ad?>();
      print('this should be the add: $adCompleter');
      await InterstitialAd.load(
        adUnitId: adUnitId,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                onAdDismissedFullScreenContent();
              },
            );
            adCompleter.complete(ad);
          },
          onAdFailedToLoad: adCompleter.completeError,
        ),
      );

      final interstitialAd = await adCompleter.future;
      if (interstitialAd == null) {
        throw const AdsClientException('Interstitial Ad was null');
      }
      return interstitialAd as InterstitialAd;
    } catch (error, stackTrace) {
      Error.throwWithStackTrace(AdsClientException(error), stackTrace);
    }
  }
}
