import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tagxi_super_user/functions/functions.dart';
import 'package:tagxi_super_user/functions/notifications.dart';
import 'package:tagxi_super_user/provider/Categorie.dart';
import 'package:tagxi_super_user/screen/FoodSignIn.dart';
import 'package:tagxi_super_user/store/AppStore.dart';
import 'pages/loadingPage/loadingpage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';

AppStore appStore = AppStore();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp();
  checkInternetConnection();

  initMessaging();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => Categorie()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    platform = Theme.of(context).platform;
    return GestureDetector(
        onTap: () {
          //remove keyboard on touching anywhere on the screen.
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'product name',
            theme: ThemeData(),
            home: FoodSignIn()));
  }
}
