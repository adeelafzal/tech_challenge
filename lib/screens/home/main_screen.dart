import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_challenge/controller/main_controller.dart';
import 'package:tech_challenge/widgets/video_player_widget.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final List<String> interest = [
    "All",
    "Animals",
    "Football",
    "Funny",
    "Music",
  ];
  final MainController mainController = Get.put(MainController());
  final PageController pageController =
      PageController(initialPage: 0, viewportFraction: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainController.obx(
        (videos) => Stack(
          children: [
            PageView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  VideoPlayerWidget(video: videos[index]),
              itemCount: videos!.length,
              scrollDirection: Axis.vertical,
              controller: pageController,
            ),
            _buildCategories(),
          ],
        ),
        onEmpty: const Text("No videos found."),
        onError: (error) => Text(error!),
      ),
    );
  }

  Widget _buildCategories() {
    return Positioned(
      bottom: 0,
      child: SizedBox(
        height: 80,
        child: ListView.separated(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: interest.length,
            separatorBuilder: (BuildContext context, _) => const SizedBox(
                  width: 16,
                ),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  mainController.isInitialized.value=false;
                  mainController.selectedCategory.value = index;
                  if (index == 0) {
                    mainController.fetchAllVideos();
                  } else {
                    mainController.filterVideoByCategory(
                        category: interest[index]);
                  }
                  pageController.jumpToPage(0);
                },
                child: Obx(
                  () {
                    bool isSelected =
                        mainController.selectedCategory.value == index;
                    return Chip(
                      backgroundColor:
                          isSelected ? Get.theme.primaryColor : Colors.white,
                      label: Text(interest[index]),
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    );
                  },
                ),
              );
            }),
      ),
    );
  }
}
