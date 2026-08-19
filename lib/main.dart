// ═══════════════════════════════════════════════════════
// MAIN + ROUTER + SHARED WIDGETS
// ═══════════════════════════════════════════════════════

// ── main.dart ─────────────────────────────────────────
import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
import 'package:intl/intl.dart';
import 'package:window_manager/window_manager.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'package:file_picker/file_picker.dart';

import 'data/datasources/database.dart';
import 'domain/entities.dart';
import 'app_state.dart';
import 'core/theme/app_theme.dart';
import 'core/print_service.dart';
import 'core/utils/app_paths.dart';
import 'core/utils/backup_service.dart';
import 'core/utils/license_service.dart';

part 'screens_floor_pos.dart';
part 'screens_kitchen_menu_customers.dart';
part 'screens_employees_reports_register_settings.dart';
part 'screens_setup.dart';

// Manager (order-taking role) is limited to operational screens:
// floor/POS, kitchen, register, customers (loans) and staff attendance/salary.
bool _canManagerAccess(String loc) =>
    loc == '/dashboard' ||
    loc == '/floor' || loc == '/pos' || loc.startsWith('/pos/') ||
    loc == '/kitchen' ||
    loc == '/cash-register' ||
    loc == '/customers' ||
    loc == '/employees';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppPaths.init();
  await LicenseService.init();
  await windowManager.ensureInitialized();
  await windowManager.waitUntilReadyToShow(
    const WindowOptions(
      size: Size(1440, 900),
      minimumSize: Size(1024, 720),
      center: true,
      title: 'Restaurant Management v2',
    ),
    () async { await windowManager.show(); await windowManager.focus(); },
  );
  runApp(const ProviderScope(child: RestaurantPOSApp()));
}

class RestaurantPOSApp extends ConsumerWidget {
  const RestaurantPOSApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final auth = ref.watch(authProvider);

    // Configure print service when settings change
    ref.listen(settingsProvider, (_, s) => PrintService.instance.configure(s));
    ref.listen(dbProvider, (_, db) => PrintService.instance.setDatabase(db));
    PrintService.instance.setDatabase(ref.read(dbProvider));
    PrintService.instance.configure(ref.read(settingsProvider));

    final router = GoRouter(
      initialLocation: '/splash',
      redirect: (ctx, state) {
        final loc = state.matchedLocation;
        // Allowed unauthenticated routes
        if (loc == '/splash' || loc == '/setup' || loc == '/activation') return null;

        final loggedIn = auth.isLoggedIn;
        final onLogin = loc == '/login';

        // Not logged in → go through splash so license is checked
        if (!loggedIn && !onLogin) return '/splash';
        if (loggedIn && onLogin) return '/dashboard';

        // Role-based access: manager may only take orders (floor/POS)
        final user = auth.user;
        if (user != null && user.role == UserRole.manager && !_canManagerAccess(loc)) {
          return '/dashboard';
        }
        return null;
      },
      routes: [
        GoRoute(path: '/splash', builder: (_, __) => const SplashScreen()),
        GoRoute(path: '/activation', builder: (_, __) => const ActivationScreen()),
        GoRoute(path: '/setup', builder: (_, __) => const SetupWizardScreen()),
        GoRoute(path: '/login', builder: (_, __) => const LoginScreen()),
        GoRoute(path: '/dashboard', builder: (_, __) => const DashboardScreen()),
        GoRoute(path: '/floor', builder: (_, __) => const FloorScreen()),
        GoRoute(
          path: '/pos/:tableId',
          builder: (_, state) => POSScreen(tableId: int.parse(state.pathParameters['tableId']!)),
        ),
        GoRoute(path: '/kitchen', builder: (_, __) => const KitchenScreen()),
        GoRoute(path: '/menu-mgmt', builder: (_, __) => const MenuManagementScreen()),
        GoRoute(path: '/customers', builder: (_, __) => const CustomersScreen()),
        GoRoute(path: '/employees', builder: (_, __) => const EmployeesScreen()),
        GoRoute(path: '/reports', builder: (_, __) => const ReportsScreen()),
        GoRoute(path: '/expenses', builder: (_, __) => const ExpenseTrackerScreen()),
        GoRoute(path: '/cash-register', builder: (_, __) => const CashRegisterScreen()),
        GoRoute(path: '/settings', builder: (_, __) => const SettingsScreen()),
      ],
    );

    return MaterialApp.router(
      title: 'Restaurant Management',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeMode,
      routerConfig: router,
    );
  }
}

// ═══════════════════════════════════════════════════════
// SHARED WIDGETS
// ═══════════════════════════════════════════════════════

