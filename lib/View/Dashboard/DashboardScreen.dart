import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project_x/Resources/Colors/Colors.dart';
import 'package:project_x/View/Form/Form.dart';
import 'package:project_x/View/Home/HomeScreen.dart';
import '../../Resources/Reusable Widgets/Sizing of Screen.dart';
import '../../View_model/Controllers/DashboardController.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final DashboardController controller = Get.put(DashboardController());

  final List<Widget> _screens = [
    HomeScreen(),
    FormFilling(),
  ];

  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.home, 'label': 'Dashboard'},
    {'icon': Icons.description, 'label': 'Form'},
  ];

  Widget buildSidebar(bool isDrawer, BuildContext context) {
    return Obx(() {
      final isCollapsed = controller.isSidebarCollapsed.value;

      return AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isDrawer
            ? SizingConfig.width(0.6)
            : isCollapsed
            ? 60
            : SizingConfig.width(0.18),
        color: AppColors.backgroundColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isCollapsed || isDrawer)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizingConfig.width(0.01)),
                  child: Image.asset(
                    'Assets/images/webkit-image-2.png',
                    height: isDrawer
                        ? (MediaQuery.of(context).size.width < 600 ? 70 : 55)
                        : 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            SizedBox(height: SizingConfig.height(0.04)),
            if (!isCollapsed || isDrawer)
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
              return Obx(() {
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
                      mainAxisAlignment: controller.isSidebarCollapsed.value && !isDrawer
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: [
                        Icon(
                          menuItems[index]['icon'],
                          size: 20,
                          color: isSelected ? AppColors.primaryColor : AppColors.textColor,
                        ),
                        if (!controller.isSidebarCollapsed.value || isDrawer) ...[
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
                        ]
                      ],
                    ),
                  ),
                );
              });
            }),
          ],
        ),
      );
    });
  }

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
        child: Obx(() {
          final isCollapsed = controller.isSidebarCollapsed.value;

          return Container(
            color: AppColors.backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // 👇 dynamically align the hamburger with sidebar width
                SizedBox(width: isCollapsed ? 60 : SizingConfig.width(0.18)),
                Builder(
                  builder: (context) => IconButton(
                    icon: Icon(Icons.menu, color: AppColors.textColor),
                    onPressed: () {
                      if (showDrawer) {
                        Scaffold.of(context).openDrawer();
                      } else {
                        controller.toggleSidebar();
                      }
                    },
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: PopupMenuButton<String>(
                    onSelected: (value) {
                      // handle signout etc.
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
                          width: 3,
                        ),
                      ),
                      child: const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/Pic.png'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ),
      drawer: showDrawer ? Drawer(child: SafeArea(child: buildSidebar(true, context))) : null,
      body: Row(
        children: [
          if (!showDrawer) buildSidebar(false, context),
          Expanded(
            child: Obx(() => _screens[controller.selectedIndex.value]),
          ),
        ],
      ),
    );
  }
}
