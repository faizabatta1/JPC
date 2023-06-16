import 'package:flutter/material.dart';
import 'package:jpc/core/helpers/theme_helper.dart';

class PointsScreen extends StatelessWidget {
  final int pointsBalance = 500;
  final List<Map<String, dynamic>> transactions = [
    {
      'id': '1',
      'description': 'Purchase at Store A',
      'date': '2022-04-12',
      'points': 100,
    },
    {
      'id': '2',
      'description': 'Purchase at Store B',
      'date': '2022-04-11',
      'points': 50,
    },
    {
      'id': '3',
      'description': 'Purchase at Store C',
      'date': '2022-04-10',
      'points': 75,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Points'),
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),

        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  color: ThemeHelper.secondaryColor,
                  borderRadius: BorderRadius.circular(8.0)
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
              child: Column(
                children: [
                  const Text(
                    'Points Balance',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    pointsBalance.toString(),
                    style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (ctx, index) => ListTile(
                  leading: const Icon(Icons.shopping_bag),
                  title: Text(transactions[index]['description']),
                  subtitle: Text(transactions[index]['date']),
                  trailing: Text(
                    '${transactions[index]['points']} pts',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: SizedBox(
                width: double.infinity,
                height: 50.0,
                child: ElevatedButton(
                  style: ThemeHelper.fullSizePrimaryButtonStyle(context),
                  onPressed: () {
                    // Add logic here to allow the user to redeem points for rewards
                  },
                  child: const Text('Redeem Points'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}