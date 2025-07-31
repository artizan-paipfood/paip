import 'package:flutter/material.dart';

class NavigationToUsecase {
  PageController pageController;
  NavigationToUsecase({required this.pageController});

  call({required int index}) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
