import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:pathfinder/utilities/consts/color_consts.dart';
import 'package:pathfinder/utilities/pref_utils.dart';
import 'package:pathfinder/view/onboarding/login_page.dart';
import 'package:pathfinder/view/onboarding/pin_setup_page.dart';
import 'package:pathfinder/view_model/dashboard_view_model.dart';
import 'package:pathfinder/view_model/login_view_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'notification_services.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  // NotificationServices().showNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );



  // final RemoteMessage remoteMessage =
  //     (await FirebaseMessaging.instance.getInitialMessage())!;
  //
  // debugPrint('remoteMessage ${remoteMessage}');

  // var token = await FirebaseMessaging.instance.getToken();
  // debugPrint('message App is terminated ${token}');

  // RemoteMessage? initialMessage =
  //     await FirebaseMessaging.instance.getInitialMessage();
  //
  // if (initialMessage != null) {
  //   debugPrint('message App is terminated');
  // }

  // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
  //   debugPrint('Just received a notification when app is opened ${message}');
  //   if (message.notification != null) {
  //     //"route" will be your root parameter you sending from firebase
  //   }
  // });

  if (!kDebugMode) {
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DashboardViewModel()),
        ChangeNotifierProvider(create: (_) => LoginViewModel()),
        // ChangeNotifierProvider(create: (_) => StepperViewModel()),
      ],
      child: MaterialApp(
          title: 'Flutter App',
          theme: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: Palette.primaryColor,
                ),
          ),
          home: AnimatedSplashScreen(
            splash: Image.asset('assets/images/logo.png'),
            // backgroundColor: Colors.orange,
            nextScreen: FutureBuilder(
              future: PrefUtils().getUserData(),
              builder: (context, snapShot) {
                if (snapShot.hasData) {
                  if (snapShot.data!.isNotEmpty) {
                    return PinSetUpPage(
                        securityPinType: SecurityPinType.authenticate);
                  }
                  return LoginPage();
                }
                return LoginPage();
              },
            ),
          )),
    );
  }
}
