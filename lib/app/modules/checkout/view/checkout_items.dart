import 'package:ecommerce_app/app/core/values/api_configs.dart';
import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/modules/home/models/home_product_model.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckoutItems extends StatelessWidget {
  const CheckoutItems({super.key, required this.product});
  final Product product;

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: CurvedButton(
        height: MediaQuery.of(context).size.height * 0.25 +
            (20 * product.product!.thisOptions!.length.toDouble()),
        borderColor: AppColors.cartItemBorder,
        borderRadius: 4,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15 +
                    (20 * product.product!.thisOptions!.length.toDouble()),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.16 +
                          (20 *
                              product.product!.thisOptions!.length.toDouble()),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: FadeInImage.assetNetwork(
                          placeholder: 'assets/images/no_image.png',
                          image: '${ApiConfig.productImageUrl}${product.image}',
                          fit: BoxFit.cover,
                          imageErrorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              'assets/images/no_image.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Product details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            product.name!,
                            style: context.textTheme.bodyMedium!.copyWith(
                              color: AppColors.cartProductTitle,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          ListView.separated(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: product.product!.thisOptions!.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 5),
                            itemBuilder: (context, index) {
                              return Text(
                                '${product.product!.thisOptions![index].name!} : ${product.product?.thisOptions?[index].thisValues?.text ?? ''}',
                                style: const TextStyle(
                                  color: AppColors.viewAll,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w400,
                                ),
                              );
                            },
                          ),
                          Row(
                            children: [
                              Text(
                                '₹ ${product.price!}',
                                style: context.textTheme.bodyMedium!.copyWith(
                                  color: AppColors.textColor2,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(width: 5),
                              if (product.oldprice != product.price)
                                Text(
                                  '₹ ${product.oldprice!}',
                                  style: context.textTheme.bodyMedium!.copyWith(
                                    color: AppColors.textColor2,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
