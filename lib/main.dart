import 'package:ads_client/ads_client.dart';
import 'package:ads_repo/ads_repo.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:isar/isar.dart';
import 'package:local_settings_api/local_settings_api.dart';
import 'package:local_storage_transactions_api/local_storage_transactions_api.dart';
import 'package:path_provider/path_provider.dart';
import 'package:razor_expense_tracker_new/src/app/app.dart';
import 'package:settings_api/models/local_setting.dart';
import 'package:settings_repo/settings_repo.dart';
import 'package:transactions_api/transactions_api.dart';
import 'package:transactions_repository/transactions_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Bloc.observer =  AppBlocObserver();
  await EasyLocalization.ensureInitialized();
  await MobileAds.instance.initialize();
  print('Mobile Ads Instance: ${MobileAds.instance}');
  final dir = await getApplicationDocumentsDirectory();

  final isar = await Isar.open(
    [TransactionSchema, StoredCategorySchema, LocalSettingSchema],
    directory: dir.path,
  );
  final settingsApi = LocalSettingsApi(isarDb: isar);
  final settingsRepo = SettingsRepo(settingsApi: settingsApi);
  final adsClient = AdsClient();
  final adsRepo = AdsRepo(adsClient: adsClient, settingsRepo: settingsRepo);

  final transactionsApi = LocalStorageTransactionsApi(
    isarDb: isar,
  );

  final transactionRepository = TransactionsRepo(
    transactionsApi: transactionsApi,
  );

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => transactionRepository,
          ),
          RepositoryProvider(create: (context) => adsRepo),
          RepositoryProvider(create: (context) => settingsRepo),
        ],
        child: App(
          transactionsRepository: transactionRepository,
          adsRepo: adsRepo,
          settingsRepo: settingsRepo,
        ),
      ),
    ),
  );
}
// RepositoryProvider(
// create: (context) => transactionRepository,
// ),
