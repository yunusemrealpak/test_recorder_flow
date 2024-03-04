import 'package:flutter/material.dart';

class CardDetailsView extends StatelessWidget {
  const CardDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Details View'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Card Details'),
          ],
        ),
      ),
    );
  }
}
