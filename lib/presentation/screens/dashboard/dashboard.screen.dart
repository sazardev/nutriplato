import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:nutriplato/fitness/fitness.controller.dart';
import 'package:nutriplato/fitness/shared/fitness-popular.widget.dart';
import 'package:nutriplato/presentation/provider/user_provider.dart';
import 'package:nutriplato/presentation/screens/dashboard/widgets/learn_screen.dart';
import 'package:nutriplato/presentation/screens/widgets/contact.dart';
import 'package:nutriplato/presentation/screens/widgets/sidebar.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final listedExercises = Get.find<FitnessController>().listedExercises;

  @override
  Widget build(BuildContext context) {
    String user = context.watch<UserProvider>().user.username;

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        drawer: const DrawerProfile(),
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          toolbarHeight: 60,
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
                PopularExercisesScreen(),
                LearnScreen(),
              ],
            ),
          ),
        ),
      );
    });
  }
}
