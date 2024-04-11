import 'dart:ui';

/// Represents the pricing model
class Pricing {
  /// Creates a [Pricing] model
  const Pricing({
    required this.id,
    required this.labelColor,
    required this.label,
    required this.price,
    required this.currency,
  });

  /// The id of the pricing
  final String id;

  /// The color of the label
  final Color labelColor;

  /// The label of the pricing
  final String label;

  /// The price of the pricing
  final double price;

  /// The currency of the pricing
  final String currency;
}