// ── Side Nav Rail ─────────────────────────────────────
class SideNav extends ConsumerWidget {
  const SideNav({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = GoRouterState.of(context).matchedLocation;
    final isDark = context.isDark;
    final cs = context.cs;
    final user = ref.watch(authProvider).user;

    final items = [
      (Icons.dashboard_rounded, 'Dashboard', '/dashboard'),
      (Icons.table_restaurant_rounded, 'Tables', '/floor'),
      (Icons.kitchen_rounded, 'Kitchen', '/kitchen'),
      (Icons.restaurant_menu_rounded, 'Menu', '/menu-mgmt'),
      (Icons.people_alt_rounded, 'Customers', '/customers'),
      (Icons.badge_rounded, 'Staff', '/employees'),
      (Icons.bar_chart_rounded, 'Reports', '/reports'),
      (Icons.receipt_long_rounded, 'Expenses', '/expenses'),
      (Icons.point_of_sale_rounded, 'Register', '/cash-register'),
    ].where((it) =>
        user == null ||
        user.role != UserRole.manager ||
        _canManagerAccess(it.$3)).toList();

    return Row(children: [
      Container(
        width: 68,
        color: isDark ? const Color(0xFF0A1628) : const Color(0xFF1A56DB),
        child: Column(children: [
          const SizedBox(height: 12),
          // Logo
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(25),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.restaurant, color: Colors.white, size: 26),
          ),
          const SizedBox(height: 16),
          // Nav items
          Expanded(
            child: ListView(children: items.map((item) {
              final (icon, label, route) = item;
              final sel = loc.startsWith(route);
              return Tooltip(
                message: label,
                preferBelow: false,
                waitDuration: const Duration(milliseconds: 300),
                child: GestureDetector(
                  onTap: () => context.go(route),
                  child: Container(
                    width: 50, height: 50,
                    margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
                    decoration: BoxDecoration(
                      color: sel ? Colors.white.withAlpha(30) : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      border: sel ? Border.all(color: Colors.white.withAlpha(60), width: 0.5) : null,
                    ),
                    child: Icon(icon, color: sel ? Colors.white : Colors.white.withAlpha(150), size: 22),
                  ),
                ),
              );
            }).toList()),
          ),
          // Close App Button (Exit Terminal)
          Tooltip(
            message: 'Exit App',
            preferBelow: false,
            child: GestureDetector(
              onTap: () async {
                if (!await ensureNoOpenOrders(context, ref)) return;
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: const Text('Exit App'),
                    content: const Text('Are you sure you want to close the application?'),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                      FilledButton(
                        style: FilledButton.styleFrom(backgroundColor: Colors.red),
                        onPressed: () => Navigator.pop(ctx, true),
                        child: const Text('Exit'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await windowManager.close();
                }
              },
              child: Container(
                width: 50, height: 44, margin: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                child: const Icon(Icons.power_settings_new_rounded,
                    color: Colors.redAccent, size: 20),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // User avatar
          GestureDetector(
            onTap: () => _showUserMenu(context, ref),
            child: Container(
              width: 40, height: 40, margin: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(30),
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withAlpha(60)),
              ),
              child: Center(child: Text(
                user?.name.substring(0, 1).toUpperCase() ?? 'U',
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
              )),
            ),
          ),
        ]),
      ),
      Expanded(child: child),
    ]);
  }

  void _showUserMenu(BuildContext context, WidgetRef ref) {
    final user = ref.read(authProvider).user;
    showDialog(context: context, builder: (_) => AlertDialog(
      title: Text(user?.name ?? 'User'),
      content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(user?.email ?? '', style: Theme.of(context).textTheme.bodySmall),
        Text('Role: ${user?.role.name}', style: Theme.of(context).textTheme.bodySmall),
      ]),
      actions: [
        FilledButton(onPressed: () => Navigator.pop(context), child: const Text('Close')),
      ],
    ));
  }
}

