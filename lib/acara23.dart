// lib/acara23.dart
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Acara23 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

// ============ HOME PAGE (PageView) ============
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> gambar = [
    "foto1.jpg",
    "foto2.jpg",
    "foto3.jpg",
    "foto4.jpg",
    "foto5.jpg",
    "foto6.jpg",
    "foto7.jpg",
    "foto8.jpg",
  ];

  static const Map<String, Color> colors = {
    'foto1': Color(0xFF2DB569),
    'foto2': Color(0xFFF38688),
    'foto3': Color(0xFF45CAF5),
    'foto4': Color(0xFFB19ECB),
    'foto5': Color(0xFFF58E4C),
    'foto6': Color(0xFF46C1BE),
    'foto7': Color(0xFFFFEA0E),
    'foto8': Color(0xFFDBE4E9),
  };

  @override
  Widget build(BuildContext context) {
    timeDilation = 5.0;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [Colors.white, Colors.purple, Colors.deepPurple],
          ),
        ),
        child: PageView.builder(
          controller: PageController(viewportFraction: 0.8),
          itemCount: gambar.length,
          itemBuilder: (BuildContext context, int i) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.0, vertical: 50.0),
              child: Material(
                elevation: 8.0,
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Hero(
                      tag: gambar[i],
                      child: Material(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => Halamandua(
                                  gambar: gambar[i],
                                  warna: colors.values.elementAt(i),
                                ),
                              ),
                            );
                          },
                          child: Flexible(
                            flex: 1,
                            child: Container(
                              color: colors.values.elementAt(i),
                              child: _buildImage(gambar[i]),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildImage(String namaFile) {
    return Image.asset(
      'assets/img/$namaFile',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.person, size: 100, color: Colors.white);
      },
    );
  }
}

// ============ CLASS MODEL PILIHAN ============
class Pilihan {
  const Pilihan({required this.teks, required this.warna});
  final String teks;
  final Color warna;
}

// ============ HALAMAN DETAIL dengan DROPDOWN ============
class Halamandua extends StatefulWidget {
  final String gambar;
  final Color warna;

  Halamandua({required this.gambar, required this.warna});

  @override
  _HalamanduaState createState() => _HalamanduaState();
}

class _HalamanduaState extends State<Halamandua> {
  // State warna yang bisa diubah via dropdown
  Color warna = Colors.grey;

  // Daftar pilihan dropdown
  List<Pilihan> listPilihan = const <Pilihan>[
    Pilihan(teks: "Red", warna: Colors.red),
    Pilihan(teks: "Green", warna: Colors.green),
    Pilihan(teks: "Blue", warna: Colors.blue),
    Pilihan(teks: "Orange", warna: Colors.orange),
    Pilihan(teks: "Purple", warna: Colors.purple),
  ];

  // Fungsi handler saat item dropdown dipilih
  void _pilihannya(Pilihan pilihan) {
    setState(() {
      warna = pilihan.warna;
    });
  }

  @override
  void initState() {
    super.initState();
    // Inisialisasi warna dari widget
    warna = widget.warna;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Gambar"),
        backgroundColor: Colors.purpleAccent,
        actions: <Widget>[
          // ============ POPUP MENU BUTTON ============
          PopupMenuButton<Pilihan>(
            onSelected: _pilihannya,
            icon: Icon(Icons.palette),
            tooltip: 'Ubah warna background',
            itemBuilder: (BuildContext context) {
              return listPilihan.map((Pilihan x) {
                return PopupMenuItem<Pilihan>(
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: x.warna,
                        margin: EdgeInsets.only(right: 12),
                      ),
                      Text(x.teks),
                    ],
                  ),
                  value: x,
                );
              }).toList();
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          // Background gradient radial
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                colors: [
                  Colors.purple,
                  warna,
                  Colors.deepPurple,
                ],
              ),
            ),
          ),
          // Gambar dengan Hero
          Center(
            child: Hero(
              tag: widget.gambar,
              child: ClipOval(
                child: SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: Material(
                    child: InkWell(
                      onTap: () => Navigator.of(context).pop(),
                      child: Flexible(
                        flex: 1,
                        child: Container(
                          color: widget.warna,
                          child: _buildImageDetail(widget.gambar),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Petunjuk
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "Tap gambar untuk kembali · Tap 🎨 untuk ubah warna",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageDetail(String namaFile) {
    return Image.asset(
      'assets/img/$namaFile',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Icon(Icons.person, size: 100, color: Colors.white);
      },
    );
  }
}
