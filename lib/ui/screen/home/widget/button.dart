part of '../screen.dart';

class _ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _ButtonWidget({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide.none,
        minimumSize: Size(double.infinity, 48),
        backgroundBuilder: (context, states, child) {
          return Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppTheme.colorButtonGradientStart,
                  AppTheme.colorButtonGradientEnd,
                ],
              ),
            ),
            child: child,
          );
        },
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: theme.textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
