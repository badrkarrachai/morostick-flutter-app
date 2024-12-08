import 'package:flutter/material.dart';
import 'package:morostick/features/home/ui/widgets/pack_outside_preview.dart';

class SuggestedForYou extends StatelessWidget {
  const SuggestedForYou({super.key});

  static final List<dynamic> suggestedPacks = [
    {
      "title": "The Best Stickers Pack",
      "author": "Badr Karrachai",
      "userImageUrl":
          "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/Badr2.jpg",
      "downloads": 1000,
      "timeAgo": "1d",
      "stickerPreviews": const [
        "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(6).png",
        "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(2).png",
        "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(3).png",
        "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
        "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(5).png"
      ],
      "onAddPressed": () {}
    },
    {
      "title": "Pidro Tomato Stickers",
      "author": "Badr Karrachai",
      "userImageUrl":
          "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/bdr%20profile.jpg",
      "downloads": 1000,
      "timeAgo": "2w",
      "stickerPreviews": const [
        "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(6).png",
        "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(2).png",
        "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(3).png",
        "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(4).png",
        "https://pub-77ec04db39ef4d8bb8dc21139a0e97e1.r2.dev/stickers/TestStickers/TestStickrs%20(5).png"
      ],
      "onAddPressed": () {}
    }
    // Add more packs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: suggestedPacks.length,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => PackOutsidePreview(
            userImageUrl: suggestedPacks[index]["userImageUrl"],
            title: suggestedPacks[index]["title"],
            author: suggestedPacks[index]["author"],
            downloads: suggestedPacks[index]["downloads"],
            timeAgo: suggestedPacks[index]["timeAgo"],
            stickerPreviews: suggestedPacks[index]["stickerPreviews"],
            onAddPressed: suggestedPacks[index]["onAddPressed"],
          ),
        )
      ],
    );
  }
}
