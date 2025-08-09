import 'package:chat_app/data/services/firebase/auth/auth_service.dart';
import 'package:chat_app/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 1,
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: const AssetImage("assets/images/moatasem.jpg"),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Moatasem Nagy",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Online",
                style: TextStyle(color: Colors.green.shade600, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.videocam_outlined,
            color: Colors.teal.shade600,
            size: 28,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.call_outlined,
            color: Colors.teal.shade600,
            size: 26,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(
            Icons.logout_rounded,
            color: Colors.teal.shade600,
            size: 26,
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("LOG OUT"),
                content: const Text("Are you sure you want to log out ?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("No"),
                  ),
                  TextButton(
                    onPressed: () async {
                      await AuthService.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Logged out successfully"),
                        ),
                      );
                    },
                    child: const Text("Yes"),
                  ),
                ],
              ),
            );
          },
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
