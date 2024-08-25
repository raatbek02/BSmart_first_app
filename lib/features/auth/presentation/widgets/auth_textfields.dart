// CustomTextField.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthTextFields extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final List<TextInputFormatter> inputFormatters;
  final FocusNode? focusNode;
  final IconData icon;

  const AuthTextFields({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.inputFormatters = const [],
    this.focusNode,
  });

  @override
  _AuthTextFieldsState createState() => _AuthTextFieldsState();
}

class _AuthTextFieldsState extends State<AuthTextFields> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 3.w),
          TextField(
            controller: widget.controller,
            obscureText: widget.obscureText ? _obscureText : false,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            focusNode: widget.focusNode,
            style: GoogleFonts.poppins(fontSize: 16.sp),
            decoration: InputDecoration(
              prefixIcon: Icon(
                widget.icon,
                color: Colors.grey.shade400,
                size: 26.sp,
              ),
              suffixIcon: widget.obscureText
                  ? Semantics(
                      label: _obscureText ? 'Показать пароль' : 'Скрыть пароль',
                      child: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey.shade400,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    )
                  : null,
              filled: true,
              fillColor: Color.fromRGBO(246, 247, 251, 1),
              hintText: widget.hintText,
              hintStyle:
                  GoogleFonts.poppins(color: Colors.grey, fontSize: 16.sp),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(13.r),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
