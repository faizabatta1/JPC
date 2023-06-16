import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:jpc/core/helpers/theme_helper.dart';
import 'package:jpc/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:jpc/presentation/screens/product_details_screen.dart';

import '../../data/models/product.dart';

class ProductsArea extends StatelessWidget {
  final ProductState state;
  const ProductsArea({Key? key,required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      // return GridView.builder(
      //   physics: NeverScrollableScrollPhysics(),
      //   shrinkWrap: true,
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //       crossAxisCount: 2,
      //       crossAxisSpacing: 8,
      //       mainAxisSpacing: 8
      //   ),
      //   itemCount: state.products.length,
      //
      //   itemBuilder: (context,index){
      //     Product product = state.products[index];
      //     return GestureDetector(
      //       onTap: (){
      //         Navigator.of(context).push(
      //           MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product,))
      //         );
      //       },
      //       child: Container(
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(12.0),
      //           color: ThemeHelper.secondaryColor,
      //           boxShadow: [
      //             BoxShadow(
      //               offset: Offset(-3,3),
      //               color: Colors.grey
      //             )
      //           ]
      //         ),
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Column(
      //             children: [
      //               Expanded(
      //                 flex: 1,
      //                 child: Image.network(product.imageUrl),
      //               ),
      //               SizedBox(height: 8),
      //               Text(
      //                 product.name,
      //                 style: TextStyle(fontSize: 16,color: Colors.white, fontWeight: FontWeight.bold),
      //               ),
      //               SizedBox(height: 8),
      //               Text(
      //                 '\$${product.price.toStringAsFixed(2)}',
      //                 style: TextStyle(fontSize: 14, color: Colors.white),
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // );

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2 / 3,
      ),
      itemCount: state.products.length,
      itemBuilder: (BuildContext context, int index) {
        Product product = state.products[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product,))
            );
          },
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image: CachedNetworkImageProvider(product.imageUrl),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (product.hasDiscount)
                        Positioned(
                          top: 5,
                          left: 5,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              '-${product.discount.toString()}%',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    product.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(height: 5),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                      decoration: product.hasDiscount ? TextDecoration.lineThrough : TextDecoration.none,
                    ),
                  ),
                ),
                if (product.hasDiscount)
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      '\$${(product.price * (1 - product.discount / 100)).toStringAsFixed(2)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }
}