// ── Top bar quick actions (full screen / theme / logout) ──
class TopBarActions extends ConsumerWidget {
  const TopBarActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = context.isDark;
    final user = ref.watch(authProvider).user;
    final isManager = user?.role == UserRole.manager;
    return Row(mainAxisSize: MainAxisSize.min, children:[
      // Full screen toggle
      Tooltip(
        message: 'Toggle Full Screen',
        child: IconButton(
          icon: const Icon(Icons.fullscreen_rounded),
          onPressed: () async {
            final isFullScreen = await windowManager.isFullScreen();
            await windowManager.setFullScreen(!isFullScreen);
          },
        ),
      ),
      // Theme toggle
      Tooltip(
        message: 'Toggle Theme',
        child: IconButton(
          icon: Icon(isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded),
          onPressed: () => ref.read(themeModeProvider.notifier).toggle(),
        ),
      ),
      // Settings (hidden for manager role)
      if (!isManager)
      Tooltip(
        message: 'Settings',
        child: IconButton(
          icon: const Icon(Icons.settings_rounded),
          onPressed: () => context.go('/settings'),
        ),
      ),
      // Logout
      Tooltip(
        message: 'Logout',
        child: IconButton(
          icon: const Icon(Icons.logout_rounded),
          onPressed: () async {
            if (!await ensureNoOpenOrders(context, ref)) return;
            final ok = await showDialog<bool>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to log out?'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                  FilledButton(
                    style: FilledButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () => Navigator.pop(ctx, true),
                    child: const Text('Logout'),
                  ),
                ],
              ),
            );
            if (ok == true && context.mounted) {
              await ref.read(authProvider.notifier).logout();
              if (context.mounted) context.go('/login');
            }
          },
        ),
      ),
    ]);
  }
}

// ── Reusable card ─────────────────────────────────────
class AppCard extends StatelessWidget {
  const AppCard({super.key, required this.child, this.padding = const EdgeInsets.all(16),
    this.margin, this.onTap, this.color});
  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: color ?? context.cardBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: context.border, width: 0.5),
        ),
        child: child,
      ),
    );
  }
}

// ── Currency display ──────────────────────────────────
class AmtText extends ConsumerWidget {
  const AmtText(this.amount, {super.key, this.style, this.decimals = 0});
  final double amount;
  final TextStyle? style;
  final int decimals;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sym = ref.watch(settingsProvider).currencySymbol;
    return Text('$sym ${amount.toStringAsFixed(decimals)}', style: style);
  }
}

// ── Top notification overlay (compact, non-intrusive) ──
void _showNotif(BuildContext ctx, String msg, Color bg, IconData icon) {
  final overlay = Overlay.of(ctx);
  late OverlayEntry entry;
  entry = OverlayEntry(builder: (_) => Positioned(
    top: 12, left: 40, right: 40,
    child: Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: bg, borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          Icon(icon, color: Colors.white, size: 15),
          const SizedBox(width: 6),
          Flexible(child: Text(msg, style: const TextStyle(color: Colors.white, fontSize: 12))),
        ]),
      ),
    ),
  ));
  overlay.insert(entry);
  Future.delayed(const Duration(seconds: 2), () { entry.remove(); });
}

void showSuccess(BuildContext ctx, String msg) =>
  _showNotif(ctx, msg, AppColors.success, Icons.check_circle);

void showError(BuildContext ctx, String msg) =>
  _showNotif(ctx, msg, AppColors.error, Icons.error_outline);

// ── Open orders guard ──────────────────────────────────
// Blocks logout/exit while any order is still open for a table.
Future<bool> ensureNoOpenOrders(BuildContext ctx, WidgetRef ref) async {
  final List<OrderEntity> orders;
  try {
    orders = await ref.read(activeOrdersProvider.future);
  } catch (_) {
    return true;
  }
  final openCount = orders.where((o) => o.status != OrderStatus.paid && o.status != OrderStatus.cancelled).length;
  if (openCount > 0) {
    await showDialog<void>(context: ctx, builder: (_) => AlertDialog(
      icon: const Icon(Icons.receipt_long_rounded, color: Colors.orange, size: 34),
      title: const Text('Open orders pending'),
      content: Text(openCount == 1
          ? 'There is 1 open order on a table. Complete it before logging out.'
          : 'There are $openCount open orders on tables. Complete them all before logging out.'),
      actions: [FilledButton(onPressed: () => Navigator.pop(_), child: const Text('OK'))],
    ));
    return false;
  }
  return true;
}

// ── Confirmation dialog ───────────────────────────────
Future<bool> confirm(BuildContext ctx, String title, String msg, {bool danger = false}) async {
  return await showDialog<bool>(context: ctx, builder: (_) => AlertDialog(
    title: Text(title),
    content: Text(msg),
    actions: [
      TextButton(onPressed: () => Navigator.pop(_, false), child: const Text('Cancel')),
      FilledButton(
        onPressed: () => Navigator.pop(_, true),
        style: danger ? FilledButton.styleFrom(backgroundColor: Colors.red) : null,
        child: const Text('Confirm'),
      ),
    ],
  )) ?? false;
}

