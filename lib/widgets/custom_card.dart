import 'package:flutter/material.dart';
import '../constants.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String image;
  final Color? color;
  final String value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const CustomCard({
    super.key,
    required this.title,
    required this.image,
    this.color,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kCardRadius),
      ),
      elevation: 3,
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/$image',
                      height: 25,
                      width: 25,
                      color: color,
                    ),
                    const SizedBox(width: 8),
                    Text(title, style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),
                const SizedBox(height: 10),
                Text(value, style: Theme.of(context).textTheme.titleLarge),
              ],
            ),
            Column(
              children: [
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: onIncrement,
                ),
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline),
                  onPressed: onDecrement,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
