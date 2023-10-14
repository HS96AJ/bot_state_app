// Custom Classes
import 'package:flutter/material.dart';

class TextRows extends StatelessWidget {
  final String text;
  final String theMainVariable;
  const TextRows(this.text, this.theMainVariable, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style: const TextStyle(
                fontSize: 17,
              )),
          Text(
            theMainVariable,
            style: const TextStyle(
              fontSize: 17,
            ),
          )
        ],
      ),
    );
  }
}