// ═══════════════════════════════════════════════════════
// LOGIN SCREEN
// ═══════════════════════════════════════════════════════
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});
  @override ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _pass = TextEditingController();
  bool _obscure = true;

  @override void dispose() { _pass.dispose(); super.dispose(); }

  Future<void> _login() async {
    if (_pass.text.isEmpty) return;
    final ok = await ref.read(authProvider.notifier).login(_pass.text);
    if (ok && mounted) context.go('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider);
    final isDark = context.isDark;
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Attractive gradient background
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter, end: Alignment.bottomCenter,
                colors: isDark
                    ? const [Color(0xFF0A1628), Color(0xFF16244A), Color(0xFF1A56DB)]
                    : const [Color(0xFFEFF6FF), Color(0xFFDBEAFE), Color(0xFFBFDBFE)],
              ),
            ),
          ),
          // Decorative circles
          Positioned(top: -120, left: -120, child: Container(
            width: 340, height: 340,
            decoration: BoxDecoration(
              color: (isDark ? Colors.white : const Color(0xFF1A56DB)).withAlpha(10),
              shape: BoxShape.circle,
            ),
          )),
          Positioned(bottom: -160, right: -160, child: Container(
            width: 420, height: 420,
            decoration: BoxDecoration(
              color: (isDark ? Colors.white : const Color(0xFF1A56DB)).withAlpha(8),
              shape: BoxShape.circle,
            ),
          )),
          Positioned(top: 120, right: 40, child: Container(
            width: 90, height: 90,
            decoration: BoxDecoration(
              color: (isDark ? Colors.white : const Color(0xFF0EA5E9)).withAlpha(10),
              shape: BoxShape.circle,
            ),
          )),
          // Centered login card
          Center(child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Container(
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 32),
                decoration: BoxDecoration(
                  color: context.cardBg,
                  borderRadius: BorderRadius.circular(26),
                  border: Border.all(color: context.border, width: 0.5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(isDark ? 40 : 18),
                      blurRadius: 40, spreadRadius: 2, offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Centered logo
                    Center(child: Container(
                      width: 96, height: 96,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft, end: Alignment.bottomRight,
                          colors: [Color(0xFF1A56DB), Color(0xFF0EA5E9)],
                        ),
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(color: const Color(0xFF1A56DB).withAlpha(60), blurRadius: 24, offset: const Offset(0, 8)),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: settings.logoPath != null && settings.logoPath!.isNotEmpty
                            ? Image.file(File(AppPaths.resolve(settings.logoPath!)), fit: BoxFit.contain)
                            : const Icon(Icons.restaurant, color: Colors.white, size: 44),
                      ),
                    ).animate().scale(duration: 600.ms, curve: Curves.elasticOut)),
                    const SizedBox(height: 22),
                    // Bold restaurant name
                    Text(
                      settings.name.isNotEmpty ? settings.name : 'Restaurant Management',
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: context.cs.onSurface,
                        fontSize: 27,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -0.5,
                        height: 1.15,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Secure order terminal',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 13),
                    ),
                    const SizedBox(height: 30),
                    // Password only
                    TextField(
                      controller: _pass,
                      autofocus: true,
                      obscureText: _obscure,
                      onSubmitted: (_) => _login(),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded, size: 18),
                        suffixIcon: IconButton(
                          icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 18),
                          onPressed: () => setState(() => _obscure = !_obscure),
                        ),
                      ),
                    ),
                    const SizedBox(height: 14),
                    if (state.error != null)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.red.withAlpha(15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(children: [
                            const Icon(Icons.error_outline, color: Colors.red, size: 18),
                            const SizedBox(width: 8),
                            Expanded(child: Text(state.error!, style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w600))),
                          ]),
                        ),
                      ),
                    SizedBox(
                      height: 50,
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF1A56DB),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: state.isLoading ? null : _login,
                        child: state.isLoading
                            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                            : const Text('Sign In', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                      ),
                    ).animate().fadeIn(delay: 250.ms),
                    const SizedBox(height: 12),
                    Text(
                      'Admin and Manager access by password',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: context.cs.onSurfaceVariant, fontSize: 11),
                    ),
                  ],
                ),
              ),
            ),
          )),
          // Floating control buttons in top right
          Positioned(
            top: 24,
            right: 24,
            child: Row(
              children: [
                Tooltip(
                  message: 'Toggle Full Screen',
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withAlpha(20) : Colors.black.withAlpha(10),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.fullscreen_rounded, color: isDark ? Colors.white70 : Colors.black54),
                      onPressed: () async {
                        final isFullScreen = await windowManager.isFullScreen();
                        await windowManager.setFullScreen(!isFullScreen);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Tooltip(
                  message: 'Exit App',
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? Colors.white.withAlpha(20) : Colors.black.withAlpha(10),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Icon(Icons.close_rounded, color: isDark ? Colors.redAccent.withAlpha(200) : Colors.red),
                      onPressed: () async {
                        final confirm = await showDialog<bool>(
                          context: context,
                          builder: (ctx) => AlertDialog(
                            title: const Text('Exit App'),
                            content: const Text('Are you sure you want to close the application?'),
                            actions: [
                              TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('Cancel')),
                              FilledButton(
                                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                                onPressed: () => Navigator.pop(ctx, true),
                                child: const Text('Exit'),
                              ),
                            ],
                          ),
                        );
                        if (confirm == true) {
                          await windowManager.close();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// DASHBOARD SCREEN
// ═══════════════════════════════════════════════════════
class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tables = ref.watch(tablesProvider);
    final orders = ref.watch(activeOrdersProvider);
    final register = ref.watch(registerProvider);
    final settings = ref.watch(settingsProvider);

    return SideNav(child: Scaffold(
      body: CustomScrollView(slivers: [
        SliverAppBar(
          pinned: true, floating: true,
          title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(settings.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
            Text('${DateFormat('EEEE, d MMM yyyy').format(DateTime.now())}  •  Live dashboard',
              style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant, fontWeight: FontWeight.w400)),
          ]),
          actions: [
            if (register == null)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: FilledButton.icon(
                  icon: const Icon(Icons.lock_open, size: 16),
                  label: const Text('Open Register'),
                  onPressed: () => context.go('/cash-register'),
                  style: FilledButton.styleFrom(backgroundColor: Colors.orange),
                ),
              )
            else if (register != null)
              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Chip(
                  avatar: const Icon(Icons.circle, color: Colors.green, size: 10),
                  label: Text('Register Open — ${settings.currencySymbol} ${register.expectedCash.toStringAsFixed(0)}'),
                ),
              ),
            const TopBarActions(),
          ],
        ),

        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(delegate: SliverChildListDelegate([
            // ── Trial Banner ─────────────────────────
            _TrialBanner(),
            const SizedBox(height: 12),
            // ── KPI Row ──────────────────────────────
            _KPIRow(tables: tables, orders: orders, register: register),
            const SizedBox(height: 20),

            // ── Table Overview + Quick Actions ────────
            Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Expanded(flex: 7, child: _TableOverview(tables: tables)),
              const SizedBox(width: 16),
              Expanded(flex: 3, child: _QuickActions()),
            ]),
            const SizedBox(height: 16),

            // ── Active Orders ─────────────────────────
            _ActiveOrdersList(orders: orders),
          ])),
        ),
      ]),
    ));
  }
}

