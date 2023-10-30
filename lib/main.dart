import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:skp_port/generated/l10n.dart';
import 'package:skp_port/di/injection.dart' as di;
import 'package:skp_port/presentation/widgets/custom_route.dart';
import 'package:skp_port/presentation/screens/home/home_screen.dart';
import 'package:skp_port/presentation/providers/layout_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  await Firebase.initializeApp();
  await di.configure();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final layoutType = ref.watch(layoutProvider(context));

    return ScreenUtilInit(
      builder: (context, _) => const _PortfolioMain(),
      minTextAdapt: true,
      designSize: switch (layoutType) {
        LayoutType.mobile => const Size(360, 640),
        LayoutType.tablet => const Size(768, 1024),
        _ => const Size(1280, 720),
      },
    );
  }
}

class _PortfolioMain extends StatelessWidget {
  const _PortfolioMain();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Solinkp Portfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      onGenerateTitle: (context) => S.current.appTitle,
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: const Locale('es'),
      initialRoute: '/',
      onUnknownRoute: (settings) => CustomRoute().fade(const HomeScreen()),
      routes: {
        '/': (context) => const HomeScreen(),
      },
    );
  }
}
