part of 'main.dart';

// ═══════════════════════════════════════════════════════
// SPLASH SCREEN
// ═══════════════════════════════════════════════════════
class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkInit();
  }

  Future<void> _checkInit() async {
    // Artificial delay to show the splash screen
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    final licenseStatus = await LicenseService.validateLicense();
    // Trial and valid license both allow access; expired trial or others redirect to activation
    if (licenseStatus != LicenseStatus.valid && licenseStatus != LicenseStatus.trial) {
      if (mounted) context.go('/activation');
      return;
    }

    // Daily auto-backup using user-configured folder
    try {
      final settings = ref.read(settingsProvider);
      await BackupService.createDailyBackupIfNeeded(
        destDir: settings.autoBackupDestFolder.isEmpty ? null : settings.autoBackupDestFolder,
      );
    } catch (_) {}

    final initState = ref.read(initProvider);
    if (initState.isLoading) {
      await Future.delayed(const Duration(milliseconds: 500));
    }

    if (!mounted) return;

    final updatedInitState = ref.read(initProvider);
    if (updatedInitState.hasAdmin) {
      context.go('/login');
    } else {
      context.go('/setup');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // ── Deep dark gradient background ──────────────────
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0F172A), // Slate 900
                  Color(0xFF020617), // Slate 950
                ],
              ),
            ),
          ),

          // ── Ambient glow — top right blue ───────────────────
          Positioned(
            top: -120, right: -120,
            child: Container(
              width: 420, height: 420,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  const Color(0xFF1E40AF).withAlpha(70),
                  Colors.transparent,
                ]),
              ),
            ),
          ),

          // ── Ambient glow — bottom left purple ───────────────
          Positioned(
            bottom: -160, left: -160,
            child: Container(
              width: 480, height: 480,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  const Color(0xFF6D28D9).withAlpha(50),
                  Colors.transparent,
                ]),
              ),
            ),
          ),

          // ── Ambient glow — center warm golden pulse ──────────
          Center(
            child: Container(
              width: 300, height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  const Color(0xFFD97706).withAlpha(18),
                  Colors.transparent,
                ]),
              ),
            ),
          ),

          // ── Centered content ─────────────────────────────────
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Outer glowing halo ring
                Container(
                  width: 170, height: 170,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(colors: [
                      const Color(0xFF38BDF8).withAlpha(30),
                      Colors.transparent,
                    ]),
                  ),
                  child: Center(
                    // Inner glassmorphic card with logo
                    child: Container(
                      width: 130, height: 130,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(32),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withAlpha(22),
                            Colors.white.withAlpha(8),
                          ],
                        ),
                        border: Border.all(
                          color: Colors.white.withAlpha(35),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF38BDF8).withAlpha(40),
                            blurRadius: 30,
                            spreadRadius: 2,
                            offset: const Offset(0, 8),
                          ),
                          BoxShadow(
                            color: Colors.black.withAlpha(80),
                            blurRadius: 20,
                            offset: const Offset(0, 12),
                          ),
                        ],
                      ),
                      // ─── Actual Logo Image ──────────────────
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ).animate()
                    .scale(duration: 900.ms, curve: Curves.easeOutBack)
                    .fadeIn(duration: 600.ms),

                const SizedBox(height: 40),

                // Restaurant & Cafe text
                const Text(
                  'Restaurant & Cafe',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 3,
                    height: 1,
                  ),
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.25, curve: Curves.easeOut),

                const SizedBox(height: 6),

                // Management Software subtitle
                const Text(
                  'M A N A G E M E N T   S O F T W A R E',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF38BDF8),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 4,
                  ),
                ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.25, curve: Curves.easeOut),

                const SizedBox(height: 14),

                // Thin divider line
                Container(
                  width: 60, height: 1.5,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.transparent,
                      const Color(0xFF38BDF8).withAlpha(180),
                      Colors.transparent,
                    ]),
                  ),
                ).animate().fadeIn(delay: 650.ms).scaleX(begin: 0),

                const SizedBox(height: 14),

                // Tagline
                Text(
                  'Premium Hospitality Solutions',
                  style: TextStyle(
                    color: Colors.white.withAlpha(100),
                    fontSize: 12,
                    letterSpacing: 2,
                  ),
                ).animate().fadeIn(delay: 700.ms),

                const SizedBox(height: 80),

                // Loading indicator
                SizedBox(
                  width: 28, height: 28,
                  child: CircularProgressIndicator(
                    color: const Color(0xFF38BDF8).withAlpha(200),
                    strokeWidth: 2,
                  ),
                ).animate().fadeIn(delay: 1000.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════
// SETUP WIZARD SCREEN
// ═══════════════════════════════════════════════════════
class SetupWizardScreen extends ConsumerStatefulWidget {
  const SetupWizardScreen({super.key});
  @override
  ConsumerState<SetupWizardScreen> createState() => _SetupWizardScreenState();
}

class _SetupWizardScreenState extends ConsumerState<SetupWizardScreen> {
  int _currentStep = 0;
  bool _isLoading = false;

  // Step 1: Business Details
  final _resName = TextEditingController();
  final _resPhone = TextEditingController();
  final _resEmail = TextEditingController();
  final _resAddress = TextEditingController();
  final _resTax = TextEditingController();
  String? _logoPath;

  // Step 2: Admin Details
  final _adminName = TextEditingController();
  final _adminUser = TextEditingController();
  final _adminPass = TextEditingController();
  final _adminPassConf = TextEditingController();
  bool _obscurePass = true;
  bool _obscurePassConf = true;

  @override
  void dispose() {
    _resName.dispose(); _resPhone.dispose(); _resEmail.dispose();
    _resAddress.dispose(); _resTax.dispose();
    _adminName.dispose(); _adminUser.dispose();
    _adminPass.dispose(); _adminPassConf.dispose();
    super.dispose();
  }

  Future<void> _pickLogo() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      final savedPath = await AppPaths.copyToMedia(file.path, prefix: 'logo');
      setState(() => _logoPath = savedPath);
    }
  }

  void _next() {
    if (_currentStep == 0) {
      if (_resName.text.trim().isEmpty) {
        showError(context, 'Restaurant Name is required');
        return;
      }
      setState(() => _currentStep = 1);
    } else if (_currentStep == 1) {
      _finishSetup();
    }
  }

  void _back() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  Future<void> _finishSetup() async {
    if (_adminName.text.trim().isEmpty || _adminUser.text.trim().isEmpty || _adminPass.text.isEmpty) {
      showError(context, 'All admin fields are required');
      return;
    }
    if (_adminPass.text != _adminPassConf.text) {
      showError(context, 'Passwords do not match');
      return;
    }
    if (_adminPass.text.length < 6) {
      showError(context, 'Password must be at least 6 characters');
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(initProvider.notifier).completeSetup(
        resName: _resName.text.trim(),
        resPhone: _resPhone.text.trim(),
        resEmail: _resEmail.text.trim(),
        resAddress: _resAddress.text.trim(),
        resTaxNumber: _resTax.text.trim(),
        resLogo: _logoPath,
        adminName: _adminName.text.trim(),
        adminUsername: _adminUser.text.trim(),
        adminPassword: _adminPass.text,
      );
      
      if (mounted) {
        showSuccess(context, 'Setup Complete! Please log in.');
        context.go('/login');
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) showError(context, 'Setup failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Restaurant & Cafe Management Setup'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: OutlinedButton.icon(
              icon: const Icon(Icons.restore_rounded, size: 16),
              label: const Text('Restore from Backup'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF1E293B),
                side: const BorderSide(color: Color(0xFFCBD5E1)),
              ),
              onPressed: () async {
                try {
                  final result = await FilePicker.platform.pickFiles(
                    type: FileType.custom,
                    allowedExtensions: ['zip', 'rpb'],
                  );
                  if (result == null || result.files.single.path == null) return;

                  final path = result.files.single.path!;

                  if (!context.mounted) return;
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (ctx) => const Center(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircularProgressIndicator(),
                              SizedBox(height: 16),
                              Text('Restoring backup, please wait...'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );

                  final success = await BackupService.restoreBackup(
                    path,
                    onBeforeRestore: () async {
                      await ref.read(dbProvider).close();
                    },
                  );

                  if (context.mounted) {
                    Navigator.of(context).pop(); // close dialog
                  }

                  if (success) {
                    ref.invalidate(dbProvider);
                    ref.invalidate(settingsProvider);
                    ref.invalidate(initProvider);

                    if (context.mounted) {
                      showSuccess(context, 'Backup restored successfully!');
                      context.go('/login');
                    }
                  } else {
                    if (context.mounted) {
                      showError(context, 'Failed to restore backup.');
                    }
                  }
                } catch (e) {
                  if (context.mounted) {
                    showError(context, 'Restore failed: $e');
                  }
                }
              },
            ),
          )
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: AppCard(
            margin: const EdgeInsets.symmetric(vertical: 32),
            padding: EdgeInsets.zero,
            child: Theme(
              data: Theme.of(context).copyWith(
                colorScheme: Theme.of(context).colorScheme.copyWith(
                  primary: const Color(0xFF1A56DB),
                ),
              ),
              child: Stepper(
                currentStep: _currentStep,
                onStepContinue: _next,
                onStepCancel: _back,
                controlsBuilder: (context, details) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 32),
                    child: Row(
                      children: [
                        if (_currentStep == 1)
                          OutlinedButton(
                            onPressed: _isLoading ? null : details.onStepCancel,
                            child: const Text('Back'),
                          ),
                        if (_currentStep == 1) const SizedBox(width: 16),
                        Expanded(
                          child: FilledButton(
                            onPressed: _isLoading ? null : details.onStepContinue,
                            child: _isLoading 
                              ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                              : Text(_currentStep == 1 ? 'Complete Setup' : 'Next Step'),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                steps: [
                  Step(
                    title: const Text('Business Details', style: TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: const Text('Enter your restaurant or cafe information'),
                    isActive: _currentStep >= 0,
                    state: _currentStep > 0 ? StepState.complete : StepState.indexed,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Center(
                          child: GestureDetector(
                            onTap: _pickLogo,
                            child: Container(
                              width: 120, height: 120,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: const Color(0xFFCBD5E1), style: BorderStyle.solid),
                              ),
                              child: _logoPath != null
                                ? ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.file(File(AppPaths.resolve(_logoPath!)), fit: BoxFit.cover),
                                  )
                                : const Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(Icons.add_a_photo, color: Color(0xFF94A3B8), size: 32),
                                      SizedBox(height: 8),
                                      Text('Add Logo', style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12)),
                                    ],
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        TextField(
                          controller: _resName,
                          decoration: const InputDecoration(labelText: 'Restaurant / Cafe Name *', prefixIcon: Icon(Icons.storefront)),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(child: TextField(
                              controller: _resPhone,
                              decoration: const InputDecoration(labelText: 'Contact Number', prefixIcon: Icon(Icons.phone)),
                            )),
                            const SizedBox(width: 16),
                            Expanded(child: TextField(
                              controller: _resEmail,
                              decoration: const InputDecoration(labelText: 'Email Address', prefixIcon: Icon(Icons.email)),
                            )),
                          ],
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _resAddress,
                          decoration: const InputDecoration(labelText: 'Physical Address', prefixIcon: Icon(Icons.location_on)),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _resTax,
                          decoration: const InputDecoration(labelText: 'Tax Number (Optional)', prefixIcon: Icon(Icons.receipt)),
                        ),
                      ],
                    ),
                  ),
                  Step(
                    title: const Text('Primary Admin Account', style: TextStyle(fontWeight: FontWeight.w700)),
                    subtitle: const Text('Create the system administrator'),
                    isActive: _currentStep >= 1,
                    state: _currentStep > 1 ? StepState.complete : StepState.indexed,
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        TextField(
                          controller: _adminName,
                          decoration: const InputDecoration(labelText: 'Full Name *', prefixIcon: Icon(Icons.badge)),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _adminUser,
                          decoration: const InputDecoration(labelText: 'Admin Username / Email *', prefixIcon: Icon(Icons.person)),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _adminPass,
                          obscureText: _obscurePass,
                          decoration: InputDecoration(
                            labelText: 'Secure Password *',
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePass ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                              onPressed: () => setState(() => _obscurePass = !_obscurePass),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        TextField(
                          controller: _adminPassConf,
                          obscureText: _obscurePassConf,
                          decoration: InputDecoration(
                            labelText: 'Confirm Password *',
                            prefixIcon: const Icon(Icons.lock_reset),
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePassConf ? Icons.visibility_outlined : Icons.visibility_off_outlined),
                              onPressed: () => setState(() => _obscurePassConf = !_obscurePassConf),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ActivationScreen extends ConsumerStatefulWidget {
  const ActivationScreen({super.key});

  @override
  ConsumerState<ActivationScreen> createState() => _ActivationScreenState();
}

class _ActivationScreenState extends ConsumerState<ActivationScreen> {
  final _keyCtrl = TextEditingController();
  String _machineId = 'Loading...';
  String? _error;
  bool _loading = true;
  bool _activating = false;
  LicenseStatus? _status;
  int _trialDaysLeft = 7;

  @override
  void initState() {
    super.initState();
    _load();
  }

  @override
  void dispose() {
    _keyCtrl.dispose();
    super.dispose();
  }

  Future<void> _load() async {
    final id = await LicenseService.getMachineId();
    final status = await LicenseService.validateLicense();
    final daysLeft = await LicenseService.getTrialDaysLeft();
    if (!mounted) return;
    setState(() {
      _machineId = id;
      _status = status;
      _trialDaysLeft = daysLeft;
      _loading = false;
    });
  }

  Future<void> _activate() async {
    if (_keyCtrl.text.trim().isEmpty || _activating) return;
    setState(() {
      _activating = true;
      _error = null;
    });

    final ok = await LicenseService.activate(_keyCtrl.text.trim());
    if (!mounted) return;

    if (!ok) {
      setState(() {
        _activating = false;
        _error = 'Invalid activation key for this machine.';
      });
      return;
    }

    final initState = ref.read(initProvider);
    if (initState.isLoading) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
    if (!mounted) return;

    final updatedInitState = ref.read(initProvider);
    context.go(updatedInitState.hasAdmin ? '/login' : '/setup');
  }

  Future<void> _startTrial() async {
    setState(() => _loading = true);
    await LicenseService.startTrial();
    if (!mounted) return;
    final initState = ref.read(initProvider);
    if (initState.isLoading) {
      await Future.delayed(const Duration(milliseconds: 500));
    }
    if (!mounted) return;
    final updatedInitState = ref.read(initProvider);
    context.go(updatedInitState.hasAdmin ? '/login' : '/setup');
  }

  @override
  Widget build(BuildContext context) {
    final trialExpired = _status == LicenseStatus.trialExpired;
    final showTrial = !trialExpired && _status != LicenseStatus.valid;

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF0F172A), Color(0xFF020617)],
              ),
            ),
          ),
          Positioned(
            top: -130, right: -100,
            child: Container(
              width: 420, height: 420,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  const Color(0xFF1E40AF).withAlpha(70), Colors.transparent,
                ]),
              ),
            ),
          ),
          Positioned(
            bottom: -150, left: -150,
            child: Container(
              width: 460, height: 460,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [
                  const Color(0xFFD97706).withAlpha(45), Colors.transparent,
                ]),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 540),
                child: Container(
                  padding: const EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(18),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(color: Colors.white.withAlpha(45), width: 0.8),
                    boxShadow: [BoxShadow(color: Colors.black.withAlpha(80), blurRadius: 36, offset: const Offset(0, 18))],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Logo icon
                      Center(
                        child: Container(
                          width: 74, height: 74,
                          decoration: BoxDecoration(
                            color: const Color(0xFF60A5FA).withAlpha(28),
                            shape: BoxShape.circle,
                            border: Border.all(color: const Color(0xFF60A5FA).withAlpha(80)),
                          ),
                          child: const Icon(Icons.restaurant_rounded, color: Colors.white, size: 40),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text('Restaurant Management System',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        trialExpired ? 'Trial Expired — Activate Now' : 'Activate Software',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white.withAlpha(190), fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 24),

                      // Trial banner
                      if (showTrial && _trialDaysLeft > 0) ...[
                        Container(
                          padding: const EdgeInsets.all(18),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              const Color(0xFFD97706).withAlpha(50),
                              const Color(0xFFF59E0B).withAlpha(20),
                            ]),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: const Color(0xFFD97706).withAlpha(80)),
                          ),
                          child: Column(children: [
                            const Icon(Icons.timer_outlined, color: Color(0xFFF59E0B), size: 42),
                            const SizedBox(height: 10),
                            Text('$TRIAL_DAYS-Day Free Trial',
                              style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w800)),
                            const SizedBox(height: 6),
                            Text('$_trialDaysLeft day${_trialDaysLeft == 1 ? '' : 's'} remaining',
                              style: TextStyle(color: const Color(0xFFFCD34D), fontSize: 14)),
                            const SizedBox(height: 14),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton.icon(
                                onPressed: _loading ? null : _startTrial,
                                icon: _loading
                                    ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                    : const Icon(Icons.play_arrow_rounded),
                                label: Text(_loading ? 'Starting...' : 'Start Free Trial'),
                                style: FilledButton.styleFrom(
                                  backgroundColor: const Color(0xFFD97706),
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                ),
                              ),
                            ),
                          ]),
                        ),
                        const SizedBox(height: 20),
                        Row(children: [
                          Expanded(child: Divider(color: Colors.white.withAlpha(50))),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Text('OR', style: TextStyle(color: Colors.white.withAlpha(150))),
                          ),
                          Expanded(child: Divider(color: Colors.white.withAlpha(50))),
                        ]),
                        const SizedBox(height: 20),
                      ],

                      // Trial expired message
                      if (trialExpired)
                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.red.withAlpha(30),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.redAccent.withAlpha(80)),
                          ),
                          child: const Row(children: [
                            Icon(Icons.error_outline, color: Colors.redAccent, size: 22),
                            SizedBox(width: 10),
                            Expanded(child: Text('Your 7-day trial has ended. Please enter a valid activation key to continue.',
                              style: TextStyle(color: Colors.white, fontSize: 13))),
                          ]),
                        ),
                      if (trialExpired) const SizedBox(height: 18),

                      // Contact developer
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white.withAlpha(14),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white.withAlpha(35)),
                        ),
                        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                          const Text('Developer', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700)),
                          const SizedBox(height: 6),
                          Text('Engr. Hamza Asad', style: TextStyle(color: Colors.white.withAlpha(215), fontSize: 13)),
                          Text('WhatsApp: 03357981318', style: TextStyle(color: Colors.white.withAlpha(215), fontSize: 13)),
                          const SizedBox(height: 8),
                          Text('Send this Machine ID below to the developer to receive your activation key.',
                            style: TextStyle(color: Colors.white.withAlpha(170), fontSize: 12),
                          ),
                        ]),
                      ),
                        const SizedBox(height: 18),

                      // Machine ID
                      Text('Machine ID', style: TextStyle(color: Colors.white.withAlpha(210), fontWeight: FontWeight.w700, fontSize: 13)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.black.withAlpha(70),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white.withAlpha(40)),
                        ),
                        child: Row(children: [
                          Expanded(
                            child: SelectableText(_machineId,
                              style: const TextStyle(color: Colors.white, fontFamily: 'monospace', fontSize: 16,
                                fontWeight: FontWeight.w700, letterSpacing: 1.2),
                            ),
                          ),
                          TextButton.icon(
                            onPressed: _loading ? null : () async {
                              await Clipboard.setData(ClipboardData(text: _machineId));
                              if (mounted) showSuccess(context, 'Machine ID copied');
                            },
                            icon: const Icon(Icons.copy_rounded, size: 16),
                            label: const Text('Copy'),
                          ),
                        ]),
                      ),
                      const SizedBox(height: 16),

                      // Activation key input
                      TextField(
                        controller: _keyCtrl,
                        minLines: 2,
                        maxLines: 4,
                        style: const TextStyle(fontFamily: 'monospace'),
                        decoration: const InputDecoration(
                          labelText: 'Activation Key (XXXX-XXXX-XXXX-XXXX)',
                          prefixIcon: Icon(Icons.vpn_key_rounded),
                        ),
                      ),
                      if (_error != null) ...[
                        const SizedBox(height: 10),
                        Text(_error!, style: const TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w600)),
                      ],
                      const SizedBox(height: 20),
                      Row(children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => windowManager.close(),
                            icon: const Icon(Icons.close_rounded),
                            label: const Text('Exit'),
                            style: OutlinedButton.styleFrom(foregroundColor: Colors.white),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: FilledButton.icon(
                            onPressed: _loading || _activating ? null : _activate,
                            icon: _activating
                                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                                : const Icon(Icons.verified_user_rounded),
                            label: Text(_activating ? 'Activating...' : 'Activate'),
                          ),
                        ),
                      ]),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const TRIAL_DAYS = 7;
