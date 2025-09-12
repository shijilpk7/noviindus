import 'package:flutter/material.dart';
import 'package:noviindus/services/api_service/api_repository.dart';
import 'package:noviindus/services/local_db/hive_local.dart';
import 'package:noviindus/utils/app_constants.dart';
import 'package:noviindus/utils/app_theme.dart';
import 'package:noviindus/view_models/login_viewmodel.dart';
import 'package:noviindus/view_models/patient_viewmodel.dart';
import 'package:noviindus/views/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  hiveInstance = await HiveLocal.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providerList(),
      child: MaterialApp(
        title: 'Login App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        home: const SplashScreen(),
      ),
    );
  }
}

//============= provider list =============
List<SingleChildWidget> providerList() {
  return [
    ChangeNotifierProvider(
      create: (_) => LoginViewModel(apiRepository: ApiRepository()),
    ),
    ChangeNotifierProvider(
      create: (_) => PatientViewmodel(apiRepository: ApiRepository()),
    ),
  ];
}
