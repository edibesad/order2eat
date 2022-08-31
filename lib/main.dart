import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:order2eat/models/user_model.dart';
import 'package:order2eat/pages/login_page.dart';
import 'package:order2eat/providers/all_providers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

//Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

  OneSignal.shared.setAppId("0f9f7d3d-73cf-4fd1-93c4-53fd621cd481");

// The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    checkUser(ref);
  }

  @override
  build(BuildContext context) {
    UserModel userModel = ref.watch(userProvider.state).state;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontSize: 16.0),
          bodyText2: TextStyle(fontSize: 20.0),
          button: TextStyle(fontSize: 16.0),
        ),
      ),
      home: userModel.user != null
          ? ref.watch(openedPageProvider)
          : const LoginPage(),
    );
  }

  Future<void> checkUser(WidgetRef ref) async {
    final prefs = await SharedPreferences.getInstance();
    // prefs.clear();

    if (prefs.containsKey("id")) {
      ref.read(userProvider.state).state = UserModel(
          user: User(
        id: prefs.getInt("id"),
        companyId: prefs.getInt("company_id"),
        name: prefs.getString("name"),
        surname: prefs.getString("surname"),
        email: prefs.getString("email"),
        pictureThumb: prefs.getString(
          "picture_thumb",
        ),
      ));
      ref.read(passwordProvider.state).state = prefs.getString("password");
    }
  }
}
