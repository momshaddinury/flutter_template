import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/base/result.dart';
import '../../../../core/di/dependency_injection.dart';
import 'pagination_state.dart';

part 'users_provider.g.dart';

@riverpod
class Users extends _$Users {
  @override
  PaginationState build() {
    return const PaginationState(
      users: [],
      total: 0,
      skip: 0,
      limit: 5,
      isLoading: false,
    );
  }

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (state.isLoading) return;

    // If not refreshing and no more users to load, return
    if ((!isRefresh && !state.hasMoreUsers)) return;

    final limit = state.limit;
    final pageNumber = isRefresh ? 1 : state.page + 1;
    final skip = (pageNumber - 1) * limit;

    state = state.copyWith(isLoading: true, error: null);

    final useCase = ref.read(getUsersUseCaseProvider);
    final result = await useCase.call(skip: skip, limit: limit);

    result.when(
      success: (response) {
        if (response == null) return;
        final newUsers = isRefresh
            ? response.users ?? []
            : [...state.users, ...?response.users];

        state = state.copyWith(
          users: newUsers,
          total: response.total ?? 0,
          skip: skip,
          isLoading: false,
        );
      },
      error: (failure) {
        state = state.copyWith(isLoading: false, error: failure.message);
      },
    );
  }

  Future<void> loadMore() async {
    await fetchUsers();
  }
}
