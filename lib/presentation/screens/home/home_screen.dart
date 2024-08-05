import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:procom_kas/common/widgets/bottom_navigation.dart';
import 'package:procom_kas/data/states/navigation_state.dart';
import 'package:procom_kas/presentation/screens/history/history_screen.dart';
import 'package:procom_kas/presentation/screens/movie/movie_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navigationState = ref.watch(navigationProvider);
    final List<Widget> pages = [
      const MovieScreen(),
      const HistoryScreen(),
    ];

    return Scaffold(
      body: pages[navigationState],
      bottomNavigationBar: const BottomNavigation(),
    );
  }
}
