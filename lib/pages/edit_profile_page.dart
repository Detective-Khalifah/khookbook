import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../providers/auth_provider.dart';

class EditProfilePage extends HookConsumerWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          TextButton(
            onPressed: () {
              // Save profile changes
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage: null, // Add user image here
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    radius: 18,
                    child: Icon(
                      Icons.camera_alt,
                      size: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Text('Basic Info', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Display Name',
              hintText: 'Enter your display name',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Bio',
              hintText: 'Tell us about yourself',
            ),
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          Text('Social', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              labelText: 'Instagram Username',
              prefixText: '@',
            ),
          ),
        ],
      ),
    );
  }
}