class _TrialBanner extends ConsumerStatefulWidget {
  @override
  _TrialBannerState createState() => _TrialBannerState();
}

class _TrialBannerState extends ConsumerState<_TrialBanner> {
  LicenseStatus? _status;
  int? _daysLeft;
  bool _loaded = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _load();
  }

  Future<void> _load() async {
    final status = await LicenseService.validateLicense();
    final daysLeft = await LicenseService.getTrialDaysLeft();
    if (mounted) setState(() { _status = status; _daysLeft = daysLeft; _loaded = true; });
  }

  @override
  Widget build(BuildContext context) {
    if (!_loaded || _status != LicenseStatus.trial || _daysLeft == null) return const SizedBox.shrink();

    final urgent = _daysLeft! <= 2;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: urgent ? Colors.red.shade50 : Colors.amber.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: urgent ? Colors.red.shade300 : Colors.amber.shade300),
      ),
      child: Row(
        children: [
          Icon(urgent ? Icons.warning_amber_rounded : Icons.schedule, color: urgent ? Colors.red.shade700 : Colors.amber.shade700, size: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Trial mode — $_daysLeft day${_daysLeft == 1 ? '' : 's'} remaining',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: urgent ? Colors.red.shade800 : Colors.amber.shade900,
              ),
            ),
          ),
          TextButton.icon(
            icon: const Icon(Icons.vpn_key, size: 14),
            label: const Text('Activate', style: TextStyle(fontSize: 12)),
            onPressed: () => context.go('/activation'),
            style: TextButton.styleFrom(
              foregroundColor: urgent ? Colors.red.shade800 : Colors.amber.shade900,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}

class _KPIRow extends ConsumerWidget {
  const _KPIRow({required this.tables, required this.orders, required this.register});
  final AsyncValue<List<TableEntity>> tables;
  final AsyncValue<List<OrderEntity>> orders;
  final CashRegisterEntity? register;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final occupied = tables.valueOrNull?.where((t) => t.isOccupied).length ?? 0;
    final available = tables.valueOrNull?.where((t) => t.isAvailable).length ?? 0;
    final total = tables.valueOrNull?.length ?? 0;
    final runningOrders = orders.valueOrNull?.where((o) => o.status != OrderStatus.paid && o.status != OrderStatus.cancelled).length ?? 0;
    final totalSales = register?.totalSales ?? 0;
    final kitchenPending = orders.valueOrNull?.where((o) => o.status == OrderStatus.kitchenSent).length ?? 0;

    final kpis = [
      _KPI('Today Sales', '${ref.watch(settingsProvider).currencySymbol} ${totalSales.toStringAsFixed(0)}', Icons.trending_up_rounded, const Color(0xFF1A56DB)),
      _KPI('Active Orders', '$runningOrders', Icons.receipt_long_rounded, const Color(0xFFD97706)),
      _KPI('Tables Occupied', '$occupied / $total', Icons.table_restaurant_rounded, const Color(0xFFDC2626)),
      _KPI('Tables Available', '$available', Icons.check_circle_outline_rounded, const Color(0xFF16A34A)),
      _KPI('Kitchen Queue', '$kitchenPending orders', Icons.kitchen_rounded, const Color(0xFF7C3AED)),
      _KPI('Cash in Drawer', '${ref.watch(settingsProvider).currencySymbol} ${(register?.expectedCash ?? 0).toStringAsFixed(0)}', Icons.payments_rounded, const Color(0xFF0EA5E9)),
    ];

    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: kpis.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (_, i) => _KPICard(kpi: kpis[i])
          .animate(delay: Duration(milliseconds: i * 50)).fadeIn().slideX(begin: 0.05),
      ),
    );
  }
}

