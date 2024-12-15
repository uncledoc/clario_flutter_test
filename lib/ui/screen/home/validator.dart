enum HomeScreenValidatorState { none, success, error }

class HomeScreenValidator {
  static final emailReg =
      RegExp(r"^\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$");
  static final passwordRegex =
      RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[^\s]{8,64}$');

  final _minLength = RegExp(r'^[^\s]{8,}$');
  final _upperLowerLetter = RegExp(r'^(?=.*[a-z])(?=.*[A-Z]).+$');
  final _digit = RegExp(r'^(?=.*\d).+$');

  HomeScreenValidatorState _fieldEmailState = HomeScreenValidatorState.none;
  HomeScreenValidatorState get fieldEmailState => _fieldEmailState;

  HomeScreenValidatorState _fieldPasswordState = HomeScreenValidatorState.none;
  HomeScreenValidatorState get fieldPasswordState => _fieldPasswordState;

  HomeScreenValidatorState _minLengthState = HomeScreenValidatorState.none;
  HomeScreenValidatorState get minLengthState => _minLengthState;

  HomeScreenValidatorState _upperLowerLetterState = HomeScreenValidatorState.none;
  HomeScreenValidatorState get upperLowerLetterState => _upperLowerLetterState;

  HomeScreenValidatorState _digitState = HomeScreenValidatorState.none;
  HomeScreenValidatorState get digitState => _digitState;

  void validate(String password, bool isFinalValidation) {
    if (_minLength.hasMatch(password)) {
      _minLengthState = HomeScreenValidatorState.success;
    } else if (isFinalValidation) {
      _minLengthState = HomeScreenValidatorState.error;
    }
    if (_upperLowerLetter.hasMatch(password)) {
      _upperLowerLetterState = HomeScreenValidatorState.success;
    } else if (isFinalValidation) {
      _upperLowerLetterState = HomeScreenValidatorState.error;
    }
    if (_digit.hasMatch(password)) {
      _digitState = HomeScreenValidatorState.success;
    } else if (isFinalValidation) {
      _digitState = HomeScreenValidatorState.error;
    }
  }

  bool isValidEmail(String email) {
    if(emailReg.hasMatch(email)){
      _fieldEmailState = HomeScreenValidatorState.success;
      return true;
    }
    _fieldEmailState = HomeScreenValidatorState.error;
    return false;
  }

  bool isValidPassword(String password){
    if(passwordRegex.hasMatch(password)){
      _fieldPasswordState = HomeScreenValidatorState.success;
      return true;
    }
    _fieldPasswordState = HomeScreenValidatorState.error;
    return false;
  }
}
