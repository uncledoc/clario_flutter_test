import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:test_project/ui/screen/home/screen.dart';
import 'package:test_project/ui/theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late Future fonts;

  @override
  void initState() {
    fonts = GoogleFonts.pendingFonts([GoogleFonts.inter()]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.buildTheme();
    return FutureBuilder(
      future: fonts,
      builder: (context, snapshot) {
        // only for development
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox.shrink();
        }
        return MaterialApp(
          title: 'Flutter Demo',
          theme: theme.copyWith(
            textTheme: GoogleFonts.interTextTheme(theme.textTheme),
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
