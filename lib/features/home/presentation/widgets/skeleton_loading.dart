import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonProductGrid extends StatelessWidget {
  final int itemCount;

  const SkeletonProductGrid({Key? key, this.itemCount = 4}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product image placeholder
                Container(
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 10),
                // Product title placeholder
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  height: 10,
                  color: Colors.white,
                ),
                const SizedBox(height: 5),
                // Product price placeholder
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  width: 80,
                  height: 10,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
