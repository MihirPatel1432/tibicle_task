import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:flutterprojectsetup/ui/common/routes.dart';
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
          actions: [
            PopupMenuButton(
                onSelected: (value) {
                  if (value == 1) {
                    controller.mobileList
                        .sort((b, a) => a.price.compareTo(b.price));
                    controller.mobileList.refresh();
                  } else if (value == 2) {
                    controller.mobileList
                        .sort((a, b) => a.price.compareTo(b.price));
                    controller.mobileList.refresh();
                  } else {
                    controller.mobileList.sort(
                        (a, b) => (b.rating ?? 0).compareTo(a.rating ?? 0));
                  }
                },
                itemBuilder: (context) => [
                      const PopupMenuItem(
                          value: 1, child: Text('High to Low Price')),
                      const PopupMenuItem(
                          value: 2, child: Text('Low to High Price')),
                      const PopupMenuItem(
                          value: 3, child: Text('Highest Rating')),
                    ])
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ColoredBox(
              color: Colors.blue[100] ?? Colors.blue,
              child: TabBar(
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
                  ]).paddingOnly(
                  left: 60.w, right: 60.w, bottom: 30.h, top: 30.h),
            ),
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
      () => (controller.mobileList.where((p0) => p0.isLiked == true).isNotEmpty)
          ? ListView.separated(
              separatorBuilder: (_, __) => SizedBox(height: 50.h),
              padding: EdgeInsets.only(
                  top: 30.h, bottom: 30.h, right: 60.w, left: 60.w),
              shrinkWrap: true,
              itemCount: controller.mobileList.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                if (controller.mobileList[index].isLiked ?? false) {
                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => Get.toNamed(RouteName.mobileDetail,
                        arguments: controller.mobileList[index]),
                    child: SwipeActionCell(
                      key: Key(controller.mobileList[index].name ?? 'user'),
                      trailingActions: [
                        SwipeAction(
                          icon: const Icon(Icons.delete),
                            onTap: (value){
                            controller.mobileList[index].isLiked = false;
                            controller.mobileList.refresh();
                            })
                      ],
                      child: CommonMobileItem(
                          image:
                              controller.mobileList[index].thumbImageURL ?? '',
                          title: controller.mobileList[index].name ?? '',
                          description:
                              controller.mobileList[index].description ?? '',
                          price: controller.mobileList[index].price.toString(),
                          rating:
                              controller.mobileList[index].rating.toString(),
                          isLiked:
                              controller.mobileList[index].isLiked ?? false,
                          callback: () {
                            controller.mobileList[index].isLiked =
                                !(controller.mobileList[index].isLiked ??
                                    false);
                            controller.mobileList.refresh();
                          },
                          isFavouriteTab: true),
                    ),
                  );
                } else {
                  return const Offstage();
                }
              })
          : const Center(
              child: Text('No Data Found',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
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
          separatorBuilder: (_, __) => SizedBox(height: 50.h),
          padding:
              EdgeInsets.only(top: 30.h, bottom: 30.h, right: 60.w, left: 60.w),
          shrinkWrap: true,
          itemCount: controller.mobileList.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) => GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => Get.toNamed(RouteName.mobileDetail,
                    arguments: controller.mobileList[index]),
                child: CommonMobileItem(
                    image: controller.mobileList[index].thumbImageURL ?? '',
                    title: controller.mobileList[index].name ?? '',
                    description: controller.mobileList[index].description ?? '',
                    price: controller.mobileList[index].price.toString(),
                    rating: controller.mobileList[index].rating.toString(),
                    isLiked: controller.mobileList[index].isLiked ?? false,
                    callback: () {
                      controller.mobileList[index].isLiked =
                          !(controller.mobileList[index].isLiked ?? false);
                      controller.mobileList.refresh();
                    },
                    isFavouriteTab: false),
              )),
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
      required this.callback,
      required this.isFavouriteTab})
      : super(key: key);

  final String image;
  final String title;
  final String description;
  final String price;
  final String rating;
  final bool isLiked;
  final bool isFavouriteTab;
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
                Visibility(
                  visible: !isFavouriteTab,
                  child: Positioned(
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
