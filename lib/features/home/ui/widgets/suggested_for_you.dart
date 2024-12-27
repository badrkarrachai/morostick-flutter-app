import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:morostick/features/home/data/models/for_you_tab_response.dart';
import 'package:morostick/features/home/ui/widgets/pack_outside_preview.dart';

class SuggestedForYou extends StatelessWidget {
  final List<StickerPack> suggestedPacks;

  const SuggestedForYou({
    super.key,
    required this.suggestedPacks,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(suggestedPacks.length, (index) {
        final pack = suggestedPacks[index];
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
