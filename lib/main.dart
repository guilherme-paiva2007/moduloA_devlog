import 'package:flutter/material.dart';
import 'package:modulo_a_devlog/core/constants/colors.dart';
import 'package:modulo_a_devlog/core/navigation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

AppRouter? router;

void main() async {
  usePathUrlStrategy();

  await Supabase.initialize(
    url: 'https://zlbbwzrffgahmtjdgqbo.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InpsYmJ3enJmZmdhaG10amRncWJvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjEyMzYwNjksImV4cCI6MjA3NjgxMjA2OX0.E6KFLa2GuFYn1GvPIM4AQi3XruuU4sp2OlQ5WjPMIZ4',
    authOptions: const FlutterAuthClientOptions(
      authFlowType: AuthFlowType.pkce,
    ),
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({ super.key });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.blue),
      ),
      routerConfig:
        router?.router ??
        (router = AppRoutes.createRouter(Supabase.instance.client.auth.currentSession != null)).router,
      debugShowCheckedModeBanner: false,
    );
  }
}
