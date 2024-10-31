import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../models/models.dart';

class SushiProducts extends StatelessWidget {
  const SushiProducts({super.key, required this.products});

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildBuilderDelegate(
          childCount: products.length,
            (context, index) {
            final product = products[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                    const SizedBox(height: 8.0,),
                                    Text(product.description, maxLines: 6, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w300),),
                                    const SizedBox(height: 8.0,),
                                    Text(product.price,style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),),
                                    const SizedBox(height: 8.0,),
                                  ],
                                ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage(
                                product.image
                              ),
                            ),
                          ),
                          height: 140,
                          width: 130,

                        ),
                      ],
                    ),
                  ),
                  if(index == products.length -1)...[
                    const SizedBox(height: 30.0,),
                    Container(
                      height: 0.5,
                      color: Colors.white.withOpacity(0.3),
                    )
                  ]
                ],
              ),
            );
            }
        )
    );
  }
}
