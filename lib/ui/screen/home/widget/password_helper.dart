part of '../screen.dart';

class _PasswordHelperWidget extends StatelessWidget {
  final HomeScreenValidator _validator;

  const _PasswordHelperWidget(this._validator);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      spacing: 2,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "8 characters or more (no spaces)",
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 13,
            color: _buildColorState(_validator.minLengthState),
          ),
        ),
        Text(
          "Uppercase and lowercase letters",
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 13,
            color: _buildColorState(
              _validator.upperLowerLetterState,
            ),
          ),
        ),
        Text(
          "At least one digit ",
          style: theme.textTheme.bodyMedium?.copyWith(
            fontSize: 13,
            color: _buildColorState(
              _validator.digitState,
            ),
          ),
        ),
      ],
    );
  }

  Color _buildColorState(HomeScreenValidatorState state) => switch (state) {
        HomeScreenValidatorState.none => AppTheme.colorText,
        HomeScreenValidatorState.success => AppTheme.colorSuccess,
        HomeScreenValidatorState.error => AppTheme.colorError,
      };
}