// ignore: must_be_immutable
class _KPICard extends StatelessWidget with _WatchSettingsMixin {
  const _KPICard({required this.kpi});
  final _KPI kpi;

  @override
  Widget build(BuildContext context) {
    final isDark = context.isDark;
    return Container(
      width: 190,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: context.border, width: 0.5),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
          width: 38, height: 38,
          decoration: BoxDecoration(color: kpi.color.withAlpha(25), borderRadius: BorderRadius.circular(10)),
          child: Icon(kpi.icon, color: kpi.color, size: 20),
        ),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(kpi.value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: context.cs.onSurface)),
          Text(kpi.label, style: TextStyle(fontSize: 12, color: context.cs.onSurfaceVariant)),
        ]),
      ]),
    );
  }
}

mixin _WatchSettingsMixin {}

class _KPI {
  const _KPI(this.label, this.value, this.icon, this.color);
  final String label, value;
  final IconData icon;
  final Color color;
}

class _TableOverview extends ConsumerWidget {
  const _TableOverview({required this.tables});
  final AsyncValue<List<TableEntity>> tables;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = tables.valueOrNull ?? [];
    return AppCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text('Tables', style: context.tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const Spacer(),
          TextButton.icon(
            icon: const Icon(Icons.open_in_full, size: 14),
            label: const Text('Full view'),
            onPressed: () => context.go('/floor'),
          ),
        ]),
        const SizedBox(height: 6),
        // Legend
        Row(children: [
          _Legend(AppColors.tableAvailable, 'Available'),
          const SizedBox(width: 12),
          _Legend(AppColors.tableOccupied, 'Occupied'),
          const SizedBox(width: 12),
          _Legend(AppColors.tableReserved, 'Reserved'),
          const SizedBox(width: 12),
          _Legend(AppColors.tableCleaning, 'Cleaning'),
        ]),
        const SizedBox(height: 12),
        // Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 110, childAspectRatio: 1.3, crossAxisSpacing: 8, mainAxisSpacing: 8,
          ),
          itemCount: list.length,
          itemBuilder: (_, i) {
            final t = list[i];
            final color = _tColor(t.status);
            return GestureDetector(
              onTap: () {
                if (t.isAvailable) {
                  _showGuestCountDialog(context, ref, t);
                } else if (t.activeOrderId != null) {
                  context.go('/pos/${t.id}');
                }
              },
              onSecondaryTapDown: (details) => _showTableContextMenu(context, details.globalPosition, t, ref),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  color: color.withAlpha(25),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: color.withAlpha(120), width: 1.5),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(t.name, style: TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: color)),
                  if (t.isOccupied && t.runningTotal > 0)
                    Text('${ref.watch(settingsProvider).currencySymbol} ${t.runningTotal.toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 10, color: color.withAlpha(200))),
                  if (t.waiterName != null)
                    Text(t.waiterName!.split(' ').first, style: TextStyle(fontSize: 9, color: color.withAlpha(160))),
                  const SizedBox(height: 3),
                  Container(width: 7, height: 7, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                ]),
              ),
            );
          },
        ),
      ]),
    );
  }

  Color _tColor(TableStatus s) => switch (s) {
    TableStatus.available => AppColors.tableAvailable,
    TableStatus.occupied  => AppColors.tableOccupied,
    TableStatus.reserved  => AppColors.tableReserved,
    TableStatus.cleaning  => AppColors.tableCleaning,
  };

  void _showTableContextMenu(BuildContext context, Offset globalPosition, TableEntity table, WidgetRef ref) {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(
        globalPosition.dx,
        globalPosition.dy,
        globalPosition.dx + 1,
        globalPosition.dy + 1,
      ),
      items: const [
        PopupMenuItem<String>(
          value: 'available',
          child: Row(children: [
            Icon(Icons.check_circle_outline, color: AppColors.tableAvailable, size: 18),
            SizedBox(width: 8),
            Text('Set Available'),
          ]),
        ),
        PopupMenuItem<String>(
          value: 'reserved',
          child: Row(children: [
            Icon(Icons.bookmark_outline, color: AppColors.tableReserved, size: 18),
            SizedBox(width: 8),
            Text('Set Reserved'),
          ]),
        ),
        PopupMenuItem<String>(
          value: 'cleaning',
          child: Row(children: [
            Icon(Icons.cleaning_services_outlined, color: AppColors.tableCleaning, size: 18),
            SizedBox(width: 8),
            Text('Set Cleaning'),
          ]),
        ),
      ],
    ).then((value) async {
      if (value == null) return;
      final db = ref.read(dbProvider);
      if (value == 'available') {
        await db.tableDao.freeTable(table.id);
      } else {
        await db.tableDao.freeTable(table.id);
        await db.tableDao.setStatus(table.id, value);
      }
    });
  }

  void _showGuestCountDialog(BuildContext context, WidgetRef ref, TableEntity table) {
    int count = 2;
    final waiterCtrl = TextEditingController();
    final staffList = ref.read(staffProvider).valueOrNull ?? [];
    // Pre-fill with logged-in user's name
    waiterCtrl.text = ref.read(authProvider).user?.name ?? '';

    showDialog(context: context, builder: (_) => StatefulBuilder(builder: (ctx, setS) => AlertDialog(
      title: Row(children: [
        const Icon(Icons.table_restaurant_rounded, size: 22),
        const SizedBox(width: 10),
        Text('Open ${table.name}'),
      ]),
      content: SizedBox(width: 380, child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Waiter / Server name:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Row(children: [
          Expanded(
            child: TextField(
              controller: waiterCtrl,
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(
                hintText: 'e.g. Ahmed',
                prefixIcon: Icon(Icons.badge_outlined, size: 18),
                isDense: true,
              ),
              onChanged: (_) => setS(() {}),
            ),
          ),
          if (staffList.isNotEmpty) ...[
            const SizedBox(width: 8),
            PopupMenuButton<String>(
              tooltip: 'Pick from staff',
              icon: const Icon(Icons.people_alt_outlined),
              onSelected: (name) => setS(() => waiterCtrl.text = name),
              itemBuilder: (_) => staffList.map((u) => PopupMenuItem(
                value: u.name,
                child: Row(children: [
                  CircleAvatar(radius: 14, child: Text(u.name[0].toUpperCase(), style: const TextStyle(fontSize: 12))),
                  const SizedBox(width: 8),
                  Text(u.name),
                ]),
              )).toList(),
            ),
          ],
        ]),
        const SizedBox(height: 20),
        const Text('Number of guests:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
        const SizedBox(height: 12),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          IconButton(icon: const Icon(Icons.remove_circle_outline), iconSize: 28,
            onPressed: count > 1 ? () => setS(() => count--) : null),
          SizedBox(width: 60, child: Center(child: Text('$count', style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w700)))),
          IconButton(icon: const Icon(Icons.add_circle_outline), iconSize: 28,
            onPressed: () => setS(() => count++)),
        ]),
      ])),
      actions: [
        TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
        FilledButton(
          onPressed: () async {
            Navigator.pop(ctx);
            final waiterName = waiterCtrl.text.trim();
            await ref.read(posProvider(table.id).notifier).openTableWithWaiter(
              count, waiterName: waiterName,
            );
            if (context.mounted) context.go('/pos/${table.id}');
          },
          child: const Text('Open Order Terminal'),
        ),
      ],
    )));
  }
}

