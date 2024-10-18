import 'package:examen_cmo/widgets/widgets.dart';
import 'package:flutter/material.dart';

class ProveedorFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProvListModel proveedor;
  bool isUpdateMode;

  ProveedorFormProvider(this.proveedor, {this.isUpdateMode = false});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
