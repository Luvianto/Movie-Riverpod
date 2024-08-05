import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:procom_kas/data/states/navigation_state.dart';

class BottomNavigation extends ConsumerWidget {
  const BottomNavigation({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationProvider);
    final navigationNotifier = ref.read(navigationProvider.notifier);

    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Movie',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.history),
          label: 'History',
        ),
      ],
      currentIndex: navigationState,
      selectedItemColor: Colors.blue,
      onTap: (index) {
        navigationNotifier.setIndex(index);
      },
    );
  }
}
