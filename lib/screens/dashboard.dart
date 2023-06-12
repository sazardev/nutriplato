import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/widgets/dashboard/aprende.dart';
import 'package:nutriplato/widgets/dashboard/articulos.dart';
import 'package:nutriplato/widgets/dashboard/exercises.dart';
import 'package:nutriplato/widgets/dashboard/contact.dart';

import '../models/user.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  User user = User(username: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    user.loadUser().then((value) {
      setState(() {
        user = value;
      });
    });

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          toolbarHeight: 60,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          title: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const Text('Buen dia, ',
                    style: TextStyle(
                      fontSize: 18,
                    )),
                Text(
                  user.name,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return const Dialog(
                              child: Contact(),
                            );
                          });
                    },
                    icon: const Icon(
                      FontAwesomeIcons.addressCard,
                    ))
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [Articles(), ExercisesNews(), Learn()],
            ),
          ),
        ),
      );
    });
  }
}
