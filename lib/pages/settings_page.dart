import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final mode = ref.watch(themeModeProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Settings")),
      body: Column(
        children: ThemeMode.values.map((m) {
          return SizedBox.shrink();
          // return RadioListTile<ThemeMode>(
          //   value: m,
          //   groupValue: mode,
          //   title: Text(m.toString().split(".").last),
          // onChanged: (v) => ref.read(themeModeProvider.notifier).state = v!,
          //   );
        }).toList(),
      ),
    );
  }
}
