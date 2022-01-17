import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:jjyourchoice/pages/page_splash.dart';
import 'package:jjyourchoice/provider/provider_tab.dart';
import 'package:jjyourchoice/route.dart';
import 'package:jjyourchoice/style/colors.dart';
import 'package:provider/provider.dart';

void main() {
  runServer();
}

runServer() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProviderTab()),
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
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: MColors.tomato),
        ),
        debugShowCheckedModeBanner: false,
        home: const PageSplash(),
        onGenerateRoute: Routers.generateRoute,
        builder: EasyLoading.init(),
      ),
    );
  }
}
