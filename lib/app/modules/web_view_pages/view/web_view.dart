
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soulstyle/app/core/values/colors.dart';
import 'package:soulstyle/app/modules/web_view_pages/controller/web_view_controller.dart';
import 'package:soulstyle/app/routes/routes.dart';
import 'package:soulstyle/app/widgets/loading_widget.dart';


class WebViewView extends StatelessWidget {
  const WebViewView({super.key});
  @override
  Widget build(BuildContext context) {
    final WebViewController controller = Get.put(WebViewController());
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.title.value,
            style: const TextStyle(
              color: AppColors.textColor2,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        centerTitle: false,
        leading: Hero(
          tag: 'logo',
          child: InkWell(
            onTap: () {
              if (!Navigator.canPop(context)) {
                Get.offAllNamed(Routes.bottombar);
              } else {
                Get.back();
              }
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: AppColors.textColor2,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Obx(
          () => controller.isLoading.isTrue
              ? const LoadingWidget()
              : controller.response.value == null
                  ? Text(
                      controller.content.value,
                      style: const TextStyle(
                        color: AppColors.textColor2,
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          controller.response.value!.pagecontents!.length,
                      itemBuilder: (context, index) {
                        Widget tempWidget = const SizedBox();

                        switch (controller
                            .response.value!.pagecontents![index].fieldName!) {
                          case 'title':
                            tempWidget = Text(
                              controller.response.value!.pagecontents![index]
                                  .fieldValue!,
                              style: const TextStyle(
                                color: AppColors.textColor2,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            );
                            break;
                          case 'sub_title':
                            tempWidget = Text(
                              controller.response.value!.pagecontents![index]
                                  .fieldValue!,
                              style: const TextStyle(
                                color: AppColors.textColor2,
                                fontWeight: FontWeight.w400,
                                fontSize: 15,
                              ),
                            );
                            break;
                          //case 'desc':
                          //  print(controller.response.value!
                          //      .pagecontents![index].fieldValue!);
                          //  tempWidget = Html(
                          //    data: controller.response.value!
                          //        .pagecontents![index].fieldValue!,
                          //    style: {
                          //      "body": Style(
                          //        color: AppColors.textColor2,
                          //        fontSize: FontSize.small,
                          //        fontWeight: FontWeight.w400,
                          //      ),
                          //    },
                          //  );
                          //  break;
                          default:
                        }

                        return tempWidget;
                      },
                    ),
        ),
      ),
    );
  }
}
