// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'acara15.dart'; // Import file acara 15
import 'acara16.dart'; // Import file acara 16
import 'acara17.dart'; // Import file acara 17
import 'acara18.dart'; // Import file acara 18
import 'acara19.dart'; // Import file acara 19
import 'acara20.dart'; // Import file acara 20
import 'acara21.dart'; // Import file acara 21
import 'acara22.dart'; // Import file acara 22
import 'acara23.dart'; // Import file acara 23
import 'acara24.dart'; // Import file acara 24
import 'acara25.dart';
import 'acara26.dart'; // Import file acara 26
import 'acara27.dart'; // Import file acara 27
import 'acara28.dart'; // Import file acara 28
import 'acara29.dart'; // Import file acara 29
import 'acara30.dart'; // Import file acara 30
import 'acara31.dart'; // Import file acara 31
import 'acara32.dart'; // Import file acara 32
import 'acara33.dart'; // Import file acara 33
import 'acara34.dart'; // Import file acara 34

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Workshop Mobile Application Advance',
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,

      // ============ ROUTE MANAGEMENT ============
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => MainMenu()),
        GetPage(name: '/page-b', page: () => PageB()),
      ],
      // ==========================================

      // Bindings & Translations dari Acara 31
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
          // Tombol menuju Acara 15
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('15')),
              title: Text('Widget Core Component I'),
              subtitle: Text('Text, Icon, Container, Button, Form'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara15()),
                );
              },
            ),
          ),
          SizedBox(height: 10),

          // Tombol menuju Acara 16
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('16')),
              title: Text('Widget Core Component II'),
              subtitle: Text('Image, ListView, dll (Segera)'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara16()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 17
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('17')),
              title: Text('Flutter Styling'),
              subtitle: Text('AppBar, Row, Column, Padding, Margin'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara17()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 18
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('18')),
              title: Text('Routing dan Navigation'),
              subtitle: Text('Navigasi antar halaman dengan Navigator'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara18()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 19
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('19')),
              title: Text('Button Tab Navigation'),
              subtitle: Text('Named Routing, Route Generator, Bottom Tab'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara19()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 20
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('20')),
              title: Text('Drawer Widget'),
              subtitle: Text('Drawer, EndDrawer, Bottom Tab Kombinasi'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara20()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 21
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('21')),
              title: Text('Gradient'),
              subtitle: Text('LinearGradient, RadialGradient, SweepGradient'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara21()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 22
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('22')),
              title: Text('PageView'),
              subtitle: Text('Navigasi halaman dengan PageView'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara22()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 23
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('23')),
              title: Text('Popup Menu'),
              subtitle: Text('PopupMenuButton, PopupMenuItem'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara23()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 24
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('24')),
              title: Text('Gradient, PageView, Dropdown'),
              subtitle: Text('Gabungan Acara 21 + 22 + 23'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara24()),
                );
              },
            ),
          ),
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('25')),
              title: Text('Form I'),
              subtitle: Text('TextFormField, Validasi, Keyboard Type'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara25()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 26
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('26')),
              title: Text('Form II'),
              subtitle: Text('Checkbox, Radio Button, Switch'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara26()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 27
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('27')),
              title: Text('Form III'),
              subtitle: Text('Formulir lengkap dengan validasi'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara27()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 28
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('28')),
              title: Text('Form IV'),
              subtitle: Text('Formulir dengan validasi dan dialog'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara28()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 29
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('29')),
              title: Text('GetX State Management'),
              subtitle: Text(
                  'State Management, Dependency Management, Route Management'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara29()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 30
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('30')),
              title: Text('State Management (GetX)'),
              subtitle: Text('Reactive State, Computed, Workers'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara30()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 31
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('31')),
              title: Text('State Management (GetX)'),
              subtitle: Text('Reactive State, Computed, Workers'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara31()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 32
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('32')),
              title: Text('State Management (GetX)'),
              subtitle: Text('Reactive State, Computed, Workers'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara32()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 33
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('33')),
              title: Text('API Integration'),
              subtitle: Text('GET, POST, PUT, DELETE'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara33()),
                );
              },
            ),
          ),
          // Tombol menuju Acara 34
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text('34')),
              title: Text('API Integration'),
              subtitle: Text('GET, POST, PUT, DELETE'),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Acara34()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
