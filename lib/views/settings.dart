import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider/providers/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    //
    final TextStyle title = TextStyle(
      fontFamily: 'fancy',
      fontSize: 40,
      color: Theme.of(context).colorScheme.secondary,
      decoration: TextDecoration.underline,
      decorationColor: Theme.of(context).colorScheme.secondary,
    );

//
    final TextStyle todoText = TextStyle(
      fontFamily: 'fancy',
      fontSize: 30,
      color: Theme.of(context).colorScheme.secondary,
    );

    final listen = Provider.of<TodoProvider>(context).theme;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(
          'Settings',
          style: title,
        ),
        centerTitle: true,
        leadingWidth: 60,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Theme.of(context).colorScheme.secondary,
            )),
      ),
      body: ValueListenableBuilder(
          valueListenable: listen.listenable(),
          builder: (context, box, child) {
            final data = box.get('isDark', defaultValue: false);
            return Column(
              children: [
                Container(
                  color: Theme.of(context).colorScheme.primary,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: ListTile(
                    onTap: () {
                      box.put('isDark', !data);
                    },
                    title: Text(
                      'Theme',
                      style: todoText,
                    ),
                    trailing: Switch(
                        activeTrackColor:
                            const Color.fromARGB(255, 129, 78, 138),
                        focusColor: Theme.of(context).colorScheme.secondary,
                        activeColor: Theme.of(context).colorScheme.secondary,
                        value: !data,
                        onChanged: (_) {
                          box.put('isDark', !data);
                        }),
                  ),
                ),
                Container(
                  color: Theme.of(context).colorScheme.primary,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: ListTile(
                    onTap: () async {
                      String url = "https://obaloluwaobi.github.io/socials/";
                      if (!await launchUrlString(url)) {
                        throw Exception('Could not launch $url');
                      }
                    },
                    title: Text(
                      'About Developer',
                      style: todoText,
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }
}
