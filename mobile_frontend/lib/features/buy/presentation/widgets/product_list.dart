import 'package:big_cart/features/buy/domain/entities/product.dart';
import 'package:big_cart/features/buy/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

class ProductList extends StatelessWidget {
  List<Product> productList;
  ProductList(this.productList, {super.key});
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: productList.length,
      shrinkWrap: true, //constrains height so it doesnt mess with column
      physics: NeverScrollableScrollPhysics(), //already scroll with singlechild
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.h,
        childAspectRatio: 0.6,
      ),
      itemBuilder: (context, index) => ProductCard(productList[index]),
    );
  }
}
