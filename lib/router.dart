import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:with_todo/core/common/components/navigation_bar.dart';
import 'package:with_todo/features/calendar/calendar_screen.dart';
import 'package:with_todo/features/settings/setting_screen.dart';
import 'package:with_todo/features/todo/todo_screen.dart';

part 'router.g.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter router(RouterRef ref) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      routes: [
        ShellRoute(
            navigatorKey: _shellNavigatorKey,
            pageBuilder: (context, state, child) {
              return NoTransitionPage(
                child: NaviBarScreen(
                  location: state.matchedLocation,
                  child: child,
                ),
              );
            },
            routes: [
              GoRoute(
                path: '/',
                name: CalendarScreen.routeName,
                pageBuilder: (context, state) => NoTransitionPage(
                  child: CalendarScreen(),
                ),
              ),
              GoRoute(
                path: '/todo',
                pageBuilder: (context, state) => NoTransitionPage(
                  child: TodoScreen(),
                ),
              ),
              GoRoute(
                path: '/settings',
                pageBuilder: (context, state) => NoTransitionPage(
                  child: SettingScreen(),
                ),
              ),
            ])

        // GoRoute(
        //     path: '/programguide',
        //     pageBuilder: (context, state) => NoTransitionPage(
        //           child: ProgramGuideScreen(),
        //         ),
        //     routes: [
        //       GoRoute(
        //         path: 'programdetail/:index',
        //         name: ProgramDetailScreen.routeName,
        //         pageBuilder: (context, state) => NoTransitionPage(
        //           child: ProgramDetailScreen(
        //               index: state.pathParameters['index']!),
        //         ),
        //       )
        //     ]),
      ],
    );
