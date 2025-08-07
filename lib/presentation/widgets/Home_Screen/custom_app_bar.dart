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
                "Moatasem Nagy", // اسم الشخص الآخر
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "متصل الآن",
                style: TextStyle(color: Colors.green.shade600, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(
            Icons.videocam_outlined,
            color: Colors.black54,
            size: 28,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.call_outlined,
            color: Colors.black54,
            size: 26,
          ),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}
