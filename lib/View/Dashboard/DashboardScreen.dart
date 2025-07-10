import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import 'package:project_x/View/Form/Form.dart';
import 'package:project_x/View/Home/HomeScreen.dart';
import 'package:project_x/View/Verify/VerifyScreen.dart';
import '../../Resources/Reusable Widgets/Sizing of Screen.dart';
import '../../View_model/Controllers/DashboardController.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController controller = Get.put(DashboardController());

  final List<Widget> _screens = [
    HomeScreen(),
    FormFilling(),
    VerifyScreen(),
  ];

  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.home, 'label': 'Dashboard'},
    {'icon': Icons.description, 'label': 'Form'},
    {'icon': Icons.verified_user ,'label' : 'Verify form'}
  ];

  Widget buildSidebar(bool isDrawer, BuildContext context, double screenWidth) {
    return Obx(() {
      return Container(
        width: isDrawer
            ? SizingConfig.width(0.6)
            : (screenWidth >= 1024 ? SizingConfig.width(0.22) : SizingConfig.width(0.18)),
        color: AppColors.sidebarColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Show logo only for tablet & mobile
            if (screenWidth < 1024)
              Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Center(
                  child: SizedBox(
                    height: 120,
                    width: 200,
                    child: Image.asset(
                      'Assets/images/webkit-image-2.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            SizedBox(height: SizingConfig.height(0.03)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: SizingConfig.width(0.03)),
              child: const Text(
                "DASHBOARD",
                style: TextStyle(
                  color: AppColors.sidebarTextColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: SizingConfig.height(0.01)),
            ...List.generate(menuItems.length, (index) {
              final isSelected = controller.selectedIndex.value == index;
              return GestureDetector(
                onTap: () {
                  controller.changeScreen(index);
                  if (isDrawer) Navigator.pop(context);
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
    });
  }

  /// AppBar Widgets
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    final bool showDrawer = isMobile || isTablet;

    SizingConfig.init(context);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: Container(
          color: AppColors.appBarColors,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              if (showDrawer)
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.menu, color: AppColors.textColor),
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                  ),
                ),
              // ✅ Logo only in AppBar for Web
              if (screenWidth >= 1024)
                Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Center(
                    child: SizedBox(
                      height: 100,
                      width: 200,
                      child: Image.asset(
                        'Assets/images/webkit-image-2.png',
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: PopupMenuButton<String>(
                  onSelected: (value) {
                    // handle signout
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem<String>(
                      value: 'signout',
                      child: Row(
                        children: [
                          Icon(Icons.logout, size: 18, color: Colors.black54),
                          SizedBox(width: SizingConfig.width(0.01)),
                          Text('Sign Out'),
                        ],
                      ),
                    ),
                  ],
                  child: Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Theme.of(context).primaryColor,
                        width: 2,
                      ),
                    ),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage('assets/images/Pic.png'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: showDrawer
          ? Drawer(
        child: SafeArea(
          child: buildSidebar(true, context, screenWidth),
        ),
      )
          : null,
      body: Row(
        children: [
          if (!showDrawer) buildSidebar(false, context, screenWidth),
          Expanded(
            child: Obx(() => _screens[controller.selectedIndex.value]),
          ),
        ],
      ),
    );
  }
}
