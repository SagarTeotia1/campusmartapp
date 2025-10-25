import 'package:flutter/material.dart';
import '../../../../app/theme.dart';
import '../widgets/phone_input_field.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  late AnimationController _animationController;
  late AnimationController _logoAnimationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;
  
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
    ));

    _scaleAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.elasticOut,
    ));

    _rotateAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.easeInOut,
    ));

    _logoAnimationController.forward();
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _logoAnimationController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    if (value.length < 10) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() {
          _isLoading = false;
        });

        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

  void _navigateToRegistration() {
    Navigator.of(context).pushNamed('/registration');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.height < 700;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            // Background Gradient Decoration
            Positioned(
              top: -100,
              right: -100,
              child: Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor.withValues(alpha: 0.1),
                      AppTheme.accentColor.withValues(alpha: 0.05),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: -150,
              left: -150,
              child: Container(
                width: 350,
                height: 350,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.accentColor.withValues(alpha: 0.08),
                      AppTheme.primaryColor.withValues(alpha: 0.03),
                    ],
                  ),
                ),
              ),
            ),
            
            // Main Content
            SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: isSmallScreen ? 20 : 40,
              ),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: SlideTransition(
                      position: _slideAnimation,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: isSmallScreen ? 20 : 40),
                          
                          // Logo Section with Animation
                          Center(
                            child: AnimatedBuilder(
                              animation: _logoAnimationController,
                              builder: (context, child) {
                                return Transform.scale(
                                  scale: _scaleAnimation.value,
                                  child: Transform.rotate(
                                    angle: _rotateAnimation.value * 0.1,
                                    child: Container(
                                      width: isSmallScreen ? 90 : 110,
                                      height: isSmallScreen ? 90 : 110,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            AppTheme.primaryColor,
                                            AppTheme.accentColor,
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppTheme.primaryColor.withValues(alpha: 0.4),
                                            blurRadius: 30,
                                            spreadRadius: 0,
                                            offset: const Offset(0, 10),
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        Icons.shopping_bag_rounded,
                                        size: isSmallScreen ? 45 : 55,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          
                          SizedBox(height: isSmallScreen ? 28 : 40),
                          
                          // Welcome Text Section
                          Column(
                            children: [
                              Text(
                                'Welcome Back',
                                style: TextStyle(
                                  fontSize: isSmallScreen ? 28 : 34,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF1A1A1A),
                                  letterSpacing: -0.5,
                                  height: 1.2,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 12),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  'Sign in to continue your shopping experience',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          
                          SizedBox(height: isSmallScreen ? 40 : 56),
                          
                          // Login Form Card
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.04),
                                  blurRadius: 20,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(24),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Text(
                                    'Phone Number',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey.shade700,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  PhoneInputField(
                                    controller: _phoneController,
                                    validator: _validatePhoneNumber,
                                  ),
                                  
                                  const SizedBox(height: 28),
                                  
                                  // Login Button with Gradient
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      gradient: const LinearGradient(
                                        colors: [
                                          AppTheme.primaryColor,
                                          AppTheme.accentColor,
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.primaryColor.withValues(alpha: 0.3),
                                          blurRadius: 16,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: ElevatedButton(
                                      onPressed: _isLoading ? null : _handleLogin,
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        shadowColor: Colors.transparent,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(vertical: 18),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        elevation: 0,
                                      ),
                                      child: _isLoading
                                        ? const SizedBox(
                                            height: 22,
                                            width: 22,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2.5,
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                            ),
                                          )
                                        : Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                'Continue with OTP',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  letterSpacing: 0.5,
                                                ),
                                              ),
                                              const SizedBox(width: 8),
                                              const Icon(
                                                Icons.arrow_forward_rounded,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          SizedBox(height: isSmallScreen ? 32 : 40),
                          
                          // // Divider with Text
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Container(
                          //         height: 1,
                          //         color: Colors.grey.shade200,
                          //       ),
                          //     ),
                          //     Padding(
                          //       padding: const EdgeInsets.symmetric(horizontal: 20),
                          //       child: Text(
                          //         'or',
                          //         style: TextStyle(
                          //           fontSize: 13,
                          //           color: Colors.grey.shade500,
                          //           fontWeight: FontWeight.w500,
                          //           letterSpacing: 0.5,
                          //         ),
                          //       ),
                          //     ),
                          //     Expanded(
                          //       child: Container(
                          //         height: 1,
                          //         color: Colors.grey.shade200,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          
                          // SizedBox(height: isSmallScreen ? 28 : 36),
                          
                          // // Create Account Button
                          // OutlinedButton(
                          //   onPressed: _navigateToRegistration,
                          //   style: OutlinedButton.styleFrom(
                          //     foregroundColor: AppTheme.primaryColor,
                          //     side: BorderSide(
                          //       color: Colors.grey.shade300,
                          //       width: 1.5,
                          //     ),
                          //     padding: const EdgeInsets.symmetric(vertical: 18),
                          //     shape: RoundedRectangleBorder(
                          //       borderRadius: BorderRadius.circular(16),
                          //     ),
                          //     backgroundColor: Colors.grey.shade50,
                          //   ),
                          //   child: Row(
                          //     mainAxisAlignment: MainAxisAlignment.center,
                          //     children: [
                          //       Icon(
                          //         Icons.person_add_outlined,
                          //         size: 20,
                          //         color: Colors.grey.shade700,
                          //       ),
                          //       const SizedBox(width: 10),
                          //       Text(
                          //         'Create New Account',
                          //         style: TextStyle(
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.w600,
                          //           color: Colors.grey.shade700,
                          //           letterSpacing: 0.3,
                          //         ),
                          //       ),
                          //     ],
                          //   ),
                          // ),
                          
                          // SizedBox(height: isSmallScreen ? 28 : 40),
                          
                          // Terms and Privacy
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey.shade500,
                                  height: 1.6,
                                ),
                                children: [
                                  const TextSpan(
                                    text: 'By continuing, you agree to our ',
                                  ),
                                  TextSpan(
                                    text: 'Terms of Service',
                                    style: TextStyle(
                                      color: AppTheme.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const TextSpan(text: ' and '),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: TextStyle(
                                      color: AppTheme.primaryColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}