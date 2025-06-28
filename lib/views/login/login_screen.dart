import 'package:flutter/material.dart';
import 'package:lead_manager/core/utils/app_assets.dart';
import 'package:lead_manager/core/utils/app_colors.dart';
import 'package:lead_manager/views/login/widgets/icon_widget.dart';
import 'package:lead_manager/views/login/widgets/login_button_widget.dart';
import 'package:lead_manager/views/login/widgets/text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscurePassword = true;
  late TextEditingController emailIdTextcontroller;
  late TextEditingController passwordTextcontroller;

  @override
  void initState() {
    super.initState();
    emailIdTextcontroller = TextEditingController();
    passwordTextcontroller = TextEditingController();
  }

  @override
  void dispose() {
    emailIdTextcontroller.dispose();
    passwordTextcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 110),
                Center(
                  child: RichText(
                    text: const TextSpan(
                      text: 'Login to ',
                      style: TextStyle(
                        fontSize: 23,
                        color: AppColors.black,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        TextSpan(
                          text: ' Lead Manager',
                          style: TextStyle(
                            fontSize: 23,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                textWidget("We're happy to see you back here"),
                const SizedBox(height: 30),
                Align(
                  alignment: Alignment.centerLeft,
                  child: textWidget("Email"),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: emailIdTextcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    hintText: "Email",
                    hintStyle: const TextStyle(color: AppColors.grey),

                    // When enabled but not focused
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.grey, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    // When focusedsdfd
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),

                    // Default border (fallback)
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: textWidget("Password"),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  obscureText: _obscurePassword,
                  controller: passwordTextcontroller,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    hintText: "Password",
                    hintStyle: const TextStyle(color: AppColors.grey),

                    // Eye Icon for show/hide
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: AppColors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),

                    // Border styling
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: AppColors.grey, width: 1.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.primaryColor, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: AppColors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                LoginButtonWidget(
                  text: "Login",
                  onPressed: () {
                    print("hiajijdif");
                  },
                  loading: false,
                  formKey: formKey,
                ),
                const SizedBox(height: 30),
                textWidget("Or login with"),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconWidget(
                      text: "Facebook",
                      img: AppAssets.facebookIcon,
                    ),
                    IconWidget(
                      text: "Google",
                      img: AppAssets.googleIcon,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
