import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:nutriplato/presentation/provider/user_provider.dart';
import 'package:nutriplato/presentation/screens/widgets/theme_changer_screen.dart';
import 'package:provider/provider.dart';

import '../../../infrastructure/entities/user.dart';

class DrawerProfile extends StatefulWidget {
  const DrawerProfile({super.key});

  @override
  State<DrawerProfile> createState() => _DrawerProfileState();
}

class _DrawerProfileState extends State<DrawerProfile> {
  List<String> routes = [
    ThemeChangerScreen.appRouterName,
  ];

  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: null,
      onDestinationSelected: (value) {
        if (value == routes.length) {
          showAboutDialog(context: context);
        } else if (value == routes.length + 1) {
          if (Platform.isAndroid) {
            const url =
                'https://github.com/CerberusProgrammer/nutriplato/blob/master/Pol%C3%ADtica%20de%20Privacidad%20-%20NutriPlato.pdf';
            const intent = AndroidIntent(
              action: 'action_view',
              data: url,
            );
            intent.launch();
          }
        } else {
          // TODO:
          // context.pushNamed(routes[value]);
        }
      },
      children: const [
        UserCard(),
        NavigationDrawerDestination(
          icon: Icon(Icons.brightness_7),
          label: Text('Cambiar tema'),
        ),
        Divider(),
        NavigationDrawerDestination(
          icon: Icon(Icons.pages),
          label: Text('Licencias'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.balance),
          label: Text('Terminos y Condiciones'),
        ),
      ],
    );
  }
}

class UserCard extends StatefulWidget {
  const UserCard({super.key});

  @override
  State<UserCard> createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    final User user = context.watch<UserProvider>().user;

    return SizedBox(
      height: 280,
      child: DrawerHeader(
        decoration: const BoxDecoration(
          color: Colors.purple,
        ),
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.white,
                    )),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      setState(() {
                        if (editMode) {
                          editMode = false;
                        } else {
                          editMode = true;
                        }
                      });
                      context.read<UserProvider>().saveUser(user);
                    },
                    icon: Icon(
                      editMode ? Icons.done : Icons.edit,
                      color: Colors.white,
                    )),
              ],
            ),
            CircleAvatar(
              radius: 70,
              child: Text(user.username),
            ),
            const SizedBox(
              height: 10,
            ),
            editMode
                ? SizedBox(
                    width: 200,
                    height: 40,
                    child: TextField(
                      textAlign: TextAlign.center,
                      cursorColor: Colors.white,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                      controller: TextEditingController(text: user.username),
                      onSubmitted: (value) {
                        user.username = value;
                        context.read<UserProvider>().saveUser(user);
                      },
                    ),
                  )
                : Text(
                    user.username,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
