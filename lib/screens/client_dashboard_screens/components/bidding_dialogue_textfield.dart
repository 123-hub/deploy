import 'package:flutter/material.dart';

class BiddingDialogTextField extends StatelessWidget {
  const BiddingDialogTextField({
    super.key,
    required this.bidAmountController,
  });

  final TextEditingController bidAmountController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: bidAmountController,
      keyboardType: const TextInputType.numberWithOptions(),
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        hintText: 'Enter your bid amount',
      ),
    );
  }
}