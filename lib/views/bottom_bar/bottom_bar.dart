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

class _BottomBarState extends State<BottomBar> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late PageController _pageController;

  final List<Widget> _pages = const [
    HomePage(),
    LeadPage(),
    InterviewPage(),
    ProfilePage(),
  ];

  late AnimationController _bounceController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0.0,
      upperBound: 0.2,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _bounceController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);

    _bounceController.forward().then((_) => _bounceController.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
          _pageController.jumpToPage(0);
          return false; // prevent default pop (exit app)
        }
        return true; // allow exit if already on Home
      },
      child: Scaffold(
        backgroundColor: AppColors.secondaryColor,
        body: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _selectedIndex = index);
              },
              children: _pages,
            ),

            /// Custom Bottom Navigation Bar
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                height: 70,
                child: Stack(
                  children: [
                    /// Curved Background
                    Center(
                      child: Container(
                        height: 60,
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(4, (index) {
                            final icons = [
                              Icons.home,
                              Icons.assignment,
                              Icons.calendar_today,
                              Icons.person,
                            ];
                            final isSelected = _selectedIndex == index;

                            return GestureDetector(
                              onTap: () => _onItemTapped(index),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeOutQuad,
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? AppColors.primaryColor.withOpacity(0.1)
                                      : Colors.transparent,
                                  shape: BoxShape.circle,
                                ),
                                child: ScaleTransition(
                                  scale: isSelected
                                      ? Tween(begin: 1.0, end: 1.3)
                                          .animate(CurvedAnimation(
                                          parent: _bounceController,
                                          curve: Curves.easeOutBack,
                                        ))
                                      : const AlwaysStoppedAnimation(1.0),
                                  child: Icon(
                                    icons[index],
                                    color: isSelected
                                        ? AppColors.primaryColor
                                        : AppColors.grey,
                                    size: 28,
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