class _Legend extends StatelessWidget {
  const _Legend(this.color, this.label);
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) => Row(mainAxisSize: MainAxisSize.min, children: [
    Container(width: 10, height: 10, margin: const EdgeInsets.only(right: 4), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3))),
    Text(label, style: const TextStyle(fontSize: 11)),
  ]);
}

class _QuickActions extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final allActions = [
      ('New Order', Icons.add_circle_rounded, '/floor', const Color(0xFF1A56DB)),
      ('Kitchen', Icons.kitchen_rounded, '/kitchen', const Color(0xFFD97706)),
      ('Customers', Icons.people_rounded, '/customers', const Color(0xFF16A34A)),
      ('Reports', Icons.bar_chart_rounded, '/reports', const Color(0xFF7C3AED)),
      ('Expenses', Icons.receipt_long_rounded, '/expenses', const Color(0xFFDC2626)),
      ('Staff', Icons.badge_rounded, '/employees', const Color(0xFFDB2777)),
      ('Register', Icons.point_of_sale_rounded, '/cash-register', const Color(0xFF0EA5E9)),
    ];
    final actions = user?.role == UserRole.manager
        ? allActions.where((a) => _canManagerAccess(a.$3)).toList()
        : allActions;

    return AppCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Quick actions', style: context.tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2, childAspectRatio: 1.1,
          crossAxisSpacing: 8, mainAxisSpacing: 8,
          children: actions.map((a) {
            final (label, icon, route, color) = a;
            return GestureDetector(
              onTap: () => context.go(route),
              child: Container(
                decoration: BoxDecoration(
                  color: color.withAlpha(18),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: color.withAlpha(50), width: 0.5),
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(icon, color: color, size: 26),
                  const SizedBox(height: 5),
                  Text(label, style: TextStyle(fontSize: 12, color: color, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
                ]),
              ),
            );
          }).toList(),
        ),
      ]),
    );
  }
}

