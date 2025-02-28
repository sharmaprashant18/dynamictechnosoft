import 'package:dynamictechnosoft/model/my_validation.dart';
import 'package:dynamictechnosoft/provider/form_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FormPage extends ConsumerWidget {
  FormPage({super.key});
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formNotifier = ref.read(formProvider.notifier);
    final formState = ref.watch(formProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: formState.name,

                  onChanged: (value) {
                    formNotifier.update((state) => state.copyWith(name: value));
                  },
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter a username';
                  //   }
                  //   return null;
                  // },
                  validator: (value) => MyValidation.validateName(value),
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: const Icon(Icons.person),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: formState.email,
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Please enter a email';
                  //   }
                  //   return null;
                  // },
                  //the above method can also be done but here by making the model is done which will be easy in to validate everything from there
                  validator: (value) => MyValidation.validateEmail(value),
                  onChanged: (value) {
                    formNotifier
                        .update((state) => state.copyWith(email: value));
                  },
                  decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: Icon(Icons.email)),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: formState.address,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a address';
                    }

                    return null;
                  },
                  onChanged: (value) {
                    formNotifier
                        .update((state) => state.copyWith(address: value));
                  },
                  decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: Icon(Icons.location_city_outlined)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  initialValue: formState.age.toString(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a age';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    formNotifier.update(
                        (state) => state.copyWith(age: int.tryParse(value)));
                  },
                  keyboardType:
                      TextInputType.number, // Only show number keyboard

                  inputFormatters: MyValidation.numberOnly,

                  decoration: InputDecoration(
                      labelText: 'Age',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      suffixIcon: Icon(Icons.numbers_outlined)),
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // print('Name:${formState.name}');
                          // print('Email:${formState.email}');
                          // print('Address:${formState.address}');
                          // print('Age:${formState.age}');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FormFieldValue()));
                        }
                      },
                      child: Text('Save')),
                  ElevatedButton(
                    onPressed: () {
                      // Clear all form fields
                      formNotifier.update((state) => state.copyWith(
                            name: '',
                            email: '',
                            address: '',
                            age: 0,
                          ));
                    },
                    child: Text('Clear'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class FormFieldValue extends ConsumerWidget {
  const FormFieldValue({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(formProvider);
    // final formNotifier = ref.read(formProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('Form Field Value'),
      ),
      body: Container(
        child: Card(
          child: Column(
            children: [
              ListTile(
                  title: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.person),
                    // trailing:
                    // IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                    title: Text('Name'),
                    subtitle: Text(formState.name),
                  ),
                  ListTile(
                      leading: Icon(Icons.email),
                      // trailing:
                      //     IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                      title: Text('Email'),
                      subtitle: Text(formState.email)),
                  ListTile(
                    leading: Icon(Icons.location_city_outlined),
                    // trailing:
                    //     IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
                    title: Text('Address'),
                    subtitle: Text(formState.address),
                  ),
                  ListTile(
                    leading: Icon(Icons.numbers),
                    // trailing: IconButton(
                    //     onPressed: () {

                    //     },
                    //     icon: Icon(Icons.edit)),
                    title: Text('Age'),
                    subtitle: Text(formState.age.toString()),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        //                      final formNotifier = ref.read(formProvider.notifier);
                        // formNotifier.update((state) => state.copyWith(name: '', email: '', address: '', age: 0));
                        // formNotifier.update((state)=>state.copyWith());

                        Navigator.pop(context);
                      },
                      child: Icon(Icons.edit))
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
