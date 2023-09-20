import 'package:flutter/material.dart';
import 'package:freo_assignment/models/search_result_model.dart';

class DetailScreen extends StatelessWidget {
  final result;

  const DetailScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              result.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              result.terms.toString(),
              textAlign: TextAlign.center,
            ),
            // You can add more widgets here to display additional details
          ],
        ),
      ),
    );
  }
}
