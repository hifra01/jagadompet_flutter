import 'package:flutter/material.dart';

class AppBarLogo extends StatelessWidget {
  final double size;
  final Color color;
  const AppBarLogo({Key? key, required this.size, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          Icons.account_balance_wallet,
          size: size,
          color: color,
        ),
        SizedBox(
          width: size / 4,
        ),
        Text(
          'JagaDompet',
          style: TextStyle(
            fontSize: size,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
