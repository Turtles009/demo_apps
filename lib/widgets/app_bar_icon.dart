import 'package:flutter/material.dart';

class AppBarIcon extends StatelessWidget {
  const AppBarIcon({
    super.key,
    required this.icon,
    this.onPressedHandler,
    this.isBadge = true,
  });

  final Icon icon;
  final VoidCallback? onPressedHandler;
  final bool isBadge;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      splashColor: Colors.transparent,
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      onPressed: onPressedHandler,
      icon: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color.fromARGB(255, 120, 146, 240),
        ),
        child: Stack(
          children: [
            icon,
            if (isBadge != false)
              const Positioned(
                top: 4,
                right: 4,
                child: Badge(
                  smallSize: 8,
                  backgroundColor: Colors.orange,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
