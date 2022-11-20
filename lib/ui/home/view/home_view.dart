import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutterprojectsetup/ui/home/controller/home_controller.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mobile List'),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TabBar(
                    unselectedLabelColor: Colors.black,
                    controller: controller.tabController,
                    physics: const NeverScrollableScrollPhysics(),
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicator: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(100.r)),
                    tabs: [
                  SizedBox(
                      height: 150.h,
                      child: const Center(child: Text('Normal'))),
                  SizedBox(
                      height: 150.h,
                      child: const Center(child: Text('Favourite'))),
                ])
                .paddingOnly(left: 60.w, right: 60.w, bottom: 30.h, top: 30.h),
            Expanded(
              child: TabBarView(
                  controller: controller.tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    NormalTab(controller: controller),
                    FavouriteTab(controller: controller)
                  ]),
            )
          ],
        ),
      ),
    );
  }
}

class FavouriteTab extends StatelessWidget {
  const FavouriteTab({Key? key, required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => ListView.separated(
          separatorBuilder: (_, __) => SizedBox(height: 30.h),
          padding:
          EdgeInsets.only(top: 30.h, bottom: 30.h, right: 60.w, left: 60.w),
          shrinkWrap: true,
          itemCount: controller.mobileList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            if(controller.mobileList[index].isLiked ?? false) {
              return CommonMobileItem(
                  image: controller.mobileList[index].thumbImageURL ?? '',
                  title: controller.mobileList[index].name ?? '',
                  description: controller.mobileList[index].description ?? '',
                  price: controller.mobileList[index].price.toString() ?? '',
                  rating: controller.mobileList[index].rating.toString() ?? '',
                  isLiked: controller.mobileList[index].isLiked ?? false,
                  callback: () {
                    controller.mobileList[index].isLiked =
                    !(controller.mobileList[index].isLiked ?? false);
                    controller.mobileList.refresh();
                  });
            } else {
              return const Offstage();
            }
          }),
    );
  }
}

class NormalTab extends StatelessWidget {
  const NormalTab({Key? key, required this.controller}) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView.separated(
          separatorBuilder: (_, __) => SizedBox(height: 30.h),
          padding:
              EdgeInsets.only(top: 30.h, bottom: 30.h, right: 60.w, left: 60.w),
          shrinkWrap: true,
          itemCount: controller.mobileList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => CommonMobileItem(
              image: controller.mobileList[index].thumbImageURL ?? '',
              title: controller.mobileList[index].name ?? '',
              description: controller.mobileList[index].description ?? '',
              price: controller.mobileList[index].price.toString() ?? '',
              rating: controller.mobileList[index].rating.toString() ?? '',
              isLiked: controller.mobileList[index].isLiked ?? false,
              callback: () {
                controller.mobileList[index].isLiked =
                    !(controller.mobileList[index].isLiked ?? false);
                controller.mobileList.refresh();
              })),
    );
  }
}

class CommonMobileItem extends StatelessWidget {
  const CommonMobileItem(
      {Key? key,
      required this.image,
      required this.title,
      required this.description,
      required this.price,
      required this.rating,
      required this.isLiked,
      required this.callback})
      : super(key: key);

  final String image;
  final String title;
  final String description;
  final String price;
  final String rating;
  final bool isLiked;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.w),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(color: Colors.black, width: 1.w)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          CachedNetworkImage(
            fit: BoxFit.contain,
            imageUrl: image,
            width: 400.w,
            progressIndicatorBuilder: (_, __, ___) =>
                const CircularProgressIndicator(),
          ),
          SizedBox(width: 30.w),
          Expanded(
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.w700, fontSize: 60.sp)),
                    Text('Price : $price ₹',
                        style: TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 60.sp)),
                    Text(
                      'Rating : $rating',
                      style: TextStyle(
                          fontSize: 60.sp, fontWeight: FontWeight.w500),
                    ),
                    Text('Description : $description',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 60.sp),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis),
                  ],
                ),
                Positioned(
                  right: 10.w,
                  top: 10.h,
                  child: GestureDetector(
                    onTap: callback,
                    child: isLiked
                          ? const Icon(Icons.favorite,
                              size: 20, color: Colors.red)
                          : const Icon(Icons.favorite_border_outlined,
                              size: 20, color: Colors.red),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
