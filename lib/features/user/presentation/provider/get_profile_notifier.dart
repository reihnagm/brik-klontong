
import 'package:brik/common/helpers/enum.dart';
import 'package:brik/features/user/data/models/user_activity/user_activity.dart';
import 'package:brik/features/user/domain/usecases/get_list_user_activity.dart';

import 'package:flutter/material.dart';

class GetProfileNotifier with ChangeNotifier {

  final GetListUserActivityUseCase getListUserActivityUseCase;

  GetProfileNotifier({
    required this.getListUserActivityUseCase
  });

  List<UserActivityItem> _usersActivityItem = [];
  List<UserActivityItem> get usersActivityItem => [..._usersActivityItem];

  ProviderState _state = ProviderState.loading;
  ProviderState get state => _state;

  String _message = "";
  String get message => _message;

  void setStateProvider(ProviderState newState) {
    _state = newState;

    notifyListeners();
  }

  Future<void> getUserActivity() async {
    final result = await getListUserActivityUseCase.execute();

    result.fold((l) {
      _message = l.message;
      setStateProvider(ProviderState.error);
    }, (r) {
      
      _usersActivityItem = [];
      _usersActivityItem.addAll(r.data);

      setStateProvider(ProviderState.loaded);
    });
  }

}