import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final String amount;

  InfoCard(
      {required this.color,
      required this.icon,
      required this.label,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          SizedBox(
            height: 10,
          ),
          Text(
            label,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            amount,
            style: TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}