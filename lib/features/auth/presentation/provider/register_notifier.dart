import 'package:brik/snackbar.dart';
import 'package:flutter/material.dart';

import 'package:brik/common/helpers/enum.dart';
import 'package:brik/common/helpers/storage.dart';
import 'package:brik/features/auth/domain/usecases/register.dart';

class RegisterNotifier with ChangeNotifier {
  final RegisterUseCase registerUseCase;

  RegisterNotifier({
    required this.registerUseCase
  });

  late TextEditingController fullnameC;
  late TextEditingController emailC;
  late TextEditingController passwordC;

  ProviderState _state = ProviderState.loading;
  ProviderState get state => _state;

  String _message = "";
  String get message => _message;

  void setStateProvider(ProviderState newState) {
    _state = newState;
    
    notifyListeners();
  }

  Future<void> register() async {
    setStateProvider(ProviderState.loading);
    try {

      if(fullnameC.text.trim() == "") {
        ShowSnackbar.snackbarErr("Field fullname is required");
        return;
      }

      if(emailC.text.trim() == "") {
        ShowSnackbar.snackbarErr("Field email is required");
        return;
      }

      if(passwordC.text.trim() == "") {
        ShowSnackbar.snackbarErr("Field password is required");
        return;
      }
      
      final result = await registerUseCase.execute(
        fullname: fullnameC.text,
        email: emailC.text, 
        password: passwordC.text
      );

      result.fold((l) {
        setStateProvider(ProviderState.error);
        _message = l.message;
      }, (r) {

        StorageHelper.saveToken(token: r.data.token);
        StorageHelper.saveUser(r.data.user);

        setStateProvider(ProviderState.loaded);
      });

    } catch(e) {
      debugPrint(e.toString());
      setStateProvider(ProviderState.error);
    }

  }

}