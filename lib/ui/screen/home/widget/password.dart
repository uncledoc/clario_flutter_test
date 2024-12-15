part of '../screen.dart';

class _PasswordWidget extends StatefulWidget {
  final TextEditingController _controller;
  final HomeScreenValidator _validator;

  const _PasswordWidget(this._controller, this._validator);

  @override
  State<_PasswordWidget> createState() => _PasswordWidgetState();
}

class _PasswordWidgetState extends State<_PasswordWidget> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return TextFormField(
      controller: widget._controller,
      style: WidgetStateTextStyle.resolveWith((states) {
        if (states.contains(WidgetState.error)) {
          return theme.textTheme.bodyLarge!.copyWith(
            color: AppTheme.colorError,
          );
        }
        return switch (widget._validator.fieldPasswordState) {
          HomeScreenValidatorState.success =>
            theme.textTheme.bodyLarge!.copyWith(color: AppTheme.colorSuccess),
          _ => theme.textTheme.bodyLarge!.copyWith(color: AppTheme.colorText),
        };
      }),
      inputFormatters: [
        LengthLimitingTextInputFormatter(64),
        FilteringTextInputFormatter.deny(RegExp("\\s")),
      ],
      obscureText: !isPasswordVisible,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        filled: true,
        hintText: "Create your password",
        border: switch (widget._validator.fieldPasswordState) {
          HomeScreenValidatorState.success => theme.inputDecorationTheme.border
              ?.copyWith(borderSide: BorderSide(color: AppTheme.colorSuccess)),
          _ => theme.inputDecorationTheme.border,
        },
        enabledBorder: switch (widget._validator.fieldPasswordState) {
          HomeScreenValidatorState.success => theme
              .inputDecorationTheme.errorBorder!
              .copyWith(borderSide: BorderSide(color: AppTheme.colorSuccess)),
          _ => theme.inputDecorationTheme.enabledBorder,
        },
        focusedBorder: switch (widget._validator.fieldPasswordState) {
          HomeScreenValidatorState.success => theme
              .inputDecorationTheme.focusedBorder
              ?.copyWith(borderSide: BorderSide(color: AppTheme.colorSuccess)),
          _ => theme.inputDecorationTheme.focusedBorder,
        },
        errorStyle:
            theme.inputDecorationTheme.errorStyle?.copyWith(height: 0.01),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              isPasswordVisible = !isPasswordVisible;
            });
          },
          icon: isPasswordVisible
              ? Assets.image.passwordShow.image(color: _buildIconColor())
              : Assets.image.passwordHide.image(color: _buildIconColor()),
        ),
      ),
      validator: (value) {
        if (widget._validator.isValidPassword(value ?? "")) {
          return null;
        }
        return "";
      },
    );
  }

  Color _buildIconColor() => switch (widget._validator.fieldPasswordState) {
        HomeScreenValidatorState.none => AppTheme.colorTextHint,
        HomeScreenValidatorState.error => AppTheme.colorError,
        HomeScreenValidatorState.success => AppTheme.colorSuccess,
      };
}
