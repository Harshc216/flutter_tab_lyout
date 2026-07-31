import 'package:flutter/material.dart';
import 'package:flutter_tab_layout_library/flutter_tab_layout_library.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() {
    setState(() {
      _themeMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Modern Tab Layout Playground',
      debugShowCheckedModeBanner: false,
      themeMode: _themeMode,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1E3A8A),
          brightness: Brightness.light,
        ),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0EA5E9),
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: const Color(0xFF0B0F19),
        cardTheme: const CardThemeData(
          color: Color(0xFF1E293B),
        ),
      ),
      home: TabPlayground(
        isDarkMode: _themeMode == ThemeMode.dark,
        onToggleTheme: _toggleTheme,
      ),
    );
  }
}

class TabPlayground extends StatefulWidget {
  final bool isDarkMode;
  final VoidCallback onToggleTheme;

  const TabPlayground({
    super.key,
    required this.isDarkMode,
    required this.onToggleTheme,
  });

  @override
  State<TabPlayground> createState() => _TabPlaygroundState();
}

class _TabPlaygroundState extends State<TabPlayground> {
  final ModernTabController _controller = ModernTabController(length: 3);
  TabStyle _style = TabStyle.gradient;
  TabAnimation _animation = TabAnimation.slideFade;
  bool _isScrollable = false;
  bool _equalWidths = true;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final List<TabItem> tabs = const [
      TabItem(title: 'Dashboard', icon: Icons.dashboard_rounded),
      TabItem(title: 'Analytics', icon: Icons.analytics_rounded, badge: 'New'),
      TabItem(title: 'Profile', icon: Icons.person_outline_rounded),
    ];

    final List<Widget> children = [
      _buildPageContent(
        icon: Icons.dashboard_rounded,
        color: Colors.blue,
        title: 'Main Dashboard View',
        description: 'Configure and test layout parameters in real time. Swiping between pages or clicking tabs shows off responsive indicator slide tracking.',
      ),
      _buildPageContent(
        icon: Icons.analytics_rounded,
        color: Colors.teal,
        title: 'Analytical Data Stats',
        description: 'Observe indicator corner radius and shadow options. Gradient and glass indicators are painted via a shader or translucent outlines.',
      ),
      _buildPageContent(
        icon: Icons.person_outline_rounded,
        color: Colors.indigo,
        title: 'User Profile Account',
        description: 'Native next/prev methods inside ModernTabController can be tested below to advance active index state with animations.',
      ),
    ];

    // Background Gradient for Glassmorphic styling contrast
    final backgroundDecoration = _style == TabStyle.glass
        ? const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF0F172A),
                Color(0xFF1E1B4B),
                Color(0xFF311042),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          )
        : BoxDecoration(
            color: theme.scaffoldBackgroundColor,
          );

    return Scaffold(
      body: Container(
        decoration: backgroundDecoration,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Top Header Panel
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tab Layout Playground',
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: _style == TabStyle.glass ? Colors.white : null,
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        widget.isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
                        color: _style == TabStyle.glass ? Colors.white : null,
                      ),
                      onPressed: widget.onToggleTheme,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Controls Sandbox Card
                _buildControlsCard(isDark),
                const SizedBox(height: 24),

                // Main Live Preview layout
                Expanded(
                  child: ModernTabLayout(
                    tabs: tabs,
                    controller: _controller,
                    style: _style,
                    animation: _animation,
                    isScrollable: _isScrollable,
                    equalWidths: _equalWidths,
                    theme: TabThemeData(
                      backgroundColor: _style == TabStyle.glass
                          ? Colors.white.withAlpha(20)
                          : (isDark ? const Color(0xFF1E293B) : Colors.white),
                      indicatorColor: _style == TabStyle.glass ? Colors.white : theme.colorScheme.primary,
                      selectedTextStyle: TextStyle(
                        color: (_style == TabStyle.pill ||
                                _style == TabStyle.gradient ||
                                _style == TabStyle.glass ||
                                _style == TabStyle.floating)
                            ? Colors.white
                            : (_style == TabStyle.glass ? Colors.white : theme.colorScheme.primary),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      unselectedTextStyle: TextStyle(
                        color: _style == TabStyle.glass
                            ? Colors.white.withAlpha(150)
                            : (isDark ? Colors.white60 : Colors.black54),
                        fontSize: 14,
                      ),
                      elevation: (_style == TabStyle.glass || isDark) ? 0 : 2,
                      borderRadius: BorderRadius.circular(
                        (_style == TabStyle.pill ||
                                _style == TabStyle.gradient ||
                                _style == TabStyle.glass ||
                                _style == TabStyle.floating)
                            ? 30
                            : 12,
                      ),
                    ),
                    children: children,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlsCard(bool isDark) {
    final textStyle = TextStyle(
      color: _style == TabStyle.glass ? Colors.white : null,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _style == TabStyle.glass
            ? Colors.white.withAlpha(15)
            : (isDark ? const Color(0xFF1E293B) : Colors.white),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: _style == TabStyle.glass
              ? Colors.white.withAlpha(25)
              : (isDark ? Colors.white10 : Colors.black12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tab Style', style: TextStyle(fontSize: 12, color: _style == TabStyle.glass ? Colors.white70 : Colors.grey)),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<TabStyle>(
                      initialValue: _style,
                      dropdownColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(),
                      ),
                      items: TabStyle.values.map((style) {
                        return DropdownMenuItem(
                          value: style,
                          child: Text(style.name),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _style = val;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Page Animation', style: TextStyle(fontSize: 12, color: _style == TabStyle.glass ? Colors.white70 : Colors.grey)),
                    const SizedBox(height: 4),
                    DropdownButtonFormField<TabAnimation>(
                      initialValue: _animation,
                      dropdownColor: isDark ? const Color(0xFF1E293B) : Colors.white,
                      style: TextStyle(color: isDark ? Colors.white : Colors.black),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        border: OutlineInputBorder(),
                      ),
                      items: TabAnimation.values.map((anim) {
                        return DropdownMenuItem(
                          value: anim,
                          child: Text(anim.name),
                        );
                      }).toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _animation = val;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Text('Scrollable', style: textStyle),
                  Switch(
                    value: _isScrollable,
                    onChanged: (val) {
                      setState(() {
                        _isScrollable = val;
                      });
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Text('Equal Widths', style: textStyle),
                  Switch(
                    value: _equalWidths,
                    onChanged: _isScrollable
                        ? null
                        : (val) {
                            setState(() {
                              _equalWidths = val;
                            });
                          },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPageContent({
    required IconData icon,
    required Color color,
    required String title,
    required String description,
  }) {
    final isGlass = _style == TabStyle.glass;

    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isGlass ? Colors.white.withAlpha(15) : (Theme.of(context).brightness == Brightness.dark ? const Color(0xFF1E293B) : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isGlass ? Colors.white.withAlpha(20) : (Theme.of(context).brightness == Brightness.dark ? Colors.white10 : Colors.black12),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Icon(icon, size: 28, color: color),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: isGlass ? Colors.white : null,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              description,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: isGlass ? Colors.white70 : (Theme.of(context).brightness == Brightness.dark ? Colors.white60 : Colors.black87),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _controller.previous(),
                  icon: const Icon(Icons.arrow_back_rounded),
                  label: const Text('Prev'),
                ),
                ElevatedButton.icon(
                  onPressed: () => _controller.next(),
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: const Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
