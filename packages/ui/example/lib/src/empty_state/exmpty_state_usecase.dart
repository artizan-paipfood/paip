import 'package:flutter/material.dart';
import 'package:ui/ui.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart';

@UseCase(name: 'InTable', type: UiEmptyState)
Widget emptyStateInTable(BuildContext context) {
  return _base(
    child: UiEmptyState.intable(
        icon: const Icon(Icons.search),
        color: Colors.grey,
        title: 'No tracked events for this Source',
        subtitle: 'Events appear when the Source starts sending data to Segment about your users and their activity.',
        action: UiButton.link(
          child: const Text('Learn more'),
          onTap: () {},
        )),
  );
}

@UseCase(name: 'Non Table', type: UiEmptyState)
Widget emptyStateInList(BuildContext context) {
  return _base(
    child: UiEmptyState.nonTable(
      icon: const Icon(Icons.lock),
      color: Colors.orange,
      subtitle: 'You need permission for these sources',
      title: 'To see these sources, request access.',
      action: UiButton(
        onTap: () {},
        child: const Text('List Action'),
      ),
    ),
  );
}

@UseCase(name: 'Small', type: UiEmptyState)
Widget emptyStateInCard(BuildContext context) {
  return _base(
    child: UiEmptyState.small(
      icon: const Icon(Icons.lock),
      color: Colors.orange,
      subtitle: 'You need permission for these sources',
      title: 'To see these sources, request access.',
      action: UiButton(
        onTap: () {},
        child: const Text('Request Access'),
      ),
    ),
  );
}

@UseCase(name: 'Minimal', type: UiEmptyState)
Widget emptyStateMinimal(BuildContext context) {
  return _base(
    child: const UiEmptyState.minimal(
      icon: Icon(Icons.touch_app_rounded),
      color: Colors.grey,
      title: 'No event selected',
    ),
  );
}

Widget _base({required Widget child}) {
  return Scaffold(
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Center(
        child: child,
      ),
    ),
  );
}
