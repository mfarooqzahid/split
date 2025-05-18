import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:split/features/home/screen/home.dart';
import 'package:split/features/profile/screen/profile.dart';

import 'home/widget/drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late ScrollController _scrollController;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _translateAnimation;

  ValueNotifier currentIndex = ValueNotifier(0);

  late List<Widget> _screen;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    _screen = [
      HomeScreen(scrollController: _scrollController),
      ProfileScreen(scrollController: _scrollController),
    ];
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.6).animate(_animationController);
    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
    _translateAnimation =
        Tween<double>(begin: 0, end: 100).animate(_animationController);
  }

  void _onScroll() {
    if (_scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (_animationController.status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    } else if (_scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (_animationController.status == AnimationStatus.completed) {
        _animationController.reverse();
      }
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    //setStatusBarColor(context);
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (currentIndex.value != 0) {
          currentIndex.value = 0;
        } else {
          SystemNavigator.pop(); // Close the app
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: const HomeDrawer(),
        // appbar
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(56.0),
          child: SafeArea(
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    // open drawer
                    _scaffoldKey.currentState?.openDrawer();
                  },
                  icon: const Icon(CupertinoIcons.line_horizontal_3),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.search),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(CupertinoIcons.bell),
                ),
              ],
            ),
          ),
        ),
        body: GestureDetector(
          // onVerticalDragEnd: (details) {
          //   if (details.primaryVelocity! < 0) {
          //     _animationController.forward();
          //   }

          //   if (details.primaryVelocity! > 0) {
          //     _animationController.reverse();
          //   }
          // },
          child: SafeArea(
            child: Stack(
              children: [
                Positioned.fill(
                  child: ValueListenableBuilder(
                    valueListenable: currentIndex,
                    builder: (context, index, child) {
                      return _screen[index];
                    },
                  ),
                ),
                Positioned(
                  bottom: 20,
                  right: 0,
                  left: 0,
                  child: Center(
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _translateAnimation.value),
                          child: Transform.scale(
                            scale: _scaleAnimation.value,
                            child: Opacity(
                              opacity: _opacityAnimation.value,
                              child: IntrinsicWidth(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: theme.colorScheme.surface,
                                      borderRadius: BorderRadius.circular(60),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 1,
                                        ),
                                      ]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    spacing: 10,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          // setting the current index to 0, set the view to home screen
                                          currentIndex.value = 0;
                                        },
                                        icon: Icon(
                                          CupertinoIcons.home,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ),
                                      FloatingActionButton(
                                        highlightElevation: 0,
                                        onPressed: () {
                                          // go to keypad screen
                                          context.goNamed("amountkeypad");
                                        },
                                        elevation: 0,
                                        child: const Icon(CupertinoIcons.add),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          // setting the current index to 1, set the view to profile screen
                                          currentIndex.value = 1;
                                        },
                                        icon: Icon(
                                          CupertinoIcons.person,
                                          color: theme.colorScheme.onSurface,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
