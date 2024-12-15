import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_project/gen/assets.gen.dart';
import 'package:test_project/ui/screen/home/validator.dart';
import 'package:test_project/ui/theme/theme.dart';

part 'widget/background.dart';
part 'widget/button.dart';
part 'widget/email.dart';
part 'widget/password.dart';
part 'widget/password_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _keyForm = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _validator = HomeScreenValidator();

  @override
  void initState() {
    _passwordController.addListener(() {
      setState(() {
        _validator.validate(_passwordController.text, false);
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        forceMaterialTransparency: true,
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: _BackgroundWidget(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 138, left: 30, right: 30),
          child: Form(
            key: _keyForm,
            child: Column(
              children: [
                Text(
                  "Sign up",
                  style: theme.textTheme.headlineMedium?.copyWith(
                    color: AppTheme.colorText,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 30),
                _EmailWidget(_emailController, _validator),
                SizedBox(height: 20),
                _PasswordWidget(_passwordController, _validator),
                SizedBox(height: 20),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 20),
                  child: _PasswordHelperWidget(_validator),
                ),
                SizedBox(height: 30),
                _ButtonWidget(
                  text: "Sign up",
                  onPressed: () {
                    if (_keyForm.currentState?.validate() == true) {
                      debugPrint(
                        "email: ${_emailController.text}, password: ${_passwordController.text}",
                      );
                    }
                    setState(() {
                      _validator.validate(_passwordController.text, true);
                    });
                  },
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
