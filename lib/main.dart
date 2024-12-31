import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/model/models.dart';
import 'package:todo_provider/providers/provider.dart';
import 'package:todo_provider/theme/theme.dart';
import 'package:todo_provider/utils/utils.dart';
import 'package:todo_provider/views/settings.dart';
import 'package:todo_provider/views/todopage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoModelAdapter());
  await Hive.openBox('todo');
  await Hive.openBox('theme');
  runApp(ChangeNotifierProvider<TodoProvider>(
    create: (context) => TodoProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final get = Provider.of<TodoProvider>(context).theme;

    return ValueListenableBuilder(
        valueListenable: get.listenable(),
        builder: (context, box, child) {
          final isDark = box.get('isDark', defaultValue: false);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            themeMode: isDark ? ThemeMode.light : ThemeMode.dark,
            darkTheme: darkMode,
            theme: lightMode,
            initialRoute: '/home',
            routes: {
              '/home': (context) => const TodoPage(),
              '/setting': (context) => const SettingsPage()
            },
          );
        });
  }
}
