// lib/acara24.dart
// GABUNGAN Acara 21 (Gradient) + Acara 22 (PageView) + Acara 23 (Dropdown)
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class Acara24 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GradientShowcasePage(),
    );
  }
}

// HALAMAN 1: GRADIENT SHOWCASE (dari Acara 21)

class GradientShowcasePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Acara 24: Gradient Showcase'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_forward),
            tooltip: 'Ke PageView',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => HomePage()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // ============ BAGIAN 1: LinearGradient ============
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue, Colors.purple],
                ),
              ),
              child: Center(
                child: Text(
                  'LinearGradient',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // ============ BAGIAN 2: RadialGradient ============
          Flexible(
            flex: 2,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 0.8,
                  colors: [Colors.yellow, Colors.orange, Colors.red],
                ),
              ),
              child: Center(
                child: Text(
                  'RadialGradient',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // ============ BAGIAN 3: SweepGradient ============
          Flexible(
            flex: 1,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: SweepGradient(
                  center: Alignment.center,
                  startAngle: 0.0,
                  endAngle: 3.14 * 2,
                  colors: [
                    Colors.green,
                    Colors.teal,
                    Colors.blue,
                    Colors.purple,
                    Colors.green,
                  ],
                ),
              ),
              child: Center(
                child: Text(
                  'SweepGradient',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),

          // ============ TOMBOL KE PAGEVIEW ============
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            color: Colors.black87,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => HomePage()),
                );
              },
              icon: Icon(Icons.swipe),
              label: Text('Lanjut ke PageView →'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// HALAMAN 2: PAGEVIEW (dari Acara 22)

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
    // Perlambat animasi Hero (5x) untuk keperluan demonstrasi
    timeDilation = 5.0;

    return Scaffold(
      appBar: AppBar(
        title: Text('PageView + Hero'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            icon: Icon(Icons.home),
            tooltip: 'Kembali ke Gradient',
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => GradientShowcasePage()),
              );
            },
          ),
        ],
      ),
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

// CLASS MODEL PILIHAN (dari Acara 23)

class Pilihan {
  const Pilihan({required this.teks, required this.warna});
  final String teks;
  final Color warna;
}

// HALAMAN 3: DETAIL + DROPDOWN (dari Acara 23)

class Halamandua extends StatefulWidget {
  final String gambar;
  final Color warna;

  Halamandua({required this.gambar, required this.warna});

  @override
  _HalamanduaState createState() => _HalamanduaState();
}

class _HalamanduaState extends State<Halamandua> {
  Color warna = Colors.grey;

  List<Pilihan> listPilihan = const <Pilihan>[
    Pilihan(teks: "Red", warna: Colors.red),
    Pilihan(teks: "Green", warna: Colors.green),
    Pilihan(teks: "Blue", warna: Colors.blue),
    Pilihan(teks: "Orange", warna: Colors.orange),
    Pilihan(teks: "Purple", warna: Colors.purple),
  ];

  void _pilihannya(Pilihan pilihan) {
    setState(() {
      warna = pilihan.warna;
    });
  }

  @override
  void initState() {
    super.initState();
    warna = widget.warna;
  }

  // Helper: cari nama warna yang aktif
  String _getNamaWarna() {
    for (var p in listPilihan) {
      if (p.warna == warna) return p.teks;
    }
    return "Custom";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail - ${_getNamaWarna()}"),
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
          // Tombol reset warna
          IconButton(
            icon: Icon(Icons.refresh),
            tooltip: 'Reset warna',
            onPressed: () {
              setState(() {
                warna = widget.warna;
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          // Background gradient radial (warna tengah berubah dinamis)
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
