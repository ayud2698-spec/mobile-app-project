// lib/acara22.dart
import 'package:flutter/material.dart';

class Acara22 extends StatelessWidget {
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
  // Daftar gambar
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

  // Warna untuk tiap kartu
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
    // Perlambat animasi Hero

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

  // Fungsi bantu: tampilkan gambar atau ikon fallback
  Widget _buildImage(String namaFile) {
    return Image.asset(
      'assets/img/$namaFile',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.person,
          size: 100,
          color: Colors.white,
        );
      },
    );
  }
}

// ============ HALAMAN DETAIL ============
class Halamandua extends StatefulWidget {
  final String gambar;
  final Color warna;

  Halamandua({required this.gambar, required this.warna});

  @override
  _HalamanduaState createState() => _HalamanduaState();
}

class _HalamanduaState extends State<Halamandua> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Gambar"),
        backgroundColor: Colors.purpleAccent,
      ),
      body: Stack(
        children: <Widget>[
          // Background gradient
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                colors: [
                  Colors.purple,
                  widget.warna,
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
                "Tap gambar untuk kembali",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
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
        return Icon(
          Icons.person,
          size: 100,
          color: Colors.white,
        );
      },
    );
  }
}
