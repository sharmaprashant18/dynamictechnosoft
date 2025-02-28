


import 'package:dynamictechnosoft/services/hive_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ThemeNotifier extends StateNotifier<bool> {
  ThemeNotifier(super.state){
loadTheme();

  }
void loadTheme()async{
final themeBox = MyHiveService().settingsBox;
  state = themeBox.get('isDarkMode',defaultValue: false);
}
void toogleTheme() async{
  state=!state;
final themeBox = MyHiveService().settingsBox;
  await themeBox.put('isDarkMode', state);
}
}

final themeProvider = StateNotifierProvider<ThemeNotifier,bool>((ref) {
return ThemeNotifier(false);
});


