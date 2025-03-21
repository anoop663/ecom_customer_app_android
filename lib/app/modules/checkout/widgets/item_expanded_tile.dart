import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/values/colors.dart';
import '../../../widgets/curved_box.dart';
import '../../../widgets/curved_container_icon.dart';
import '../../home/models/home_product_model.dart';

class ItemsExpandTile extends StatefulWidget {
  const ItemsExpandTile({
    super.key,
    this.items,
  });
  final List<Product>? items;

  @override
  State<ItemsExpandTile> createState() => _ItemsExpandTileState();
}

class _ItemsExpandTileState extends State<ItemsExpandTile> {
  bool addressTileOpen = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: AppColors.textColor1,
          child: ExpansionTile(
            title: Text(
              'ITEMS (${widget.items?.length})',
              style: Get.theme.textTheme.bodyMedium!.copyWith(
                color: AppColors.removeButton,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: widget.items!.isEmpty
                    ? Center(
                        child: Text(
                          'No items available',
                          style: Get.theme.textTheme.bodyMedium,
                        ),
                      )
                    : Column(
                        children: [
                          CurvedBox(
                            borderRadius: 8.0,
                            child: ListView.separated(
                              physics: const ClampingScrollPhysics(),
                              itemCount: widget.items?.length ?? 0,
                              shrinkWrap: true,
                              itemBuilder: buildItemTile,
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                height: 1,
                                indent: 10,
                                endIndent: 10,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget buildItemTile(BuildContext context, int index) {
    final item = widget.items![index];
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CurvedContainerWithImage(
                height: 100,
                width: 80,
                containerImage: widget.items![index].image,
              ),
            ],
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name ?? 'No Name',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColor2,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                Text(
                  item.manufacturer ?? '',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColor2,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text(
                      '₹ ${item.price ?? 0}',
                      style: Get.theme.textTheme.bodyMedium!.copyWith(
                        color: AppColors.textColor2,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (item.oldprice != null && item.oldprice != item.price)
                      const SizedBox(width: 10),
                    if (item.oldprice != null && item.oldprice != item.price)
                      Text(
                        '₹ ${item.oldprice!}',
                        style: Get.theme.textTheme.bodyMedium!.copyWith(
                          color: AppColors.textColor2,
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  item.purchaseReward ?? '',
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    color: AppColors.orderDetailStatus,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
