import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/presentation/provider/user_provider.dart';
import 'package:nutriplato/presentation/screens/dashboard/widgets/aprende.dart';
import 'package:nutriplato/presentation/screens/dashboard/widgets/articulos.dart';
import 'package:nutriplato/presentation/screens/dashboard/widgets/exercises.dart';
import 'package:nutriplato/presentation/screens/dashboard/widgets/contact.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    String user = context.watch<UserProvider>().username;
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
                  user,
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
        body: const SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Articles(),
                ExercisesNews(),
                Learn(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
