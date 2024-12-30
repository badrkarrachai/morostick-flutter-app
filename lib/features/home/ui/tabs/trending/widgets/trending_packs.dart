import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:morostick/core/data/models/pack_model.dart';
import 'package:morostick/features/home/ui/widgets/pack_outside_preview.dart';

class TrendingPacks extends StatelessWidget {
  final List<StickerPack> trendingPacks;

  const TrendingPacks({
    super.key,
    required this.trendingPacks,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(trendingPacks.length, (index) {
        final pack = trendingPacks[index];
        final List<String> previewUrls = pack.stickers!
            .take(5)
            .map((sticker) => sticker.webpUrl ?? '')
            .toList();

        final timeAgo = pack.stickers!.isNotEmpty
            ? Jiffy.parseFromDateTime(pack.stickers!.first.createdAt!).fromNow()
            : '';

        return PackOutsidePreview(
          userImageUrl: pack.creator.avatarUrl,
          title: pack.name ?? '',
          author: pack.creator.name ?? '',
          downloads: pack.stats?.downloads ?? 0,
          timeAgo: timeAgo,
          stickerPreviews: previewUrls,
          onAddPressed: () {
            // Implement your add pack logic here
          },
        );
      }),
    );
  }
}
