import 'package:app/ViewModel/AccountVM/change_password_view_model.dart';
import 'package:app/widget/dashbord_screen.dart';
import 'package:app/widget/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ViewModel/AccountVM/send_login_viewModel.dart';
import 'ViewModel/AccountVM/student_details_view_model.dart';
import 'ViewModel/FeeVM/get_student_fee_view_model.dart';
import 'ViewModel/FeeVM/save_fee_view_model.dart';
import 'ViewModel/NewsVM/news_view_model.dart';
import 'widget/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = await SharedPreferences.getInstance();

  // Reading values
  int isFirstTime = prefs.getInt('isFirstTime') ?? 1;
  int? userId = prefs.getInt('user_id');

  // TERMINAL LOGS for verification
  debugPrint("-----------------------------------------");
  debugPrint("CHECKING ROUTE: userId=$userId, isFirstTime=$isFirstTime");
  debugPrint("-----------------------------------------");

  runApp(MyApp(
    isFirstTime: isFirstTime,
    userId: userId,
  ));
}

class MyApp extends StatelessWidget {
  final int isFirstTime;
  final int? userId;

  const MyApp({super.key, required this.isFirstTime, required this.userId});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SendLoginViewModel()),
        ChangeNotifierProvider(create: (_) => StudentFeeViewModel()),
        ChangeNotifierProvider(create: (_) => SaveFeeViewModel()),
        ChangeNotifierProvider(create: (_) => NewsViewModel()),
        ChangeNotifierProvider(create: (_) => StudentDetailViewModel()),
        ChangeNotifierProvider(create: (_) => ChangePasswordViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'School Management',
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        home: _getHome(),
      ),
    );
  }

  Widget _getHome() {
    // 1. If user is logged in, ALWAYS go to Dashboard
    if (userId != null && userId != 0) {
      return const DashboardScreen();
    }

    // 2. If not logged in and it's the first time, show Splash/Onboarding
    if (isFirstTime == 1) {
      return const SplashScreen();
    }

    // 3. Otherwise, go to Login
    return const LoginScreen();
  }
}