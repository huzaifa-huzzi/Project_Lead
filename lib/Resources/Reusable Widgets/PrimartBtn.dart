import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class PrimaryBtn extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;
  final Color color;

  const PrimaryBtn({
    super.key,
    required this.title,
    required this.onTap,
    required this.loading,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    double buttonWidth;
    if (screenWidth < 600) {
      buttonWidth = screenWidth * 0.9;
    } else if (screenWidth < 1000) {
      buttonWidth = screenWidth * 0.5;
    } else {
      buttonWidth = screenWidth * 0.2;
    }

    return InkWell(
      onTap: loading ? null : onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: buttonWidth,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
        ),
        alignment: Alignment.center,
        child: loading
            ? const SizedBox(
          height: 24,
          width: 24,
          child: LoadingIndicator(
            indicatorType: Indicator.ballClipRotate,
            colors: [Colors.white],
            strokeWidth: 2,
          ),
        )
            : Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
