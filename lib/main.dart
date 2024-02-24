import 'package:counter_tasbeeh/provider/tasbeeh_counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data_manager/data_manager.dart';
import 'screens/Home_Page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DataManager.loadData();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>TasbeehCounterProvider(),
      child: MaterialApp(
        // theme: ThemeData(
        //     brightness: Brightness.light,
        //     primarySwatch: Colors.blue),
        home:HomePage(),
      ),
    );
  }
}


