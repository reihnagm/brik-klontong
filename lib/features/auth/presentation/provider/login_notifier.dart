import 'package:brik/common/helpers/enum.dart';
import 'package:brik/common/helpers/storage.dart';
import 'package:brik/features/auth/domain/usecases/login.dart';
import 'package:brik/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginNotifier with ChangeNotifier {
  final LoginUseCase loginUseCase;

  LoginNotifier({
    required this.loginUseCase
  });

  late TextEditingController emailC;
  late TextEditingController passC; 

  ProviderState _state = ProviderState.idle;
  ProviderState get state => _state;

  String _message = "";
  String get message => _message;

  void setStateProvider(ProviderState newState) {
    _state = newState;

    notifyListeners();
  }

  Future<void> login() async {
    setStateProvider(ProviderState.loading);

    if(emailC.text.trim() == "") {
      ShowSnackbar.snackbarErr("Field email is required");
      return;
    }

    if(passC.text.trim() == "") {
      ShowSnackbar.snackbarErr("Field password is required");
      return;
    }

    final result = await loginUseCase.execute(
      email: emailC.text, 
      password: passC.text
    );

    result.fold((l) {
      _message = l.message;
      setStateProvider(ProviderState.error);

    }, (r) {
      StorageHelper.saveToken(token: r.data.token);
      StorageHelper.saveUser(r.data.user);

      setStateProvider(ProviderState.loaded);
    });

  }

}