import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class RoundedButton extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final bool loading;

  const RoundedButton({
    super.key,
    required this.title,
    required this.onTap,
    this.loading = false,
  });

  @override
  State<RoundedButton> createState() => _RoundedButtonState();
}

class _RoundedButtonState extends State<RoundedButton> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    final buttonColor = widget.loading
        ? Colors.grey
        : Theme.of(context).colorScheme.primary;

    return InkWell(
      onTap: widget.loading ? null : widget.onTap,
      child: Container(
        width: width * 0.3,
        padding:  EdgeInsets.symmetric(horizontal: 5,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: buttonColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            widget.loading
                ? SizedBox(
              height: 24,
              width: 24,
              child: LoadingIndicator(
                indicatorType: Indicator.ballClipRotate,
                colors: [Colors.white],
              ),
            )
                : const Icon(Icons.lock_outline_rounded, color: Colors.white),
            SizedBox(width: width * 0.02),
            Text(
              widget.title,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
