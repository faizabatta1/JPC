import 'package:flutter/material.dart';

class Reward {
  final String title;
  final String description;
  final int points;
  bool? isRedeemed;

  Reward({
    required this.title,
    required this.description,
    required this.points,
    this.isRedeemed = false,
  });
}

class RewardsScreen extends StatefulWidget {
  @override
  _RewardsScreenState createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  List<Reward> rewards = [
    Reward(
      title: 'Discount Coupon',
      description: 'Get 20% off on your next purchase',
      points: 100,
    ),
    Reward(
      title: 'Free Shipping',
      description: 'Enjoy free shipping on all orders',
      points: 200,
    ),
    Reward(
      title: 'Special Gift',
      description: 'Receive a surprise gift with your order',
      points: 150,
    ),
  ];

  void _redeemReward(int index) {
    setState(() {
      rewards[index].isRedeemed = true;
    });
    // TODO: Implement the redeeming logic, e.g., deduct points, show confirmation, etc.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rewards'),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your Rewards',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: rewards.length,
                itemBuilder: (context, index) {
                  final reward = rewards[index];
                  return RewardItem(
                    reward: reward,
                    onPressed: () {
                      _redeemReward(index);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RewardItem extends StatelessWidget {
  final Reward reward;
  final VoidCallback onPressed;

  const RewardItem({
    Key? key,
    required this.reward,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8.0),
          color: reward.isRedeemed! ? Colors.grey.shade300 : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              reward.title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(reward.description),
            SizedBox(height: 8.0),
            Text(
              '${reward.points} Points',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: reward.isRedeemed! ? Colors.grey : Colors.green,
              ),
            ),
            if (reward.isRedeemed!)
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Redeemed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}