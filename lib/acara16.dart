// lib/acara16.dart
import 'package:flutter/material.dart';

class Acara16 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 16: Widget Core Component II'),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.search),
          ),
        ],
      ),
      drawer: DrawerScreen(),
      body: ListView.separated(
        itemCount: items.length,
        separatorBuilder: (ctx, i) => Divider(height: 1),
        itemBuilder: (ctx, i) {
          return ListTile(
            leading: LeadingAvatar(
              imagePath: items[i].profileUrl,
              radius: 25,
            ),
            title: Text(
              items[i].name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(items[i].message),
            trailing: Text(items[i].time, style: TextStyle(color: Colors.grey)),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xFF65a9e0),
        child: Icon(Icons.create, color: Colors.white),
      ),
    );
  }
}

// ============ WIDGET AVATAR KUSTOM (OPSI D) ============
class LeadingAvatar extends StatelessWidget {
  final String imagePath;
  final double radius;
  final IconData fallbackIcon;
  final Color fallbackColor;

  const LeadingAvatar({
    Key? key,
    required this.imagePath,
    this.radius = 25,
    this.fallbackIcon = Icons.person,
    this.fallbackColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: fallbackColor.withOpacity(0.2),
      child: ClipOval(
        child: Image.asset(
          imagePath,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          // Kalau file tidak ditemukan, tampilkan ikon orang
          errorBuilder: (context, error, stackTrace) {
            return Icon(
              fallbackIcon,
              size: radius * 1.4,
              color: fallbackColor,
            );
          },
        ),
      ),
    );
  }
}

// ============ DRAWER SCREEN ============
class DrawerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Header Drawer
          UserAccountsDrawerHeader(
            accountName: Text("Achmad Hilmy Firdaus"),
            accountEmail: Text("achmad.hilmy@polije.ac.id"),
            currentAccountPicture: LeadingAvatar(
              imagePath: 'assets/img/header.jpg',
              radius: 40,
              fallbackIcon: Icons.person,
            ),
            decoration: BoxDecoration(color: Color(0xFF65a9e0)),
            otherAccountsPictures: [
              LeadingAvatar(
                imagePath: 'assets/img/other1.jpg',
                radius: 18,
              ),
              LeadingAvatar(
                imagePath: 'assets/img/other2.jpg',
                radius: 18,
              ),
            ],
          ),
          DrawerListTile(
            iconData: Icons.group,
            title: "New Group",
            onTilePressed: () {},
          ),
          DrawerListTile(
            iconData: Icons.lock,
            title: "New Secret Group",
            onTilePressed: () {},
          ),
          DrawerListTile(
            iconData: Icons.notifications,
            title: "New Channel Chat",
            onTilePressed: () {},
          ),
          DrawerListTile(
            iconData: Icons.contacts,
            title: "Contacts",
            onTilePressed: () {},
          ),
          DrawerListTile(
            iconData: Icons.bookmark_border,
            title: "Saved Message",
            onTilePressed: () {},
          ),
          Divider(),
          DrawerListTile(
            iconData: Icons.phone,
            title: "Calls",
            onTilePressed: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTilePressed;

  const DrawerListTile({
    Key? key,
    required this.iconData,
    required this.title,
    required this.onTilePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTilePressed,
      dense: true,
      leading: Icon(iconData),
      title: Text(title, style: TextStyle(fontSize: 16)),
    );
  }
}

// ============ MODEL DATA ============
class ChatModel {
  final String name;
  final String message;
  final String time;
  final String profileUrl;

  ChatModel({
    required this.name,
    required this.message,
    required this.time,
    required this.profileUrl,
  });
}

final List<ChatModel> items = [
  ChatModel(
    name: "Hilmy",
    message: "Hello Hilmy, apa kabar?",
    time: "12:00",
    profileUrl: "assets/img/foto1.jpg",
  ),
  ChatModel(
    name: "Riska",
    message: "Besok kita meeting ya",
    time: "11:30",
    profileUrl: "assets/img/foto2.jpg",
  ),
  ChatModel(
    name: "Vita",
    message: "Terima kasih banyak!",
    time: "10:45",
    profileUrl: "assets/img/foto3.jpg",
  ),
  ChatModel(
    name: "Nina",
    message: "Sudah saya kirim filenya",
    time: "10:20",
    profileUrl: "assets/img/foto4.jpg",
  ),
  ChatModel(
    name: "Citra",
    message: "Oke, sampai jumpa besok",
    time: "09:15",
    profileUrl: "assets/img/foto5.jpg",
  ),
  ChatModel(
    name: "Adi",
    message: "Ada tugas kelompok?",
    time: "08:50",
    profileUrl: "assets/img/foto6.jpg",
  ),
  ChatModel(
    name: "Asraf",
    message: "Project sudah selesai",
    time: "08:30",
    profileUrl: "assets/img/foto7.jpg",
  ),
  ChatModel(
    name: "Dewi",
    message: "Nanti malam jadi main?",
    time: "Kemarin",
    profileUrl: "assets/img/foto8.jpg",
  ),
  ChatModel(
    name: "Budi",
    message: "Terima kasih infonya",
    time: "Kemarin",
    profileUrl: "assets/img/foto9.jpg",
  ),
  ChatModel(
    name: "Sari",
    message: "Foto yang kemarin dikirim ya",
    time: "Kemarin",
    profileUrl: "assets/img/foto10.jpg",
  ),
];
