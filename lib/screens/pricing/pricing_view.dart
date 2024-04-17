import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_clone/models/pricing.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:google_clone/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';

class PricingCard extends StatelessWidget {
  const PricingCard({
    required this.pricing,
    super.key,
  });

  /// The pricing model
  final Pricing pricing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        color: kPriceCardBg,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              pricing.label,
              style: GoogleFonts.lato(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: kBlackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PricingView extends ConsumerWidget {
  const PricingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        PricingCard(
          pricing: pricingTest[0],
        ),
      ],
    );
  }
}
