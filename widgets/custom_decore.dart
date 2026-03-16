import 'package:flutter/material.dart';

InputDecoration dec(String label, IconData icon)
{
  return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Colors.black.withOpacity(0.5),
        fontWeight: FontWeight.w500,
      ),
      prefixIcon: Icon(icon),
      prefixIconColor: Colors.black.withOpacity(0.5),
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
  );
}
