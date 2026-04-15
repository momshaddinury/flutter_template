import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/users_provider.dart';

class UsersPage extends ConsumerStatefulWidget {
  const UsersPage({super.key});

  @override
  ConsumerState<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends ConsumerState<UsersPage> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(usersProvider.notifier).fetchUsers(isRefresh: true);
    });
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(usersProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(usersProvider, (previous, next) {
      if (previous?.isLoading == true &&
          next.isLoading == false &&
          next.error == null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_scrollController.hasClients) {
            if (context.mounted &&
                _scrollController.position.pixels >=
                    _scrollController.position.maxScrollExtent - 200) {
              _onScroll();
            }
          }
        });
      }
    });

    final state = ref.watch(usersProvider);
    final users = state.users;

    return Scaffold(
      appBar: AppBar(title: const Text('Users')),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(usersProvider.notifier).fetchUsers(isRefresh: true),
        child: state.error != null
            ? Center(child: Text(state.error!))
            : users.isEmpty && state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: users.length + (state.hasMoreUsers ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index >= users.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final user = users[index];
                  return ListTile(
                    leading: user.image != null
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(user.image!),
                          )
                        : const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(
                      '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim(),
                    ),
                    subtitle: Text(user.email ?? ''),
                  );
                },
              ),
      ),
    );
  }
}
