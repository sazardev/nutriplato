import 'package:flutter/material.dart';
import 'package:nutriplato/screens/contact.dart';
import 'package:nutriplato/screens/plate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/screens/search.dart';

import 'screens/dashboard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  static late TabController controller;

  static const List<Widget> _tabs = [
    Tab(
      icon: FaIcon(FontAwesomeIcons.house),
      text: 'Inicio',
    ),
    Tab(
      icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
      text: 'Buscar',
    ),
    Tab(
      icon: FaIcon(FontAwesomeIcons.plateWheat),
      text: 'Plato',
    ),
    Tab(
      icon: FaIcon(FontAwesomeIcons.addressCard),
      text: 'Contacto',
    ),
  ];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = TabController(
      length: 4,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TabBarView(
          controller: controller,
          children: const [
            Dashboard(),
            Search(),
            Plate(),
            Contact(),
          ],
        ),
        bottomNavigationBar: Material(
            child: TabBar(
          tabs: _tabs,
          controller: controller,
        )),
      ),
    );
  }
}
