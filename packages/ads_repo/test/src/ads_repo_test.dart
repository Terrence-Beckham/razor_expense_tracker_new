// ignore_for_file: prefer_const_constructors

import 'package:ads_client/ads_client.dart';
import 'package:ads_repo/ads_repo.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AdsRepo', () {
    test('can be instantiated', () {
      expect(AdsRepo(adsClient: AdsClient()), isNotNull);
    });
  });
}
