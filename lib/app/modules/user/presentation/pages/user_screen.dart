import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/user_base_entity.dart';
import '../riverpod/user_notifier.dart';

class UserScreen extends ConsumerWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "U S E R",
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
      body: buildUserWithFutureBuilder(),
    );
  }

  Widget buildUserWithFutureBuilder() {
    return Consumer(builder: (_, ref, child) {
      // final user = ref.watch(userProvider);
      final userNotifier = ref.read(userProvider.notifier);
      return FutureBuilder<List<UserBaseEntity>>(
        future: userNotifier.handleUserFuture(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('No users found.');
          } else {
            final users = snapshot.data;
            return RefreshIndicator.adaptive(
              onRefresh: () async {
                await userNotifier.handleUserFuture();
              },
              child: ListView.builder(
                itemCount: users?.length,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  final user = users?[index];
                  return Card(
                    child: ListTile(
                      title: Text(user?.name ?? ''),
                      subtitle: Text(user?.email ?? ''),
                    ),
                  );
                },
              ),
            );
          }
        },
      );
    });
  }
}
