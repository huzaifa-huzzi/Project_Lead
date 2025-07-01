import 'package:flutter/material.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import 'package:project_x/View/Form/Form.dart';

import '../../Resources/Reusable Widgets/Sizing of Screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Container(
      color: const Color(0xFFF9FAFB),
      alignment: Alignment.center,
      child: const Text(
        'Home',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Color(0xFF1F2937),
        ),
      ),
    ),
    const FormFilling(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    SizingConfig.init(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lead',
          style: TextStyle(
            fontSize: 24,
            color: AppColors.surfaceColor,
            fontFamily: 'sans-Serif',
          ),
        ),
        backgroundColor: const Color(0xFF1E3A8A),
        automaticallyImplyLeading: false,
      ),
      body: Row(
        children: [
          if (!isMobile)
            NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              backgroundColor: AppColors.surfaceColor,
              selectedIconTheme: IconThemeData(color: AppColors.primaryColor),
              unselectedIconTheme: IconThemeData(color: Colors.grey[300]),
              selectedLabelTextStyle: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelTextStyle: const TextStyle(color: Colors.white60),
              destinations:  [
                NavigationRailDestination(
                  icon: Column(
                    children: [
                      Icon(Icons.home),
                    ],
                  ),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Column(
                    children: [
                      Icon(Icons.description),
                    ],
                  ),
                  label: Text('Form'),
                ),
              ],
            ),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: isMobile
          ? BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (int index) => setState(() => _selectedIndex = index),
        selectedItemColor: AppColors.primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.description),
            label: 'Form',
          ),
        ],
      )
          : null,
    );
  }
}
