import 'package:flutter/material.dart';

class InterestTile extends StatelessWidget {
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const InterestTile({
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F8FC),
        borderRadius: BorderRadius.circular(14),
      ),
      child: CheckboxListTile(
        activeColor: Colors.blue[500],
        value: value,
        onChanged: (v) => onChanged(v ?? false),
        checkboxShape: CircleBorder(
          side: BorderSide(
            color: Colors.black.withOpacity(0.1),
            width: 2,
          )
        ),
        title: Text(title),
        controlAffinity: ListTileControlAffinity.leading,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
    );
  }
}