import 'package:flutter/material.dart';
import '../../domain/entities/product.dart';
import 'product_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Product> products;
  final ScrollController? scrollController;

  const ProductGrid({
    Key? key,
    required this.products,
    this.scrollController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      controller: scrollController,
      shrinkWrap: true,
      padding: const EdgeInsets.all(10),
      physics: const ClampingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return ProductCard(product: products[index]);
      },
    );
  }
}
