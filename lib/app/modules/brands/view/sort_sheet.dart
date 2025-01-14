import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


class SortSheet extends StatefulWidget {
  const SortSheet({
    super.key,
    this.currentSelection = '',
    this.onTap,
    this.items,
  });
  final List<String>? items;
  final String? currentSelection;
  final Function(String)? onTap;

  @override
  State<SortSheet> createState() => _SortSheetState();
}

class _SortSheetState extends State<SortSheet> {
  @override
  void initState() {
    super.initState();
    selectedItem = widget.currentSelection ?? '';
  }

  String selectedItem = '';
  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final screenSize = MediaQuery.of(context).size;
    final currentTheme = Get.theme;
    return Column(
      children: [
        Material(
          elevation: 0.2,
          color: currentTheme.primaryColor,
          child: ListTile(
            trailing: const Icon(
              Icons.close,
              color: AppColors.textColor2,
            ),
            title: const Text(
              'Sort by',
              style: TextStyle(
                color: AppColors.textColor2,
                fontSize: 18,
              ),
            ),
            onTap: () {
              Get.back();
            },
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: widget.items?.length,
            itemBuilder: (context, i) {
              return ListTile(
                onTap: () {
                  if (widget.onTap != null) widget.onTap!(widget.items![i]);
                  setState(() {
                    selectedItem = widget.items![i];
                  });
                },
                title: Row(
                  children: [
                    Text(
                      widget.items![i],
                      style: TextStyle(
                        color: AppColors.textColor2,
                        fontWeight: selectedItem == widget.items![i]
                            ? FontWeight.w500
                            : FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 10),
                    if (selectedItem == widget.items![i])
                      const CircleAvatar(
                        radius: 4,
                        backgroundColor: AppColors.bottomSelectedColor,
                      )
                  ],
                ),
              );
            },
          ),
        ),
        // Container(
        //   decoration:
        //       const BoxDecoration(color: AppColors.textColor1, boxShadow: [
        //     BoxShadow(
        //       color: Color.fromRGBO(0, 0, 0, 0.05),
        //       spreadRadius: 2,
        //       blurRadius: 9,
        //       offset: Offset(
        //         0,
        //         -2,
        //       ),
        //     ),
        //   ]),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: CurvedButton(
        //           onClick: () {
        //             setState(() {
        //               selectedItem = '';
        //             });
        //             Get.back();
        //           },
        //           text: 'CLOSE',
        //           textColor: AppColors.bottomNotSelectedColor,
        //           borderRadius: 0,
        //         ),
        //       ),
        //       Expanded(
        //         child: CurvedButton(
        //           onClick: () {
        //             if (widget.onTap != null) {
        //               widget.onTap!(selectedItem);
        //             }
        //           },
        //           text: 'APPLY',
        //           textColor: AppColors.textColor1,
        //           buttonColor: AppColors.bottomSelectedColor,
        //           borderRadius: 0,
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ],
    );
  }
}
