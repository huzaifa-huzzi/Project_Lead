import 'package:flutter/material.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import 'package:project_x/View/Form/Form.dart';
import 'package:project_x/View/Home/HomeScreen.dart';
import '../../Resources/Reusable Widgets/Sizing of Screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    FormFilling(),
  ];

  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.home, 'label': 'Dashboard'},
    {'icon': Icons.description, 'label': 'Form'},
  ];

  Widget buildSidebar(bool isDrawer, BuildContext context) {
    return Container(
      width: isDrawer ? SizingConfig.width(0.6) : SizingConfig.width(0.18),
      color: AppColors.backgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizingConfig.width(0.03),
              vertical: SizingConfig.height(0.03),
            ),
            child: Row(
              children: [
                const Icon(Icons.diamond, color: AppColors.textColor, size: 26),
                SizedBox(width: SizingConfig.width(0.015)),
                const Text(
                  "Webkit",
                  style: TextStyle(
                    color: AppColors.textColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: SizingConfig.width(0.03)),
            child: const Text(
              "DASHBOARD",
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2,
              ),
            ),
          ),
          SizedBox(height: SizingConfig.height(0.01)),
          ...List.generate(menuItems.length, (index) {
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                if (isDrawer) Navigator.pop(context); // close drawer
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: SizingConfig.width(0.02),
                  vertical: SizingConfig.height(0.01),
                ),
                padding: EdgeInsets.symmetric(
                  horizontal: SizingConfig.width(0.03),
                  vertical: SizingConfig.height(0.018),
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.secondaryColor.withOpacity(0.15)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      menuItems[index]['icon'],
                      size: 20,
                      color: isSelected
                          ? AppColors.primaryColor
                          : AppColors.textColor,
                    ),
                    SizedBox(width: SizingConfig.width(0.015)),
                    Flexible(
                      child: Text(
                        menuItems[index]['label'],
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.primaryColor
                              : AppColors.textColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    final bool showDrawer = isMobile || isTablet;

    SizingConfig.init(context);

    return Scaffold(
      appBar: showDrawer
          ? AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        title: const Text("Webkit",
            style: TextStyle(color: AppColors.textColor)),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: AppColors.textColor),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      )
          : null,

      drawer: showDrawer ? Drawer(child: SafeArea(child: buildSidebar(true, context))) : null,

      body: Row(
        children: [
          if (!showDrawer) buildSidebar(false, context),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),
    );
  }
}
