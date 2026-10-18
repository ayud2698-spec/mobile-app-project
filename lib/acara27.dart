// lib/acara27.dart
import 'package:flutter/material.dart';

class Acara27 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Belajar Form III",
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ============ STATE ============
  final List<String> agamaList = [
    "Islam",
    "Kristen Protestan",
    "Kristen Katolik",
    "Hindu",
    "Budha",
  ];

  String _agama = "Islam";
  String _jk = "";

  final TextEditingController controllerNama = TextEditingController();
  final TextEditingController controllerPass = TextEditingController();
  final TextEditingController controllerMoto = TextEditingController();

  @override
  void dispose() {
    controllerNama.dispose();
    controllerPass.dispose();
    controllerMoto.dispose();
    super.dispose();
  }

  // ============ FUNGSI ============
  void _pilihJk(String value) {
    setState(() {
      _jk = value;
    });
  }

  void pilihAgama(String? value) {
    if (value == null) return;
    setState(() {
      _agama = value;
    });
  }

  void kirimdata() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Data Diri"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Nama Lengkap : ${controllerNama.text}"),
              SizedBox(height: 8),
              Text("Password     : ${'*' * controllerPass.text.length}"),
              SizedBox(height: 8),
              Text("Moto Hidup   : ${controllerMoto.text}"),
              SizedBox(height: 8),
              Text("Jenis Kelamin: ${_jk.isEmpty ? "(belum dipilih)" : _jk}"),
              SizedBox(height: 8),
              Text("Agama        : $_agama"),
            ],
          ),
        ),
        actions: [
          TextButton(
            child: Text("OK"),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  // ============ BUILD ============
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.list),
        title: Text("Data Diri"),
        backgroundColor: Colors.teal,
        actions: [
          // ============ TOMBOL HOME ============
          IconButton(
            icon: Icon(Icons.home),
            tooltip: 'Kembali ke Beranda',
            onPressed: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(10.0),
        children: <Widget>[
          // ============ FIELD NAMA ============
          TextField(
            controller: controllerNama,
            decoration: InputDecoration(
              hintText: "Nama Lengkap",
              labelText: "Nama Lengkap",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          SizedBox(height: 20),

          // ============ FIELD PASSWORD ============
          TextField(
            controller: controllerPass,
            obscureText: true,
            decoration: InputDecoration(
              hintText: "Password",
              labelText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          SizedBox(height: 20),

          // ============ FIELD MOTO HIDUP ============
          TextField(
            controller: controllerMoto,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: "Moto Hidup",
              labelText: "Moto Hidup",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
          ),
          SizedBox(height: 20),

          // ============ RADIO JENIS KELAMIN ============
          Text(
            "Jenis Kelamin",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          RadioListTile<String>(
            value: "laki-laki",
            title: Text("Laki-Laki"),
            subtitle: Text("Pilih ini jika anda Laki-Laki"),
            groupValue: _jk,
            onChanged: (String? value) {
              if (value != null) _pilihJk(value);
            },
            activeColor: Colors.blue,
          ),
          RadioListTile<String>(
            value: "perempuan",
            title: Text("Perempuan"),
            subtitle: Text("Pilih ini jika anda Perempuan"),
            groupValue: _jk,
            onChanged: (String? value) {
              if (value != null) _pilihJk(value);
            },
            activeColor: Colors.blue,
          ),
          SizedBox(height: 20),

          // ============ DROPDOWN AGAMA ============
          Text(
            "Agama",
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
          ),
          SizedBox(height: 8),
          Row(
            children: <Widget>[
              Text(
                "Agama ",
                style: TextStyle(fontSize: 18.0, color: Colors.blue),
              ),
              SizedBox(width: 15),
              Expanded(
                child: DropdownButton<String>(
                  value: _agama,
                  isExpanded: true,
                  onChanged: pilihAgama,
                  items: agamaList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
          SizedBox(height: 24),

          // ============ TOMBOL OK ============
          ElevatedButton(
            child: Text("OK", style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: kirimdata,
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
