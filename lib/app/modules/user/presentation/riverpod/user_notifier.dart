import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/helpers/my_app_logger.dart';
import '../../../../core/services/service_api_result_type.dart';
import '../../data/repository/user_repository_impl.dart';
import '../../domain/entities/user_base_entity.dart';

class UserNotifier extends StateNotifier<List<UserBaseEntity>> {
  UserNotifier() : super([]);
  UserRepositoryImpl userRepositoryImpl = UserRepositoryImpl();

  Future<List<UserBaseEntity>> handleUserFuture() async {
    try {
      final response = await userRepositoryImpl.getUser();
      if (response.result == ApiResultType.success) {
        final data = response.data as List<UserBaseEntity>;
        return data;
      } else {
        MyAppLogger.logError("${response.message}");
        return [];
      }
    } catch (e) {
      MyAppLogger.logError("$e");
      return [];
    }
  }
}

final userProvider =
    StateNotifierProvider<UserNotifier, List<UserBaseEntity>>((ref) {
  return UserNotifier();
});
