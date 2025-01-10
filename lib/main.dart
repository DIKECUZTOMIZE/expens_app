import 'package:exoenseapp/data/local/dbHelper.dart';
import 'package:exoenseapp/ui/bloc/expens_bloc.dart';
import 'package:exoenseapp/ui/provider/provider_filse.dart';
import 'package:exoenseapp/ui/splashPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(BlocProvider(
      create: (context) => ExpensBloc(dbHelper: DbHelper.getInstance()),
      child: ChangeNotifierProvider(
          create: (context) => ProviderFilse(), child: App())));
}

class App extends StatefulWidget {
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();

    getThems();
    setState(() {});
  }

  getThems() async {
    var prefs = await SharedPreferences.getInstance();
    bool uid = prefs.getBool('Thems') ?? false;

    if (uid) {
      context.read<ProviderFilse>().darkThems(true);
    } else {
      context.read<ProviderFilse>().lightThem();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: context.watch<ProviderFilse>().lightThem()
          ? ThemeMode.dark
          : ThemeMode.light,

      darkTheme: ThemeData(
        brightness: Brightness.dark
      ),
      theme: ThemeData(
        brightness: Brightness.light
      ),
      home: SplashPage(),
    );
  }
}
