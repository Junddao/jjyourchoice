import 'dart:convert';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jjyourchoice/pages/00_intro/page_splash.dart';
import 'package:jjyourchoice/provider/provider_coffee.dart';
import 'package:jjyourchoice/provider/provider_tab.dart';
import 'package:jjyourchoice/provider/provider_user.dart';
import 'package:jjyourchoice/route.dart';
import 'package:jjyourchoice/service/api_service.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:provider/provider.dart';

import 'models/model_config.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  KakaoContext.clientId = "e57179e755fc254a957e616844e0dd8c";
  runServer();
}

runServer() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await ApiService().getDeviceUniqueId();

  await readConfigFile();

  runApp(const MyApp());
}

Future<void> readConfigFile() async {
  var configJson;

  configJson = await rootBundle.loadString('assets/texts/config.json');

  print(configJson);
  final configObject = jsonDecode(configJson);
  ModelConfig().fromJson(configObject);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("firebase load fail"),
            );
          }
          if (snapshot.connectionState != ConnectionState.done) {
            return CircularProgressIndicator();
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => ProviderTab()),
              ChangeNotifierProvider(create: (_) => ProviderUser()),
              ChangeNotifierProvider(create: (_) => ProviderCoffee()),
            ],
            child: MaterialApp(
              theme: ThemeData(
                primaryColor: Colors.white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
                bottomSheetTheme:
                    BottomSheetThemeData(backgroundColor: Colors.transparent),
                appBarTheme: AppBarTheme(
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
                colorScheme: ColorScheme.fromSwatch()
                    .copyWith(secondary: MColors.tomato),
              ),
              debugShowCheckedModeBanner: false,
              home: const PageSplash(),
              onGenerateRoute: Routers.generateRoute,
              builder: EasyLoading.init(),
            ),
          );
        });
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
