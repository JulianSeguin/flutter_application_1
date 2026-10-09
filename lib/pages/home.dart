import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatelessWidget {
  const Home({
    super.key,
    required this.isDarkMode,
  });

  final ValueNotifier<bool> isDarkMode;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isDarkMode,
      builder: (context, isDarkModeEnabled, child) {
        final theme = isDarkModeEnabled
            ? Theme.of(context)
            : ThemeData(
                brightness: Brightness.light,
                colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.black,
                  brightness: Brightness.light,
                ),
                scaffoldBackgroundColor: Colors.white,
                appBarTheme: const AppBarTheme(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                ),
                textTheme: const TextTheme(
                  bodyMedium: TextStyle(fontSize: 16),
                ),
              );

        return Theme(
          data: theme,
          child: Builder(
            builder: (context) {
              final colorScheme = Theme.of(context).colorScheme;
              return DefaultTabController(
                length: 2,
                child: Scaffold(
                  appBar: AppBar(
                    title: Image.asset(
                      'assets/X.webp',
                      height: 35,
                    ),
                    backgroundColor: colorScheme.surface,
                    centerTitle: true,
                    leading: const Center(
                      child: CircleAvatar(
                        radius: 15,
                        foregroundImage: NetworkImage(
                          'https://avatar.shifaul.dev/random',
                        ),
                      ),
                    ),
                    actions: [
                      IconButton(
                        tooltip: isDarkModeEnabled
                            ? 'Passer en mode clair'
                            : 'Passer en mode sombre',
                        icon: Icon(
                          isDarkModeEnabled
                              ? Icons.light_mode
                              : Icons.dark_mode,
                        ),
                        onPressed: () async {
                          final newMode = !isDarkModeEnabled;
                          try {
                            final preferences =
                                await SharedPreferences.getInstance();
                            await preferences.setBool('isDarkMode', newMode);
                            isDarkMode.value = newMode;
                          } catch (error) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Impossible de sauvegarder le thème : $error',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                    bottom: TabBar(
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      labelColor: colorScheme.onSurface,
                      unselectedLabelColor: colorScheme.onSurfaceVariant,
                      indicatorColor: Colors.blue,
                      dividerColor: colorScheme.outline,
                      dividerHeight: 0.5,
                      tabs: [
                        Tab(text: 'Pour vous'),
                        Tab(text: 'Abonnements'),
                      ],
                    ),
                  ),
                  body: const TabBarView(
                    children: [
                      _FeedView(),
                      _SubscriptionsView(),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _FeedView extends StatelessWidget {
  const _FeedView();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        children: const [
          _PostCard(),
        ],
      ),
    );
  }
}

class _SubscriptionsView extends StatelessWidget {
  const _SubscriptionsView();

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Text(
          'Les publications des comptes auxquels vous êtes abonné apparaîtront ici.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: colorScheme.outlineVariant, width: 0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 19,
            foregroundImage: NetworkImage(
              'https://avatar.shifaul.dev/random',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Marie Dupont',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        '@marie_dupont · 2 h',
                        style: TextStyle(color: colorScheme.onSurfaceVariant),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_horiz,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        visualDensity: VisualDensity.compact,
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Je viens de tester une nouvelle recette de lasagnes aux épinards et ricotta. Un vrai délice, je recommande ! 🍝',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 16,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _PostAction(icon: Icons.comment, count: '42'),
                    _PostAction(icon: Icons.repeat, count: '8'),
                    _PostAction(icon: Icons.favorite_border, count: '156'),
                    _PostAction(
                      icon: Icons.visibility,
                      count: '3,2 k',
                    ),
                    _PostAction(icon: Icons.file_upload_outlined, count: ''),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PostAction extends StatelessWidget {
  const _PostAction({required this.icon, required this.count});

  final IconData icon;
  final String count;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.onSurfaceVariant;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 17, color: color),
        if (count.isNotEmpty) ...[
          const SizedBox(width: 5),
          Text(
            count,
            style: TextStyle(color: color, fontSize: 12),
          ),
        ],
      ],
    );
  }
}
