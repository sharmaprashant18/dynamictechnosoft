// import 'package:dynamictechnosoft/model/form_model.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class FormProvider extends StateNotifier<FormModel>{
//   FormProvider() : super(FormModel());




//   void nameField(String name){
//     state = state.copyWith(name:name);
//   }
//   void emailField(String email){
//     state = state.copyWith(email:email);
//   }
//   void addressField(String address){
//     state = state.copyWith(address:address);
//   }
// void ageField(String age) {
//   // Convert string to int and handle potential parsing errors
//   final ageValue = int.tryParse(age) ?? 0;
//   state = state.copyWith(age: ageValue);
// }

//  void resetForm() {
//     state = FormModel();
//   }
// }

// final formProvider = StateNotifierProvider<FormProvider,FormModel>((ref)=>FormProvider());

import 'package:dynamictechnosoft/model/form_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final formProvider = StateProvider.autoDispose<FormModel>((ref) {
  return FormModel(
    
  );
});