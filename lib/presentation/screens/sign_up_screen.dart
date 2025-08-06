import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
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
        // استخدام نفس الخلفية المتدرجة للحفاظ على التناسق
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
                // الجزء السفلي الذي يحتوي على فورم إنشاء الحساب
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
            // استخدام الصورة الجديدة الخاصة بإنشاء الحساب
            child: SvgPicture.asset(
              'assets/images/Add User-amico.svg',
              height: size.height * 0.25,
            ),
          ),
        ),
      ),
    );
  }

  // ودجت الجزء السفلي (فورم إنشاء الحساب)
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
                  "أنشئ حسابك",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  "انضم إلينا وابدأ المحادثة",
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 24),
                // حقول الإدخال
                _buildTextField(
                  icon: Icons.person_outline,
                  hint: "الاسم الكامل",
                ),
                const SizedBox(height: 16),
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
                // زر إنشاء الحساب
                _buildSignUpButton(),
                const Spacer(),
                // رابط الانتقال لصفحة تسجيل الدخول
                _buildLoginLink(),
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

  Widget _buildSignUpButton() {
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
          "إنشاء حساب",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("لديك حساب بالفعل؟", style: TextStyle(color: Colors.grey)),
        TextButton(
          onPressed: () {
            // منطق الانتقال لصفحة تسجيل الدخول
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
          child: const Text(
            "سجل الدخول",
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
