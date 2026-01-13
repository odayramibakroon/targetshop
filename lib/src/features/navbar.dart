import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetshop/generated/l10n.dart';
import 'package:targetshop/src/features/users/cubit/user_cubit.dart';

import '../core/config/config.dart';
import 'home/presentation/pages/home_page.dart';
import 'cart/presentation/pages/cart_page.dart';
import 'settings/presentation/pages/setting_page.dart';
import 'favorites/presentation/pages/favorites_page.dart';
import 'posts/presentation/pages/posts_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    PostsPage(),
    FavoritesPage(),
    CartPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (context) => getIt<UserCubit>()..loadUser(),
      child: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          items:   [

            BottomNavigationBarItem(icon: Icon(Icons.home), label: S.of(context).home),
            BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: S.of(context).posts),
            BottomNavigationBarItem(icon: Icon(Icons.favorite), label: S.of(context).favorites),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: S.of(context).cart),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: S.of(context).settings),
          ],
        ),
      ),
    );
  }
}
