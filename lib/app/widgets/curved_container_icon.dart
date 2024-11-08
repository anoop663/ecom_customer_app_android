import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommerce_app/app/core/extensions/custom_page_scroll.dart';
import 'package:ecommerce_app/app/core/extensions/image_cache_size.dart';
import 'package:ecommerce_app/app/core/values/colors.dart';
import 'package:ecommerce_app/app/core/values/strings.dart';
import 'package:ecommerce_app/app/widgets/curve_button.dart';
import 'package:flutter/material.dart';



class CurvedContainerWithImage extends StatefulWidget {
  const CurvedContainerWithImage({
    super.key,
    this.containerImage,
    this.height,
    this.width,
    this.isSoldOut = false,
  });
  final String? containerImage;

  final double? height, width;
  final bool isSoldOut;

  @override
  State<CurvedContainerWithImage> createState() =>
      _CurvedContainerWithImageState();
}

class _CurvedContainerWithImageState extends State<CurvedContainerWithImage> {
  late final PageController? pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        height: widget.height ?? screenSize.height * 0.2,
        width: widget.width ?? screenSize.width * 0.32,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            PageView.builder(
              physics: const CustomPageViewScrollPhysics(),
              controller: pageController,
              itemCount: widget.containerImage!.length,
              itemBuilder: (context, index) {

                return !widget.containerImage![index].contains('asset')
                    ? CachedNetworkImage(
                        memCacheWidth: widget.width == null
                            ? (screenSize.width * 0.32).cacheSize(context)
                            : widget.width!.cacheSize(context),
                        memCacheHeight: widget.height == null
                            ? (screenSize.height * 0.18).cacheSize(context)
                            : widget.height!.cacheSize(context),
                        imageUrl: widget.containerImage![index],
                        width: widget.width,
                        height: widget.height,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                        errorWidget: (context, url, error) {
                          return Image.asset(
                            ImageStrings.noImage,
                            fit: BoxFit.cover,
                          );
                        },
                      )
                    : Image.asset(widget.containerImage![index]);
              },
            ),
            if (widget.isSoldOut)
              Container(
                color: AppColors.noFocusColor,
                child: Align(
                  alignment: const Alignment(0, 0.8),
                  child: CurvedButton(
                    height: screenSize.height * 0.04,
                    width: screenSize.width * 0.21,
                    borderRadius: 0,
                    textColor: AppColors.primary,
                    buttonColor: AppColors.textColor2,
                    borderColor: AppColors.textColor2,
                    text: 'Sold Out',
                    fontSize: 14,
                    fontweight: FontWeight.w500,
                    isSelected: true,
                  ),
                ),
              ),
            if (widget.containerImage!.length > 1)
              Positioned(
                bottom: 5,
                left: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: List.generate(
                    widget.containerImage!.length,
                    (index) => ListenableBuilder(
                        listenable: pageController!,
                        builder: (context, child) {
                          return AnimatedContainer(
                            duration: const Duration(
                              microseconds: 1,
                            ),
                            height: 4,
                            width: 4,
                            margin: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: pageController!.page == index
                                  ? AppColors.textColor1
                                  : AppColors.noFocusColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          );
                        }),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
