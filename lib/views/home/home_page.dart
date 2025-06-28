import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
import 'package:lead_manager/view_models/access_view_model.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String greetingMessage;
  Timer? _greetingTimer;

  final List<String> greetings = [
    "Keep pushing forward!",
    "Every lead is a new opportunity.",
    "Wishing you a successful day!",
    "You’re one follow-up away from a win.",
    "Consistency beats talent.",
    "Today is a great day to grow your leads!",
    "Little progress each day adds up to big results.",
  ];

  @override
  void initState() {
    super.initState();
    greetingMessage = _getRandomGreeting();

    _greetingTimer = Timer.periodic(const Duration(seconds: 4), (_) {
      setState(() {
        greetingMessage = _getRandomGreeting();
      });
    });
  }

  String _getRandomGreeting() {
    final random = Random();
    return greetings[random.nextInt(greetings.length)];
  }

  @override
  void dispose() {
    _greetingTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.secondaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 160,
        backgroundColor: AppColors.secondaryColor,
        elevation: 0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                /// Top row: Greeting + Notification + Avatar
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// Greeting section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Hello 👋",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Sajidh Shaji",
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    /// Notification + Avatar
                    Row(
                      children: [
                        Icon(Icons.notifications_none,
                            color: Colors.white, size: 28),
                        SizedBox(width: 12),
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child:
                              Icon(Icons.person, color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 600),
                    transitionBuilder: (child, animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.0, 0.3),
                          end: Offset.zero,
                        ).animate(animation),
                        child: FadeTransition(opacity: animation, child: child),
                      );
                    },
                    child: Text(
                      greetingMessage,
                      key: ValueKey(greetingMessage),
                      style: const TextStyle(
                        color: AppColors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          const Text("Welcome to home page"),
          Consumer<AccessViewModel>(builder: (context, provider, child) {
            return InkWell(
              onTap: () {
                provider.isLogout();
              },
              child: Container(
                height: 30,
                width: 100,
                color: AppColors.red,
              ),
            );
          })
        ],
      ),
    );
  }
}
