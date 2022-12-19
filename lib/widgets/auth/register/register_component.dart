import 'package:crypto_tracker/i18n/locale_keys.g.dart';
import 'package:crypto_tracker/services/database/database_service.dart';
import 'package:crypto_tracker/services/navigation_service.dart';
import 'package:crypto_tracker/widgets/auth/auth_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/auth/auth_service.dart';
import '../../../services/locator.dart';
import '../../../services/validator.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/app_textstyles.dart';
import '../../../views/auth_view.dart';
import '../../main_widgets/tapWrapper.dart';

class RegisterComponent extends StatefulWidget {
  const RegisterComponent({Key? key, required this.onRegisterChanged}) : super(key: key);
  final ValueSetter<AuthFormState> onRegisterChanged;

  @override
  State<RegisterComponent> createState() => _RegisterComponentState();
}

class _RegisterComponentState extends State<RegisterComponent> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordConfirmController;

  final AuthService _authService = getIt<AuthService>();
  final DatabaseService _databaseService = getIt<DatabaseService>();
  bool isLoading = false;

  @override
  void setState(VoidCallback fn) {
    if(mounted){
      super.setState(fn);
    }
  }

  Future<void> sendVerificationMail() async {
    await _authService.sendVerificationMail();
  }

  Future<void> updateUserName() async {
    await _authService.updateUserName(name :_nameController.text);
  }

  Future<void> saveUserInDatabase() async {
    await _databaseService.saveUserInDatabase(_authService.currentUser);
  }

  Future<void> registerWithEmailAndPassword() async {
    setState(() {
      isLoading =true;
    });
    await _authService.registerWithEmailAndPassword(userEmail: _emailController.text, userPassword: _passwordController.text)
        .then((value) async {
      if(value != null) {
       await updateUserName();
       await saveUserInDatabase();
       await sendVerificationMail();

      }
    });
    setState(() {
      isLoading =false;
    });
  }

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _passwordConfirmController = TextEditingController();
    _formKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return _registerComponent();
  }

  Widget _registerComponent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _registerFormComp(),
      ],
    );
  }



  Widget _registerFormComp() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          AuthTextField(
            controller: _nameController,
            label: LocaleKeys.auth_register_name_txtfield_txt.tr(),
            prefixIcon: const Icon(Icons.person, color: AppColors.blackBackground),
            isPassword: false,
            isName: true,
            validator: (value) => Validator.name(value),
          ),
          height10Per(context: context),
          AuthTextField(
            controller: _emailController,
            label: LocaleKeys.auth_email_txt.tr(),
            isEmail: true,
            prefixIcon: const Icon(Icons.email, color: AppColors.blackBackground),
            isPassword: false,
            validator: (value) => Validator.email(value),
          ),
          height10Per(context: context),
          AuthTextField(
            controller: _passwordController,
            label: LocaleKeys.auth_password_txt.tr(),
            prefixIcon: const Icon(Icons.lock, color: AppColors.blackBackground),
            isPassword: true,
            validator: (value) => Validator.password(
              value,
            ),
          ),
          height10Per(context: context),
          AuthTextField(
            controller: _passwordConfirmController,
            label: LocaleKeys.auth_password_scnd_txt.tr(),
            prefixIcon: const Icon(Icons.lock, color: AppColors.blackBackground),
            isPassword: true,
            validator: (value) => Validator.passwordsMatch(
                value, _passwordController.text, _passwordConfirmController.text),
          ),
          height10Per(context: context),
          _registerButton(),
          height10Per(context: context),
          TextButton(
              onPressed: () {
                widget.onRegisterChanged(AuthFormState.login);
              },
              child: Text(LocaleKeys.auth_register_have_account.tr())),
        ],
      ),
    );
  }



  Widget _registerButton() {
    return TapWrapper(
      onTap: () {
        if (_formKey.currentState!.validate()) {
          if (_passwordController.text == _passwordConfirmController.text) {
            registerWithEmailAndPassword();
          }
        }
      },
      child: Container(
        width: 250.w,
        height: 40.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child:isLoading ? SizedBox(width: 25.w, height: 25.w, child: CircularProgressIndicator(color: AppColors.blackBackground, strokeWidth: 2.5.w,)) : Text(
            LocaleKeys.auth_register_register_btn.tr(),
            style: AppTextStyle.loginBtnTitle(),
          ),
        ),
      ),
    );
  }
}
