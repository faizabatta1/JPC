import 'package:flutter/material.dart';

class ProductFilteringBottomSheet extends StatefulWidget {
  const ProductFilteringBottomSheet({Key? key}) : super(key: key);

  @override
  _ProductFilteringBottomSheetState createState() =>
      _ProductFilteringBottomSheetState();
}

class _ProductFilteringBottomSheetState
    extends State<ProductFilteringBottomSheet> {
  bool _isOption1Selected = false;
  bool _isOption2Selected = false;
  bool _isOption3Selected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Filter options',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          CheckboxListTile(
            title: const Text('Option 1'),
            value: _isOption1Selected,
            onChanged: (value) {
              setState(() {
                _isOption1Selected = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Option 2'),
            value: _isOption2Selected,
            onChanged: (value) {
              setState(() {
                _isOption2Selected = value!;
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Option 3'),
            value: _isOption3Selected,
            onChanged: (value) {
              setState(() {
                _isOption3Selected = value!;
              });
            },
          ),
          const Spacer(),
          ElevatedButton(
            onPressed: () {
              // Perform the filtering action here
              Navigator.pop(context);
            },
            child: const Text('Apply filters'),
          ),
        ],
      ),
    );
  }
}