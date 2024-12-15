part of '../screen.dart';

class _EmailWidget extends StatelessWidget {
  final TextEditingController _controller;
  final HomeScreenValidator _validator;

  const _EmailWidget(this._controller, this._validator);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: _controller,
      style: WidgetStateTextStyle.resolveWith(
        (states) {
          if (states.contains(WidgetState.error)) {
            return theme.textTheme.bodyLarge!
                .copyWith(color: AppTheme.colorError);
          }
          return switch (_validator.fieldEmailState) {
            HomeScreenValidatorState.success =>
              theme.textTheme.bodyLarge!.copyWith(color: AppTheme.colorSuccess),
            _ => theme.textTheme.bodyLarge!.copyWith(color: AppTheme.colorText),
          };
        },
      ),
      inputFormatters: [LengthLimitingTextInputFormatter(100)],
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        filled: true,
        hintText: "Email",
        border: switch (_validator.fieldEmailState) {
          HomeScreenValidatorState.success => theme.inputDecorationTheme.border!
              .copyWith(borderSide: BorderSide(color: AppTheme.colorSuccess)),
          _ => theme.inputDecorationTheme.border,
        },
        enabledBorder: switch (_validator.fieldEmailState) {
          HomeScreenValidatorState.success => theme
              .inputDecorationTheme.errorBorder!
              .copyWith(borderSide: BorderSide(color: AppTheme.colorSuccess)),
          _ => theme.inputDecorationTheme.enabledBorder,
        },
        focusedBorder: switch (_validator.fieldEmailState) {
          HomeScreenValidatorState.success => theme
              .inputDecorationTheme.focusedBorder!
              .copyWith(borderSide: BorderSide(color: AppTheme.colorSuccess)),
          _ => theme.inputDecorationTheme.focusedBorder,
        },
      ),
      validator: (value) {
        if (_validator.isValidEmail(value ?? "")) {
          return null;
        }
        return "Invalid email address";
      },
    );
  }
}
