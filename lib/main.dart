import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maan_application_1/ui/auth/provider/auth_provider.dart';
import 'package:maan_application_1/ui/chat/providers/chat_provider.dart';
import 'package:maan_application_1/ui/chat/ui/chat_page.dart';
import 'package:maan_application_1/ui/chat/ui/edit_screen.dart';
import 'package:maan_application_1/ui/auth/ui/login_screen.dart';
import 'package:maan_application_1/ui/auth/ui/register_screen.dart';
import 'package:maan_application_1/ui/auth/ui/welcome_screen.dart';
import 'package:maan_application_1/ui/chat/ui/profile_page.dart';
import 'package:maan_application_1/ui/helpers/route_helper.dart';
import 'package:maan_application_1/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:responsive_framework/utils/scroll_behavior.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthProvider>(
        create: (context) => AuthProvider(),
      ),
      ChangeNotifierProvider<ChatProvider>(create: (context) => ChatProvider())
    ],
    child: MaterialApp(
      navigatorKey: RouteHelper.routeHelper.navigationKey,
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget),
        maxWidth: 1200,
        minWidth: 400,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(400, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP),
        ],
      ),
      routes: {
        ProfilePage.routeName: (context) => ProfilePage(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        EditScreen.routeName: (context) => EditScreen(),
        WelcomeScreen.routeName: (context) => WelcomeScreen(),
        SplashScreen.routeName: (context) => SplashScreen(),
        ChatPage.routeName: (context) => ChatPage(),
      },
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  ));
}

class MyApp extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  AuthProvider authProvider = AuthProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error'),
            ),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            home: SplashScreen(),
            debugShowCheckedModeBanner: false,
          );
        }
        return Scaffold(
          backgroundColor: Color(0XFFE79215),
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
