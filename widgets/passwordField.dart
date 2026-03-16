import 'package:flutter/material.dart';

class Passwordfield extends StatefulWidget {
  const Passwordfield({super.key});

  @override
  State<Passwordfield> createState() => _PasswordfieldState();
}

class _PasswordfieldState extends State<Passwordfield> {
  final passwordController = TextEditingController();
  bool isObsecured = false, isVisible = true;


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: isObsecured,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: TextStyle(
            color: Colors.black.withOpacity(0.5),
            fontWeight: FontWeight.w500,
          ),
          prefixIcon: Icon(Icons.lock_outline),
          prefixIconColor: Colors.black.withOpacity(0.5),
          suffixIcon: IconButton(onPressed: (){
            setState(() {
              isObsecured = !isObsecured;
              isVisible = !isVisible;
            });
          }, icon: Icon(isVisible ? Icons.visibility : Icons.visibility_off)),
          filled: true,
          fillColor: const Color(0xFFF7F8FC),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(
              color: Colors.black.withOpacity(0.1),
            ),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(
                color: Colors.black.withOpacity(0.1),
              )
          )
      ),
      validator: (v) {
        if (v == null || v.isEmpty) {
          return "Please enter a password";
        }
        if (v.length < 6) {
          return "Password must be at least 6 characters";
        }
        return null;
      },
    );
  }
}