class _ActiveOrdersList extends StatelessWidget {
  const _ActiveOrdersList({required this.orders});
  final AsyncValue<List<OrderEntity>> orders;

  @override
  Widget build(BuildContext context) {
    final list = orders.valueOrNull?.where((o) => o.status != OrderStatus.paid && o.status != OrderStatus.cancelled).toList() ?? [];
    if (list.isEmpty) return const SizedBox.shrink();

    return AppCard(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Text('Active orders (${list.length})', style: context.tt.titleMedium?.copyWith(fontWeight: FontWeight.w700)),
          const Spacer(),
          Chip(
            label: const Text('Live'),
            avatar: Container(width: 8, height: 8, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
          ),
        ]),
        const SizedBox(height: 12),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: list.map((o) {
            final color = _oColor(o.status);
            return GestureDetector(
              onTap: () => context.go('/pos/${o.tableId}'),
              child: Container(
                width: 180, margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withAlpha(15), borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: color.withAlpha(80), width: 1),
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(children: [
                    Text(o.tableName, style: TextStyle(fontWeight: FontWeight.w800, color: color, fontSize: 16)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(color: color.withAlpha(25), borderRadius: BorderRadius.circular(5)),
                      child: Text(_oLabel(o.status), style: TextStyle(fontSize: 10, color: color, fontWeight: FontWeight.w600)),
                    ),
                  ]),
                  const SizedBox(height: 4),
                  Text('#${o.orderNumber}', style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant)),
                  Text(o.waiterName, style: TextStyle(fontSize: 11, color: context.cs.onSurfaceVariant)),
                  const SizedBox(height: 6),
                  Text('${o.totalItems} items', style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  Consumer(builder: (_, ref, __) {
                    final sym = ref.watch(settingsProvider).currencySymbol;
                    return Text('$sym ${o.grandTotal.toStringAsFixed(0)}',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: color));
                  }),
                ]),
              ),
            );
          }).toList()),
        ),
      ]),
    );
  }

  Color _oColor(OrderStatus s) => switch (s) {
    OrderStatus.open        => AppColors.orderOpen,
    OrderStatus.hold        => AppColors.tableCleaning,
    OrderStatus.kitchenSent => AppColors.orderKitchen,
    OrderStatus.ready       => AppColors.orderReady,
    OrderStatus.billPrinted => const Color(0xFF7C3AED),
    _                       => AppColors.orderPaid,
  };

  String _oLabel(OrderStatus s) => switch (s) {
    OrderStatus.open        => 'Open',
    OrderStatus.hold        => 'On Hold',
    OrderStatus.kitchenSent => 'Kitchen',
    OrderStatus.ready       => 'Ready',
    OrderStatus.billPrinted => 'Bill Out',
    _                       => 'Paid',
  };
}
