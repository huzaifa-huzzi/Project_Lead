import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class PrimaryBtn extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const PrimaryBtn({
    super.key,
    required this.title,
    required this.onTap,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final buttonColor = loading ? Colors.grey : Theme.of(context).colorScheme.primary;

    return InkWell(
      onTap: loading ? null : onTap,
      child: Container(
        width: width * 0.3,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
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
