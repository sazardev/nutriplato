import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:nutriplato/screens/dashboard/provider/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:random_avatar/random_avatar.dart';

class DrawerProfile extends StatefulWidget {
  const DrawerProfile({super.key});

  @override
  State<DrawerProfile> createState() => _DrawerProfileState();
}

class _DrawerProfileState extends State<DrawerProfile> {
  @override
  Widget build(BuildContext context) {
    return NavigationDrawer(
      selectedIndex: null,
      onDestinationSelected: (value) {
        if (value == 0) {
          showAboutDialog(context: context);
        }
        if (value == 1) {
          if (Platform.isAndroid) {
            const url =
                'https://github.com/CerberusProgrammer/nutriplato/blob/master/Pol%C3%ADtica%20de%20Privacidad%20-%20NutriPlato.pdf';
            const intent = AndroidIntent(
              action: 'action_view',
              data: url,
            );
            intent.launch();
          }
        }
      },
      children: const [
        UserCard(),
        NavigationDrawerDestination(
          icon: Icon(Icons.pages),
          label: Text('Licencias'),
        ),
        NavigationDrawerDestination(
          icon: Icon(Icons.balance),
          label: Text('Terminos y condiciones'),
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
    String user = context.watch<UserProvider>().username;
    return Column(
      children: [
        SizedBox(
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
                  child: RandomAvatar(user),
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
                          controller: TextEditingController(text: user),
                          onSubmitted: (value) {
                            user = value;
                            context.read<UserProvider>().saveUser(value);
                          },
                        ),
                      )
                    : Text(
                        user,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class DisplayCard extends StatelessWidget {
  const DisplayCard({
    super.key,
    required this.number,
    required this.title,
  });

  final String number;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 8),
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                number,
                style: const TextStyle(fontSize: 32),
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 14),
              )
            ],
          ),
        ),
      ),
    );
  }
}
