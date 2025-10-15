import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/homework_bloc.dart';
import 'pages/homework_list_page.dart';
import 'pages/add_homework_page.dart';

void main() {
  runApp(const HomeworkApp());
}

class HomeworkApp extends StatelessWidget {
  const HomeworkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeworkBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Homework Tracker',
        theme: ThemeData(
          colorSchemeSeed: Colors.deepPurple,
          useMaterial3: true,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          ),
        ),
        initialRoute: '/00list',
        routes: {
          '/00list': (context) => const HomeworkListPage(),
          '/00add': (context) => const AddHomeworkPage(),
        },
      ),
    );
  }
}
