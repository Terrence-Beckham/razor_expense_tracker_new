import 'package:google_mobile_ads/google_mobile_ads.dart';

/// {@template ads}
/// Helper enum listing all the Counter Ads to be displayed.
///
/// It supports iOS and Android ads for both production and debug builds.
/// {@endtemplate}
enum Ads {
 

  /// Interstitial Ad displayed in the Counter Page
  interstitial(
    iOS: 'ca-app-pub-2894409721628955/9237636008',
    android: 'ca-app-pub-2894409721628955/2685821476',
    iOSTest: 'ca-app-pub-3940256099942544/4411468910',
    androidTest: 'ca-app-pub-3940256099942544/1033173712',
  );



  const Ads({
    required this.iOS,
    required this.android,
    required this.iOSTest,
    required this.androidTest,
  });

  /// iOS Ad id.
  final String iOS;

  /// Android Ad id.
  final String android;

  /// iOS Ad id for testing.
  final String iOSTest;

  /// Android Ad id for testing.
  final String androidTest;
}