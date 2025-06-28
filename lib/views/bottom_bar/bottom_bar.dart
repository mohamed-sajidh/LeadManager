import 'package:flutter/material.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
import 'package:lead_manager/views/home/home_page.dart';
import 'package:lead_manager/views/interview/interview_page.dart';
import 'package:lead_manager/views/lead/lead_page.dart';
import 'package:lead_manager/views/profile/profile_page.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
  }

  static final List<Widget> _widgetOptions = <Widget>[
    const HomePage(),
    const LeadPage(),
    const InterviewPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 7,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (child, animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: _widgetOptions[_selectedIndex],
              ),
            ),
            Expanded(
              flex: 1,
              child: SizedBox(
                width: double.infinity,
                height: 60,
                child: BottomNavigationBar(
                  unselectedItemColor: AppColors.grey,
                  selectedFontSize: 12,
                  unselectedFontSize: 12,
                  items: List.generate(4, (index) {
                    final iconData = [
                      Icons.home,
                      Icons.production_quantity_limits,
                      Icons.settings,
                      Icons.person
                    ][index];
                    final label = ['Home', 'Leads', 'Interview', 'Profile'][index];

                    final isSelected = _selectedIndex == index;

                    return BottomNavigationBarItem(
                      icon: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeInOut,
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: isSelected ? AppColors.primaryColor.withOpacity(0.1) : Colors.transparent,
                          shape: BoxShape.circle,
                        ),
                        child: AnimatedScale(
                          scale: isSelected ? 1.2 : 1.0,
                          duration: const Duration(milliseconds: 200),
                          child: ColorFiltered(
                            colorFilter: ColorFilter.mode(
                              isSelected ? AppColors.primaryColor : AppColors.grey,
                              BlendMode.srcIn,
                            ),
                            child: Icon(iconData, size: 30),
                          ),
                        ),
                      ),
                      label: label,
                    );
                  }),
                  selectedLabelStyle: const TextStyle(
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.bold,
                  ),
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectedIndex,
                  selectedItemColor: AppColors.primaryColor,
                  backgroundColor: AppColors.white,
                  onTap: (int index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                  elevation: 5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
