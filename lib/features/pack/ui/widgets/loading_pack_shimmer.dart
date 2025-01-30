import 'package:flutter/material.dart';
import 'package:morostick/core/helpers/spacing.dart';
import 'package:morostick/core/widgets/app_shimmer_loading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StickerPackDetailShimmer extends StatelessWidget {
  const StickerPackDetailShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          verticalSpace(10),
          // Pack info card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: AppShimmerLoading(
              child: Container(
                width: double.infinity,
                height: 125.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.all(12.w),
                child: Row(
                  children: [
                    // Pack icon
                    Container(
                      width: 56.w,
                      height: 56.w,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    horizontalSpace(12),
                    // Pack info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 16.h,
                            width: 150.w,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          verticalSpace(8),
                          Row(
                            children: [
                              Container(
                                height: 12.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(6.r),
                                ),
                              ),
                              horizontalSpace(8),
                              Container(
                                height: 12.h,
                                width: 40.w,
                                decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(6.r),
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
            ),
          ),

          // Author info
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                AppShimmerLoading(
                  child: Container(
                    width: 40.w,
                    height: 40.w,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                horizontalSpace(12),
                AppShimmerLoading(
                  child: Container(
                    height: 14.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(7.r),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Stickers grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 8.h,
                crossAxisSpacing: 8.w,
                childAspectRatio: 1,
              ),
              itemCount: 9, // Show 9 shimmer items
              itemBuilder: (context, index) => AppShimmerLoading(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              ),
            ),
          ),

          // WhatsApp button
          Padding(
            padding: EdgeInsets.all(16.w),
            child: AppShimmerLoading(
              child: Container(
                width: double.infinity,
                height: 48.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
