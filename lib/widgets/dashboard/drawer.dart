import 'dart:convert';
import 'dart:io';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';
import 'package:nutriplato/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerProfile extends StatefulWidget {
  const DrawerProfile({super.key});

  @override
  State<DrawerProfile> createState() => _DrawerProfileState();
}

class _DrawerProfileState extends State<DrawerProfile> {
  User user = User(username: '');
  bool editMode = false;

  @override
  void initState() {
    super.initState();
    user.loadUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userString = jsonEncode(user.toJson());
    await prefs.setString('user', userString);
  }

  Widget showCard(String number, String title) {
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

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 230,
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
                          onPressed: () async {
                            setState(() {
                              if (editMode) {
                                editMode = false;
                              } else {
                                editMode = true;
                              }
                            });
                            await saveUser(user);
                          },
                          icon: Icon(
                            editMode ? Icons.done : Icons.edit,
                            color: Colors.white,
                          )),
                    ],
                  ),
                  CircleAvatar(
                    radius: 50,
                    child: editMode
                        ? IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.add,
                              size: 50,
                            ))
                        : user.image ??
                            const Icon(
                              Icons.person,
                              size: 50,
                            ),
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
                            controller: TextEditingController(text: user.name),
                            onSubmitted: (value) async {
                              setState(() {
                                user.name = value;
                              });
                              await saveUser(user);
                            },
                          ),
                        )
                      : Text(
                          user.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                ],
              ),
            ),
          ),
          /*
          showCard('${user.exercisesCompleted}', 'Ejercicios completados'),
          Row(
            children: [
              Expanded(
                  child: showCard('${user.blogsReaded}', 'Noticias leidas')),
              Expanded(
                  child: showCard('${user.viewedFoods}', 'Alimentos vistos')),
            ],
          ),
          */
          ListTile(
            leading: const Icon(Icons.balance),
            title: const Text('Terminos y condiciones'),
            onTap: () async {
              if (Platform.isAndroid) {
                const url = 'https://www.buymeacoffee.com/sazarcode';
                const intent = AndroidIntent(
                  action: 'action_view',
                  data: url,
                );
                intent.launch();
              }
            },
          ),
        ],
      ),
    );
  }
}
