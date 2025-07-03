import 'package:flutter/material.dart';
import 'package:leadmanager/core/utils/app_assets.dart';
import 'package:leadmanager/core/utils/app_colors.dart';
import 'package:leadmanager/view_models/login_view_model.dart';
import 'package:leadmanager/views/login/widgets/icon_widget.dart';
import 'package:leadmanager/views/login/widgets/login_button_widget.dart';
import 'package:leadmanager/widgets/custom_text_widget.dart';
import 'package:provider/provider.dart';

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
    final loginProvider = Provider.of<LoginViewModel>(context);
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App Branding
                  const SizedBox(height: 30),
                  Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                        text: 'Welcome to\n',
                        style: TextStyle(
                          fontSize: 22,
                          color: AppColors.black,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: 'Lead Manager',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  textWidget("Log in to manage your leads effectively."),
                  const SizedBox(height: 40),

                  // Email Input
                  Align(
                    alignment: Alignment.centerLeft,
                    child: textWidget("Email"),
                  ),
                  const SizedBox(height: 6),
                  _buildInputField(
                    controller: emailIdTextcontroller,
                    hint: "Enter your email",
                    validatorText: "Email is required",
                  ),
                  const SizedBox(height: 20),

                  // Password Input
                  Align(
                    alignment: Alignment.centerLeft,
                    child: textWidget("Password"),
                  ),
                  const SizedBox(height: 6),
                  _buildInputField(
                    controller: passwordTextcontroller,
                    hint: "Enter your password",
                    isPassword: true,
                    obscureText: _obscurePassword,
                    toggleObscure: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    validatorText: "Password is required",
                  ),

                  const SizedBox(height: 25),
                  LoginButtonWidget(
                    text: "Login",
                    onPressed: () {
                      loginProvider.userLogin(
                        emailIdTextcontroller.text,
                        passwordTextcontroller.text,
                        context,
                      );
                    },
                    loading: loginProvider.isLoading,
                    formKey: formKey,
                  ),

                  const SizedBox(height: 30),
                  textWidget("Or sign in with"),
                  const SizedBox(height: 20),

                  // Social Logins
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Facebook login is not available right now."),
                              backgroundColor: AppColors.redAccent,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const IconWidget(
                          text: "Facebook",
                          img: AppAssets.facebookIcon,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Google login is not available right now."),
                              backgroundColor: AppColors.redAccent,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        },
                        child: const IconWidget(
                          text: "Google",
                          img: AppAssets.googleIcon,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hint,
    required String validatorText,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? toggleObscure,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) {
        if (value == null || value.trim().isEmpty) return validatorText;
        return null;
      },
      decoration: InputDecoration(
        hintText: hint,
        filled: true,
        fillColor: AppColors.white,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.grey,
                ),
                onPressed: toggleObscure,
              )
            : null,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
        ),
      ),
    );
  }
}
