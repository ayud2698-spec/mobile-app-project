// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb; // Tambahan untuk deteksi Web

// Import semua acara
import 'acara15.dart';
import 'acara16.dart';
import 'acara17.dart';
import 'acara18.dart';
import 'acara19.dart';
import 'acara20.dart';
import 'acara21.dart';
import 'acara22.dart';
import 'acara23.dart';
import 'acara24.dart';
import 'acara25.dart';
import 'acara26.dart';
import 'acara27.dart';
import 'acara28.dart';
import 'acara29.dart';
import 'acara30.dart';
import 'acara31.dart';
import 'acara32.dart';
import 'acara33.dart';
import 'acara34.dart';
import 'acara35.dart';
import 'acara36.dart';
import 'acara37.dart';
import 'acara38.dart';
import 'acara39.dart';
import 'acara40.dart';
import 'acara41.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi Firebase
  if (kIsWeb) {
    // JIKA DIJALANKAN DI WEB (CHROME)
    // Kamu butuh konfigurasi khusus Web dari Firebase Console.
    // Sementara ini, kita kosongkan karena kita akan pakai Android.
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCDW73lMQ5L4y1I4uO9EVCd4ZuHsgla7Sk",
        authDomain: "auth-flutter-a2555.firebaseapp.com",
        projectId: "auth-flutter-a2555",
        storageBucket: "auth-flutter-a2555.firebasestorage.app",
        messagingSenderId: "117477218046",
        // PERHATIKAN: AppId untuk web harus berakhiran ':web:...'
        // Jika kamu belum mendaftarkan Web di console, ini akan error.
        appId: "1:117477218046:web:xxxxxx",
      ),
    );
  } else {
    // JIKA DIJALANKAN DI ANDROID (EMULATOR/HP)
    // Ini akan otomatis membaca file google-services.json kamu
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Workshop Mobile Application Advance',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,

      // Route Management
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MainMenu()),
      ],

      // Bindings & Translations
      initialBinding: AppBindings(),
      translations: Messages(),
      locale: Locale('id', 'ID'),
      fallbackLocale: Locale('en', 'US'),
    );
  }
}

class MainMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Acara Praktikum'),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          // (Biarkan semua Card dari Acara 15 sampai 37 di sini, persis seperti kode kamu)
          _buildMenuCard(context, '15', 'Widget Core Component I', Acara15()),
          _buildMenuCard(context, '16', 'Widget Core Component II', Acara16()),
          _buildMenuCard(context, '17', 'Flutter Styling', Acara17()),
          _buildMenuCard(context, '18', 'Routing dan Navigation', Acara18()),
          _buildMenuCard(context, '19', 'Button Tab Navigation', Acara19()),
          _buildMenuCard(context, '20', 'Drawer Widget', Acara20()),
          _buildMenuCard(context, '21', 'Gradient', Acara21()),
          _buildMenuCard(context, '22', 'PageView', Acara22()),
          _buildMenuCard(context, '23', 'Popup Menu', Acara23()),
          _buildMenuCard(
              context, '24', 'Gradient, PageView, Dropdown', Acara24()),
          _buildMenuCard(context, '25', 'Form I', Acara25()),
          _buildMenuCard(context, '26', 'Form II', Acara26()),
          _buildMenuCard(context, '27', 'Form III', Acara27()),
          _buildMenuCard(context, '28', 'Form IV', Acara28()),
          _buildMenuCard(context, '29', 'GetX State Management', Acara29()),
          _buildMenuCard(context, '30', 'State Management (GetX)', Acara30()),
          _buildMenuCard(context, '31', 'State Management (GetX)', Acara31()),
          _buildMenuCard(context, '32', 'State Management (GetX)', Acara32()),
          _buildMenuCard(context, '33', 'API Integration', Acara33()),
          _buildMenuCard(context, '34', 'API Integration', Acara34()),
          _buildMenuCard(context, '35', 'Rest API III (Movie DB)', Acara35()),
          _buildMenuCard(context, '36', 'Rest API IV (User List)', Acara36()),
          _buildMenuCard(context, '37', 'Firebase Auth', Acara37()),
          _buildMenuCard(context, '38', 'Auth API', Acara38()),
          _buildMenuCard(context, '39', 'Auth API II', Acara39()),
          _buildMenuCard(context, '40', 'Rest API V (Movie DB)', Acara40()),
          _buildMenuCard(context, '41', 'Rest API VI (Movie DB)', Acara41()),
        ],
      ),
    );
  }

  // Helper Widget untuk membuat Card agar kode lebih rapi
  Widget _buildMenuCard(
      BuildContext context, String nomor, String judul, Widget halamanTujuan) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(child: Text(nomor)),
        title: Text(judul),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => halamanTujuan),
          );
        },
      ),
    );
  }
}
