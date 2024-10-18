import 'package:examen_cmo/widgets/cat_list_model.dart';
import 'package:flutter/material.dart';

class CategoryFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CatListModel category;
  bool isUpdateMode;

  CategoryFormProvider(this.category, {this.isUpdateMode = false});

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
