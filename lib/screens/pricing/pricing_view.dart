import 'package:auto_size_text/auto_size_text.dart';
import 'package:docs_ai/models/error_model.dart';
import 'package:docs_ai/models/pricing.dart';
import 'package:docs_ai/repository/auth_repository.dart';
import 'package:docs_ai/repository/pricing_repository.dart';
import 'package:docs_ai/screens/pricing/get_started_btn.dart';
import 'package:docs_ai/utils/colors.dart';
import 'package:docs_ai/utils/constant.dart';
import 'package:docs_ai/widgets/custom_btn.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

/// A widget to display the pricing card
class PricingCard extends StatelessWidget {
  /// Creates a [PricingCard] widget
  const PricingCard({
    required this.pricing,
    required this.width,
    this.isCurrentPricing = false,
    super.key,
  });

  /// To know if the current pricing is the current pricing
  final bool isCurrentPricing;

  /// The pricing model
  final Pricing pricing;

  /// The width of the card
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 300,
      child: Card(
        color: kPriceCardBg,
        surfaceTintColor: kPriceCardBg,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isCurrentPricing ? kBlueColor : kPriceCardBg,
            width: 2,
          ),
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
                      SizedBox(
                        width: width * .8,
                        child: AutoSizeText(
                          advantage,
                          style: GoogleFonts.lato(
                            color: kBlackColor,
                          ),
                          maxFontSize: 14,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Gap(18),
              const Spacer(),
              Visibility(
                visible: !isCurrentPricing,
                child: const GetStartedBtn(
                  onPressed: null,
                ),
              ),
              Visibility(
                visible: isCurrentPricing,
                child: Align(
                  child: Text(
                    'Current Plan',
                    style: GoogleFonts.lato(
                      color: kBlueColor,
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
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
    return MediaQuery.of(context).size.width > 480
        ? const _PricingViewForLargeScreen()
        : const _PricingViewMobileScreen();
  }
}

/// Contains the visual aspect of the pricing page for large screen
class _PricingViewForLargeScreen extends ConsumerWidget {
  /// Creates a [PricingViewForLargeScreen] widget
  const _PricingViewForLargeScreen();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width * .8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Consumer(
            builder: (BuildContext context, WidgetRef ref, Widget? child) {
              final AsyncValue<ErrorModel> errorModel =
                  ref.watch(getPricingProvider);

              return Center(
                child: switch (errorModel) {
                  AsyncData<ErrorModel>(:final ErrorModel value) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: (value.data as List<Pricing>)
                          .map(
                            (Pricing pricing) => PricingCard(
                              pricing: pricing,
                              width:
                                  (MediaQuery.sizeOf(context).width * .8) / 2,
                              isCurrentPricing: pricing.id ==
                                  ref.watch(userProvider)?.getPricing.id,
                            ),
                          )
                          .toList(),
                    ),
                  AsyncError<Widget>() => Text(
                      errorModel.error.toString(),
                      style: GoogleFonts.lato(
                        color: kBlackColor,
                      ),
                    ),
                  _ => const CustomCircularProgressIndicator(),
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _PricingViewMobileScreen extends StatelessWidget {
  const _PricingViewMobileScreen();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: pricingTest
          .map(
            (Pricing pricing) => Padding(
              padding: EdgeInsets.only(
                bottom: pricingTest.indexOf(pricing) != pricingTest.length - 1
                    ? 10
                    : 0,
              ),
              child: PricingCard(
                pricing: pricing,
                width: double.infinity,
              ),
            ),
          )
          .toList(),
    );
  }
}
