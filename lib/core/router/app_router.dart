import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/register_page.dart';
import '../../features/dashboard/presentation/pages/dashboard_page.dart';
import '../../features/patients/presentation/pages/patient_detail_page.dart';
import '../../features/patients/presentation/pages/patients_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/reports/presentation/pages/reports_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../shared/widgets/layouts/auth_layout.dart';
import '../../shared/widgets/layouts/main_layout.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  static final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell');

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: '/dashboard',
    redirect: _redirect,
    routes: [
      // Auth Routes (without shell)
      GoRoute(
        path: '/login',
        name: 'login',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AuthLayout(child: LoginPage()),
          transitionsBuilder: _slideTransition,
        ),
      ),
      GoRoute(
        path: '/register',
        name: 'register',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const AuthLayout(child: RegisterPage()),
          transitionsBuilder: _slideTransition,
        ),
      ),

      // Main App Routes (with shell navigation)
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          // Dashboard Route
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const DashboardPage(),
            ),
          ),

          // Patients Routes
          GoRoute(
            path: '/patients',
            name: 'patients',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const PatientsPage(),
            ),
            routes: [
              GoRoute(
                path: ':patientId',
                name: 'patient-detail',
                pageBuilder: (context, state) {
                  final patientId = state.pathParameters['patientId']!;
                  return CustomTransitionPage(
                    key: state.pageKey,
                    child: PatientDetailPage(patientId: patientId),
                    transitionsBuilder: _slideTransition,
                  );
                },
              ),
            ],
          ),

          // Settings Route
          GoRoute(
            path: '/settings',
            name: 'settings',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const SettingsPage(),
            ),
          ),

          // Reports Route
          GoRoute(
            path: '/reports',
            name: 'reports',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ReportsPage(),
            ),
          ),

          // Profile Route
          GoRoute(
            path: '/profile',
            name: 'profile',
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const ProfilePage(),
            ),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => ErrorPage(error: state.error),
  );

  // Authentication state check using BLoC
  static String? _redirect(BuildContext context, GoRouterState state) {
    try {
      final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
      final authState = authBloc.state;
      
      final isAuthenticated = authState is AuthAuthenticated;
      final isLoggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/register';

      // If not authenticated and not on auth page, redirect to login
      if (!isAuthenticated && !isLoggingIn) {
        return '/login';
      }

      // If authenticated and on auth page, redirect to dashboard
      if (isAuthenticated && isLoggingIn) {
        return '/dashboard';
      }

      // No redirect needed
      return null;
    } catch (e) {
      // If BLoC is not available (app initializing), allow auth pages
      final isLoggingIn = state.matchedLocation == '/login' || state.matchedLocation == '/register';
      return isLoggingIn ? null : '/login';
    }
  }

  // Custom transition animations
  static Widget _slideTransition(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: animation.drive(
        Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(
          CurveTween(curve: Curves.easeInOut),
        ),
      ),
      child: child,
    );
  }

  // Navigation helper methods
  static void goToLogin(BuildContext context) {
    GoRouter.of(context).goNamed('login');
  }

  static void goToRegister(BuildContext context) {
    GoRouter.of(context).goNamed('register');
  }

  static void goToDashboard(BuildContext context) {
    GoRouter.of(context).goNamed('dashboard');
  }

  static void goToPatients(BuildContext context) {
    GoRouter.of(context).goNamed('patients');
  }

  static void goToPatientDetail(BuildContext context, String patientId) {
    GoRouter.of(context).goNamed('patient-detail', pathParameters: {'patientId': patientId});
  }

  static void goToSettings(BuildContext context) {
    GoRouter.of(context).goNamed('settings');
  }

  static void goToReports(BuildContext context) {
    GoRouter.of(context).goNamed('reports');
  }

  static void goToProfile(BuildContext context) {
    GoRouter.of(context).goNamed('profile');
  }

  static void logout(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context, listen: false);
    authBloc.add(LogoutRequested());
    GoRouter.of(context).goNamed('login');
  }
}

// Error page for handling navigation errors
class ErrorPage extends StatelessWidget {
  final Exception? error;

  const ErrorPage({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Something went wrong!',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              error?.toString() ?? 'Unknown error occurred',
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => AppRouter.goToDashboard(context),
              child: const Text('Go to Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}