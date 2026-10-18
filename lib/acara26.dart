// lib/acara26.dart
import 'package:flutter/material.dart';

class Acara26 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Belajar Form Flutter II",
      home: BelajarFormII(),
    );
  }
}

class BelajarFormII extends StatefulWidget {
  @override
  _BelajarFormIIState createState() => _BelajarFormIIState();
}

class _BelajarFormIIState extends State<BelajarFormII> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _passwordController = TextEditingController();

  double _nilaiSlider = 50.0;
  bool _nilaiCheckBox = false;
  bool _nilaiSwitch = true;

  @override
  void dispose() {
    _namaController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Belajar Form Flutter II"),
        backgroundColor: Colors.deepPurple,
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
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ============ JUDUL ============
              Text(
                "Form Pendaftaran Kursus",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "Lengkapi data di bawah ini.",
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 24),

              // ============ 1. NAMA LENGKAP ============
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _namaController,
                  decoration: InputDecoration(
                    hintText: "contoh: Achmad Hilmy Firdaus",
                    labelText: "Nama Lengkap",
                    icon: Icon(Icons.people),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Nama tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),

              // ============ 2. PASSWORD ============
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    icon: Icon(Icons.security),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password tidak boleh kosong';
                    }
                    return null;
                  },
                ),
              ),

              // ============ 3. CHECKBOX ============
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: CheckboxListTile(
                  title: Text('Belajar Dasar Flutter'),
                  subtitle: Text('Dart, Widget, HTTP'),
                  value: _nilaiCheckBox,
                  activeColor: Colors.deepPurpleAccent,
                  onChanged: (value) {
                    setState(() {
                      _nilaiCheckBox = value!;
                    });
                  },
                ),
              ),

              // ============ 4. SWITCH ============
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SwitchListTile(
                  title: Text('Backend Programming'),
                  subtitle: Text('Dart, Nodejs, PHP, Java, dll'),
                  value: _nilaiSwitch,
                  activeTrackColor: Colors.pink[100],
                  activeColor: Colors.red,
                  onChanged: (value) {
                    setState(() {
                      _nilaiSwitch = value;
                    });
                  },
                ),
              ),

              // ============ 5. SLIDER ============
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Tingkat Kemahiran: ${_nilaiSlider.round()}%",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    Slider(
                      value: _nilaiSlider,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      label: '${_nilaiSlider.round()}%',
                      activeColor: Colors.deepPurple,
                      onChanged: (value) {
                        setState(() {
                          _nilaiSlider = value;
                        });
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24),

              // ============ TOMBOL SUBMIT ============
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showResultDialog();
                    }
                  },
                  child: Text(
                    "Submit",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Data Berhasil Dikirim'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nama: ${_namaController.text}'),
            SizedBox(height: 8),
            Text('Password: ${'*' * _passwordController.text.length}'),
            SizedBox(height: 8),
            Text('Belajar Flutter: ${_nilaiCheckBox ? "Ya" : "Tidak"}'),
            SizedBox(height: 8),
            Text('Backend: ${_nilaiSwitch ? "Ya" : "Tidak"}'),
            SizedBox(height: 8),
            Text('Kemahiran: ${_nilaiSlider.round()}%'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
