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

  /// Screens
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

  /// Navbars data
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.home, 'label': 'Dashboard'},
    {'icon': Icons.description, 'label': 'Form'},
  ];

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    SizingConfig.init(context);

    return Scaffold(
      body: Row(
        children: [
          /// Logo
          if (!isMobile)
            Container(
              width: 200,
              color: AppColors.primaryColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Row(
                      children: [
                        const Icon(Icons.work, color: Colors.white, size: 32),
                        SizedBox(width: SizingConfig.width(0.02)),
                        const Text(
                          "Lead",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ///  Nav for web
                  SizedBox(height: SizingConfig.height(0.02)),
                  ...List.generate(menuItems.length, (index) {
                    final isSelected = _selectedIndex == index;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              menuItems[index]['icon'],
                              color: isSelected ? AppColors.primaryColor : Colors.white,
                            ),
                            SizedBox(width: SizingConfig.width(0.02)),
                            Text(
                              menuItems[index]['label'],
                              style: TextStyle(
                                color: isSelected ? AppColors.primaryColor : Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          Expanded(child: _screens[_selectedIndex]),
        ],
      ),

      ///  Nav for Mobile
      bottomNavigationBar: isMobile
          ? Container(
        color: AppColors.primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(menuItems.length, (index) {
            final isSelected = _selectedIndex == index;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      menuItems[index]['icon'],
                      color: isSelected ? AppColors.primaryColor : Colors.white,
                    ),
                     SizedBox(height: SizingConfig.height(0.02) ),
                    Text(
                      menuItems[index]['label'],
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.primaryColor : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      )
          : null,
    );
  }
}
