import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String label;
  final String amount;

  const InfoCard(
      {super.key,
      required this.color,
      required this.icon,
      required this.label,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
        
        border: Border(
       
          bottom: BorderSide(
            color: color,
            width: 4,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.black,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            label.toUpperCase(),
            style: const TextStyle(
                color: Colors.black54,
                fontSize: 14,
                fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            amount,
            style: const TextStyle(
                color: Colors.black, fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}
