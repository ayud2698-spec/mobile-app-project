// lib/acara31.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ============================================================
// 1. TRANSLATIONS (Multi Bahasa)
// ============================================================
class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'title': 'Dependency Management',
          'greeting': 'Hello, World!',
          'welcome': 'Welcome to GetX',
          'theme_light': 'Light Theme',
          'theme_dark': 'Dark Theme',
          'language': 'Language',
          'counter': 'Counter',
          'about': 'About',
          'about_desc': 'This app demonstrates GetX dependency management',
        },
        'id_ID': {
          'title': 'Manajemen Dependensi',
          'greeting': 'Halo, Dunia!',
          'welcome': 'Selamat datang di GetX',
          'theme_light': 'Tema Terang',
          'theme_dark': 'Tema Gelap',
          'language': 'Bahasa',
          'counter': 'Penghitung',
          'about': 'Tentang',
          'about_desc':
              'Aplikasi ini mendemonstrasikan manajemen dependensi GetX',
        },
      };
}

// ============================================================
// 2. SERVICE CLASS
// ============================================================
class UserService extends GetxService {
  var username = 'Dinda'.obs;
  var isLoggedIn = true.obs;

  void logout() {
    username.value = 'Guest';
    isLoggedIn.value = false;
  }

  void login() {
    username.value = 'Dinda';
    isLoggedIn.value = true;
  }
}

// ============================================================
// 3. CONTROLLER 1: Counter
// ============================================================
class CounterController extends GetxController {
  var counter = 0.obs;

  void increment() => counter++;
  void decrement() => counter--;
  void reset() => counter.value = 0;
}

// ============================================================
// 4. CONTROLLER 2: Theme & Language
// ============================================================
class SettingsController extends GetxController {
  var isDarkMode = false.obs;
  var isEnglish = false.obs; // default: Indonesia

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
      isDarkMode.value ? ThemeData.dark() : ThemeData.light(),
    );
  }

  void toggleLanguage() {
    isEnglish.value = !isEnglish.value;
    Get.updateLocale(
      isEnglish.value ? Locale('en', 'US') : Locale('id', 'ID'),
    );
  }
}

// ============================================================
// 5. BINDINGS
// ============================================================
class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CounterController>(() => CounterController());
    Get.lazyPut<SettingsController>(() => SettingsController());
    Get.put<UserService>(UserService());
  }
}

// ============================================================
// 6. HALAMAN UTAMA
// ============================================================
class Acara31 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final settings = Get.find<SettingsController>();
          // Baca isEnglish agar title ikut berubah saat bahasa di-toggle
          return Text(
            settings.isEnglish.value
                ? 'Dependency Management'
                : 'Manajemen Dependensi',
          );
        }),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            tooltip: 'Kembali ke Beranda',
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            UserServiceCard(),
            SizedBox(height: 16),
            CounterCard(),
            SizedBox(height: 16),
            SettingsCard(),
            SizedBox(height: 16),
            InfoCard(),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CARD 1: User Service
// ============================================================
class UserServiceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userService = Get.find<UserService>();

    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.person, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  'UserService (Get.put)',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepPurple),
                ),
              ],
            ),
            SizedBox(height: 12),
            Obx(() => Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Icon(Icons.person, color: Colors.white),
                    ),
                    SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(userService.username.value,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(
                          userService.isLoggedIn.value
                              ? 'Logged In'
                              : 'Guest Mode',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 13),
                        ),
                      ],
                    ),
                  ],
                )),
            SizedBox(height: 12),
            Obx(() => userService.isLoggedIn.value
                ? OutlinedButton.icon(
                    onPressed: () {
                      userService.logout();
                      Get.snackbar(
                        'Logout',
                        'Anda telah keluar',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    icon: Icon(Icons.logout),
                    label: Text('Logout'),
                  )
                : OutlinedButton.icon(
                    onPressed: () {
                      userService.login();
                      Get.snackbar(
                        'Login',
                        'Selamat datang kembali!',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    icon: Icon(Icons.login),
                    label: Text('Login'),
                  )),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CARD 2: Counter
// ============================================================
class CounterCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterController = Get.find<CounterController>();

    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.add_circle, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  'CounterController (lazyPut)',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepPurple),
                ),
              ],
            ),
            SizedBox(height: 16),
            Obx(() => Text(
                  '${counterController.counter}',
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                )),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: counterController.decrement,
                  icon: Icon(Icons.remove_circle, size: 40, color: Colors.red),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: counterController.reset,
                  icon: Icon(Icons.refresh, size: 40, color: Colors.blue),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: counterController.increment,
                  icon: Icon(Icons.add_circle, size: 40, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CARD 3: Theme & Language
// ============================================================
class SettingsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Get.find<SettingsController>();

    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.settings, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  'Settings (lazyPut)',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepPurple),
                ),
              ],
            ),
            SizedBox(height: 12),

            // Ganti Tema
            Obx(() => SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                      settings.isEnglish.value ? 'Dark Theme' : 'Tema Gelap'),
                  subtitle: Text(settings.isDarkMode.value
                      ? (settings.isEnglish.value
                          ? 'Dark mode active'
                          : 'Mode Gelap Aktif')
                      : (settings.isEnglish.value
                          ? 'Light mode active'
                          : 'Mode Terang Aktif')),
                  value: settings.isDarkMode.value,
                  activeColor: Colors.deepPurple,
                  onChanged: (_) => settings.toggleTheme(),
                )),

            // Ganti Bahasa
            Obx(() => SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(settings.isEnglish.value
                      ? 'English'
                      : 'Bahasa Indonesia'),
                  subtitle: Text(settings.isEnglish.value
                      ? 'Tap to switch to Indonesian'
                      : 'Tap untuk ganti ke English'),
                  value: settings.isEnglish.value,
                  activeColor: Colors.deepPurple,
                  onChanged: (_) => settings.toggleLanguage(),
                )),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CARD 4: Info
// ============================================================
class InfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settings = Get.find<SettingsController>();

    return Card(
      color: Colors.deepPurple.shade50,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info, color: Colors.deepPurple),
                SizedBox(width: 8),
                Text(
                  settings.isEnglish.value ? 'About' : 'Tentang',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.deepPurple),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(settings.isEnglish.value
                ? 'This app demonstrates GetX dependency management'
                : 'Aplikasi ini mendemonstrasikan manajemen dependensi GetX'),
            SizedBox(height: 12),
            Divider(),
            SizedBox(height: 8),
            Text('Get.put()       → daftar + langsung buat',
                style: TextStyle(fontSize: 13)),
            Text('Get.lazyPut()   → daftar, buat saat dipakai',
                style: TextStyle(fontSize: 13)),
            Text('Get.putAsync()  → daftar + inisialisasi async',
                style: TextStyle(fontSize: 13)),
            Text('Get.find()      → ambil dependency',
                style: TextStyle(fontSize: 13)),
            Text('Bindings        → group dependency',
                style: TextStyle(fontSize: 13)),
          ],
        ),
      ),
    );
  }
}
