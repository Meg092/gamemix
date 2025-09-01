import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game_mix/pages/game_mix_coin_flip/game_mix_coin_flip_binding.dart';
import 'package:game_mix/pages/game_mix_coin_flip/game_mix_coin_flip_view.dart';
import 'package:game_mix/pages/game_mix_config/game_mix_config_binding.dart';
import 'package:game_mix/pages/game_mix_config/game_mix_config_view.dart';
import 'package:game_mix/pages/game_mix_draw_lots/game_mix_draw_lots_binding.dart';
import 'package:game_mix/pages/game_mix_draw_lots/game_mix_draw_lots_view.dart';
import 'package:game_mix/pages/game_mix_draw_lots_history/game_mix_draw_lots_history_binding.dart';
import 'package:game_mix/pages/game_mix_draw_lots_history/game_mix_draw_lots_history_view.dart';
import 'package:game_mix/pages/game_mix_grid_play/game_mix_grid_play_binding.dart';
import 'package:game_mix/pages/game_mix_grid_play/game_mix_grid_play_tion.dart';
import 'package:game_mix/pages/game_mix_grid_play/game_mix_grid_play_view.dart';
import 'package:game_mix/pages/game_mix_randomizer/game_mix_randomizer_binding.dart';
import 'package:game_mix/pages/game_mix_randomizer/game_mix_randomizer_view.dart';
import 'package:game_mix/pages/game_mix_set_grid_play/game_mix_set_grid_play_binding.dart';
import 'package:game_mix/pages/game_mix_set_grid_play/game_mix_set_grid_play_view.dart';
import 'package:game_mix/pages/game_mix_setting/game_mix_setting_binding.dart';
import 'package:game_mix/pages/game_mix_setting/game_mix_setting_view.dart';
import 'package:game_mix/pages/game_mix_tab/game_mix_tab_binding.dart';
import 'package:game_mix/pages/game_mix_tab/game_mix_tab_view.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'db_game_mix/db_game_mix.dart';

Color primaryColor = const Color(0xFF6873F7);
Color bgColor = const Color(0xFFFFFFFF);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Get.putAsync(() => DB().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: Road,
          initialRoute: '/',
          theme: ThemeData(
            useMaterial3: true,
            primaryColor: primaryColor,
            scaffoldBackgroundColor: bgColor,
            colorScheme: ColorScheme.light(
              primary: primaryColor,
              surface: Color(0xFFF8F8F8),
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              scrolledUnderElevation: 0,
              centerTitle: true,
              titleTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF0F0F0F),
              ),
              backgroundColor: Colors.white,
            ),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              selectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12,
              ),
              showSelectedLabels: true,
              showUnselectedLabels: true,
              selectedItemColor: const Color(0xFF6873F7),
              unselectedItemColor: Color.fromARGB(255, 99, 95, 95),
              elevation: 0,
              backgroundColor: Color(0xFFF8F8F8),
            ),
            inputDecorationTheme: const InputDecorationTheme(
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            dividerTheme: DividerThemeData(
              thickness: 1,
              color: Colors.grey[200],
            ),
          ),
        );
      },
    );
  }
}

List<GetPage<dynamic>> Road = [
  GetPage(
    name: '/',
    page: () => GameMixConfigView(),
    binding: GameMixConfigBinding(),
  ),
  GetPage(
    name: '/game_mix_tab',
    page: () => GameMixTabPage(),
    binding: GameMixTabBinding(),
  ),
  GetPage(
    name: '/game_mix_grid_play',
    page: () => GameMixGridPlayPage(),
    binding: GameMixGridPlayBinding(),
  ),
  GetPage(
    name: '/game_mix_grid_col',
    page: () => GameMixGridPlayTion(),
  ),
  GetPage(
    name: '/game_mix_set_grid_play',
    page: () => GameMixSetGridPlayPage(),
    binding: GameMixSetGridPlayBinding(),
  ),
  GetPage(
    name: '/game_mix_coin_flip',
    page: () => GameMixCoinFlipPage(),
    binding: GameMixCoinFlipBinding(),
  ),
  GetPage(
    name: '/game_mix_randomizer',
    page: () => GameMixRandomizerPage(),
    binding: GameMixRandomizerBinding(),
  ),
  GetPage(
    name: '/game_mix_draw_lots',
    page: () => GameMixDrawLotsgPage(),
    binding: GameMixDrawLotsBinding(),
  ),
  GetPage(
    name: '/game_mix_draw_lots_history',
    page: () => GameMixDrawLotsHistoryPage(),
    binding: GameMixDrawLotsHistoryBinding(),
  ),
  GetPage(
    name: '/game_mix_setting',
    page: () => GameMixSettingPage(),
    binding: GameMixSettingBinding(),
  ),
];
