import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterprojectsetup/ui/mobile_detail/controller/mobile_detail_controller.dart';
import 'package:get/get.dart';

class MobileDetailView extends GetView<MobileDetailController> {
  const MobileDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        centerTitle: true,
        title: const Text('Mobile Detail'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            height: Get.height * 0.35,
            width: double.infinity,
            child: Stack(
              children: [
                Obx(
                  () => PageView.builder(
                      onPageChanged: (value) {
                        controller.selectedIndex.value = value;
                      },
                      controller: controller.pageController,
                      itemCount: controller.imageList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((context, index) => CachedNetworkImage(
                            imageUrl: controller.imageList[index].url ?? '',
                            fit: BoxFit.contain,
                            progressIndicatorBuilder: (_, __, ___) =>
                                const Center(
                              child: CircularProgressIndicator(),
                            ),
                          ))),
                ),
                Positioned(
                    top: 20.h,
                    width: Get.width - 120.w,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(width: 60.w),
                        Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.r),
                              color: Colors.cyan),
                          child: Text(
                              'Price : ${controller.mobileItemResponse?.price}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50.sp)),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.all(20.w),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(80.r),
                              color: Colors.cyan),
                          child: Text(
                              'Rating : ${controller.mobileItemResponse?.rating}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 50.sp)),
                        ),
                        SizedBox(width: 60.w),
                      ],
                    )),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Obx(
              () => CarouselIndicator(
                count: controller.imageList.isEmpty
                    ? 1
                    : controller.imageList.length,
                index: controller.selectedIndex.value,
                height: 8.h,
                width: 104.w,
                color: Get.context!.theme.primaryColor.withOpacity(0.2),
                activeColor: Get.context!.theme.primaryColor,
                cornerRadius: 10.r,
              ),
            ),
          ),
          SizedBox(height: 100.h),
          Text(
            'Description',
            style: TextStyle(
              fontSize: 60.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            controller.mobileItemResponse?.description ?? '',
            style: TextStyle(
              fontSize: 50.sp,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ).paddingOnly(left: 60.w, right: 60.w, bottom: 60.h, top: 60.h),
    ));
  }
}
