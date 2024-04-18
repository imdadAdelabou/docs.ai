import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_clone/models/pricing.dart';
import 'package:google_clone/screens/pricing/get_started_btn.dart';
import 'package:google_clone/utils/colors.dart';
import 'package:google_clone/utils/constant.dart';
import 'package:google_fonts/google_fonts.dart';

/// A widget to display the pricing card
class PricingCard extends StatelessWidget {
  /// Creates a [PricingCard] widget
  const PricingCard({
    required this.pricing,
    super.key,
  });

  /// The pricing model
  final Pricing pricing;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Card(
        color: kPriceCardBg,
        surfaceTintColor: kPriceCardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                pricing.label,
                style: GoogleFonts.lato(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: kBlackColor,
                ),
              ),
              const Gap(4),
              Text(
                '${pricing.price}\$',
                style: GoogleFonts.lato(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Gap(8),
              Text(
                pricing.description,
                style: GoogleFonts.lato(
                  color: kDescriptionColor,
                ),
              ),
              ...pricing.advantages.map(
                (String advantage) => Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    children: <Widget>[
                      const Icon(
                        Icons.check,
                        color: kBlackColor,
                        size: 16,
                      ),
                      const Gap(4),
                      Text(
                        advantage,
                        style: GoogleFonts.lato(
                          color: kBlackColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(18),
              const GetStartedBtn(
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Contains the visual aspect of the pricing page
class PricingView extends ConsumerWidget {
  /// Creates a [PricingView] widget
  const PricingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: pricingTest
                .map(
                  (Pricing pricing) => Padding(
                    padding: EdgeInsets.only(
                      right:
                          pricingTest.indexOf(pricing) != pricingTest.length - 1
                              ? 10
                              : 0,
                    ),
                    child: PricingCard(
                      pricing: pricing,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
