import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../dashboard/dashboard_page.dart';
import '../../models/user_role.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  // Animation controllers
  late AnimationController _titleController;
  final List<Animation<Offset>> _wordOffsetAnimations = [];
  final List<Animation<double>> _wordScaleAnimations = [];

  final List<String> _titleWords = ['Smart', 'Bin', 'Monitoring', 'System'];

  @override
  void initState() {
    super.initState();

    // Initialize title animation
    _titleController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // Create separate animations for each word with different delays
    for (int i = 0; i < _titleWords.length; i++) {
      final delayedAnimation = CurvedAnimation(
        parent: _titleController,
        curve: Interval(
          i * 0.2, // Staggered start (20% interval between words)
          1.0,
          curve: Curves.elasticOut,
        ),
      );

      _wordOffsetAnimations.add(
        Tween<Offset>(
          begin: Offset.zero,
          end: Offset(0.0, -0.3), // Bounce upward
        ).animate(delayedAnimation),
      );

      _wordScaleAnimations.add(
        Tween<double>(
          begin: 1.0,
          end: 1.1, // Slight scale up during bounce
        ).animate(delayedAnimation),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final screenSize = MediaQuery.of(context).size;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade50,
              Colors.green.shade50,
              Colors.blue.shade100,
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenSize.height),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.all(screenSize.width * 0.05),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // App Logo/Icon (Responsive)
                    Container(
                      width: screenSize.width * 0.3,
                      height: screenSize.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.delete_outline,
                        size: screenSize.width * 0.15,
                        color: Colors.green,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.03),

                    // Animated Title with Bouncing Effect Per Word
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenSize.width * 0.02,
                        vertical: screenSize.height * 0.02,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15,
                            offset: Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: List.generate(_titleWords.length, (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenSize.width * 0.008,
                            ),
                            child: AnimatedBuilder(
                              animation: _titleController,
                              builder: (context, child) {
                                return Transform.translate(
                                  offset: _wordOffsetAnimations[index].value,
                                  child: Transform.scale(
                                    scale: _wordScaleAnimations[index].value,
                                    child: Text(
                                      _titleWords[index],
                                      style: TextStyle(
                                        fontSize: _getResponsiveFontSize(
                                          screenSize,
                                        ),
                                        fontWeight: FontWeight.bold,
                                        color: _getWordColor(index),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.04),

                    // Login Form Container
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(screenSize.width * 0.05),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 20,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                labelText: 'Email/Username',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: screenSize.height * 0.02,
                                ),
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                  ? 'Please enter your email'
                                  : null,
                            ),
                            SizedBox(height: screenSize.height * 0.02),
                            TextFormField(
                              controller: _passwordController,
                              obscureText: _obscurePassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _obscurePassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  onPressed: () => setState(
                                    () => _obscurePassword = !_obscurePassword,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 15,
                                  vertical: screenSize.height * 0.02,
                                ),
                              ),
                              validator: (value) =>
                                  value == null || value.isEmpty
                                  ? 'Please enter your password'
                                  : null,
                            ),
                            SizedBox(height: screenSize.height * 0.03),
                            authService.isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          await authService.login(
                                            _emailController.text,
                                            _passwordController.text,
                                          );

                                          final email = _emailController.text
                                              .trim();
                                          final role =
                                              email == 'admin@smartbin.com'
                                              ? UserRole.admin
                                              : UserRole.user;

                                          Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DashboardPage(
                                                    userName: email.split(
                                                      '@',
                                                    )[0],
                                                    email: email,
                                                  ),
                                            ),
                                          );
                                        } catch (e) {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text('Login failed: $e'),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                            ),
                                          );
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      minimumSize: Size(
                                        double.infinity,
                                        screenSize.height * 0.06,
                                      ),
                                      backgroundColor: Colors.green,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 5,
                                    ),
                                    child: Text(
                                      'Login',
                                      style: TextStyle(
                                        fontSize:
                                            _getResponsiveFontSize(screenSize) *
                                            0.8,
                                      ),
                                    ),
                                  ),
                            SizedBox(height: screenSize.height * 0.02),

                            // Demo Credentials
                            Container(
                              padding: EdgeInsets.all(screenSize.width * 0.03),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade50,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Let make our school smart and clean !',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          _getResponsiveFontSize(screenSize) *
                                          0.7,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'Together we can achieve a clean environment.',
                                    style: TextStyle(
                                      fontSize:
                                          _getResponsiveFontSize(screenSize) *
                                          0.6,
                                    ),
                                  ),
                                  Text(
                                    'Be smart with clean environment.',
                                    style: TextStyle(
                                      fontSize:
                                          _getResponsiveFontSize(screenSize) *
                                          0.6,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Responsive font size calculation
  double _getResponsiveFontSize(Size screenSize) {
    if (screenSize.width < 350) {
      return 16; // Very small screens
    } else if (screenSize.width < 600) {
      return 20; // Mobile phones
    } else if (screenSize.width < 900) {
      return 24; // Tablets
    } else {
      return 28; // Large screens
    }
  }

  // Color coding for each word
  Color _getWordColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue; // Smart
      case 1:
        return Colors.green; // Bin
      case 2:
        return Colors.orange; // Monitoring
      case 3:
        return Colors.red; // System
      default:
        return Colors.black;
    }
  }

  @override
  void dispose() {
    // Dispose animation controllers
    _titleController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
