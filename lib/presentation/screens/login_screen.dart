import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        // الخلفية ذات التدرج اللوني الجذاب
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF8E9EFE), Color(0xFFAB87FF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Column(
              children: [
                // الجزء العلوي الذي يحتوي على الصورة
                _buildHeader(size),
                // الجزء السفلي الذي يحتوي على فورم التسجيل
                _buildForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ودجت الجزء العلوي (الصورة)
  Widget _buildHeader(Size size) {
    return Expanded(
      flex: 2,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/images/messaging_app.svg',
              height: size.height * 0.3,
            ),
          ),
        ),
      ),
    );
  }

  // ودجت الجزء السفلي (فورم التسجيل)
  Widget _buildForm() {
    return Expanded(
      flex: 3,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "أهلاً بعودتك!",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "سجل الدخول للمتابعة",
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),
                // حقول الإدخال
                _buildTextField(
                  icon: Icons.email_outlined,
                  hint: "البريد الإلكتروني",
                ),
                const SizedBox(height: 16),
                _buildTextField(
                  icon: Icons.lock_outline,
                  hint: "كلمة المرور",
                  isPassword: true,
                ),
                const SizedBox(height: 24),
                // زر تسجيل الدخول
                _buildLoginButton(),
                const SizedBox(height: 16),
                const Center(
                  child: Text(
                    "أو سجل الدخول باستخدام",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 16),
                // أزرار الدخول الاجتماعي
                _buildSocialLogins(),
                const Spacer(),
                // رابط إنشاء حساب جديد
                _buildSignupLink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required IconData icon,
    required String hint,
    bool isPassword = false,
  }) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey.shade500),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF8E9EFE),
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          "تسجيل الدخول",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSocialLogins() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSocialButton(
          asset: 'assets/images/google_icon.svg',
        ), // تأكد من إضافة أيقونة جوجل
        const SizedBox(width: 20),
        _buildSocialButton(
          asset: 'assets/images/apple_icon.svg',
        ), // تأكد من إضافة أيقونة أبل
      ],
    );
  }

  Widget _buildSocialButton({required String asset}) {
    // ملاحظة: يجب عليك توفير هذه الصور بنفسك
    // سأضع هنا حاوية مؤقتة
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300, width: 1),
      ),
      child: SvgPicture.asset(
        asset,
        height: 24,
        // في حال عدم توفر الصور، يمكنك استخدام أيقونات Flutter
        // child: Icon(Icons.ac_unit, size: 24),
      ),
    );
  }

  Widget _buildSignupLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("ليس لديك حساب ؟", style: TextStyle(color: Colors.grey)),
        TextButton(
          onPressed: () {},
          child: const Text(
            "أنشئ حسابًا",
            style: TextStyle(
              color: Color(0xFF8E9EFE),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
