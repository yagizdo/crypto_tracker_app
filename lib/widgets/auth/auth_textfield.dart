import 'package:crypto_tracker/utils/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthTextField extends StatefulWidget {
  const AuthTextField(
      {Key? key,
      required this.label,
      required this.controller,
      required this.isPassword,
      this.isEmail,
      this.isName,
      required this.prefixIcon,
      this.validator})
      : super(key: key);
  final String label;
  final TextEditingController controller;
  final bool isPassword;
  final bool? isEmail;
  final bool? isName;
  final Widget prefixIcon;
  final String? Function(String?)? validator;

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w),
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.isPassword ? !isPasswordVisible : false,
        obscuringCharacter: '*',
        validator: widget.validator,
        inputFormatters: [
          if(widget.isName == true)
          FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-ZğıüşöçİĞÜŞÖÇ ]*[a-zA-ZğıüşöçİĞÜŞÖÇ ]*'))
        ],
        keyboardType: widget.isEmail == true
            ? TextInputType.emailAddress
            : widget.isPassword
                ? TextInputType.visiblePassword
                : TextInputType.visiblePassword,
        style: const TextStyle(color: AppColors.blackBackground),
        decoration: InputDecoration(
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    color: CupertinoColors.systemGrey,
                  ),
                )
              : null,
          labelText: widget.label,
          hintText: widget.label,
          fillColor: AppColors.white,
          filled: true,
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelStyle: const TextStyle(color: AppColors.blackBackground),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.yellow),
          ),
        ),
      ),
    );
  }
}
