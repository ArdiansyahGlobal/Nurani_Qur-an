import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Baca Al-Quran',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(), // Halaman Utama
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baca Al-Quran'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Pilih untuk mulai membaca:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Mengatur warna tombol
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SurahListPage()), // Masuk ke halaman Al-Quran
                );
              },
              child: const Text(
                'Masuk ke Al-Quran',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green, // Mengatur warna tombol
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SuratYasinPage()), // Masuk ke halaman Surat Yasin
                );
              },
              child: const Text(
                'Masuk ke Surat Yasin',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Surat Yasin
class SuratYasinPage extends StatefulWidget {
  const SuratYasinPage({super.key});

  @override
  _SuratYasinPageState createState() => _SuratYasinPageState();
}

class _SuratYasinPageState extends State<SuratYasinPage> {
  bool isLoading = true;
  Map<String, dynamic> suratYasin = {};

  final String apiKey = 'd3cad798d1mshf5935dd76e2df2dp1ee4dejsnc13230b82812'; // API key kamu

  @override
  void initState() {
    super.initState();
    _fetchSuratYasin();
  }

  // Fungsi untuk menarik data Surat Yasin dari API
  Future<void> _fetchSuratYasin() async {
    final response = await http.get(
      Uri.parse('https://api.alquran.cloud/v1/surah/36'), // Surat Yasin (nomor 36)
      headers: {
        'X-RapidAPI-Key': apiKey, // Menambahkan header API key
        'X-RapidAPI-Host': 'api.alquran.cloud',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        suratYasin = data['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load Surat Yasin');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Baca Surat Yasin'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Surat Yasin - Al-Quran',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : Expanded(
              child: ListView.builder(
                itemCount: suratYasin['ayahs']?.length ?? 0,
                itemBuilder: (context, index) {
                  final ayat = suratYasin['ayahs'][index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(ayat['text'] ?? ''),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Halaman Surat List Al-Quran
class SurahListPage extends StatelessWidget {
  const SurahListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Surah Al-Quran'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: 114, // Jumlah Surah Al-Quran
        itemBuilder: (context, index) {
          // Menampilkan daftar Surah, misalnya dengan nama Surah
          return ListTile(
            title: Text('Surah ${index + 1}'), // Ganti dengan nama Surah jika perlu
            onTap: () {
              // Arahkan ke halaman detail Surah yang dipilih
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SurahDetailPage(surahId: index + 1),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// Halaman detail Surah
class SurahDetailPage extends StatefulWidget {
  final int surahId;

  const SurahDetailPage({super.key, required this.surahId});

  @override
  _SurahDetailPageState createState() => _SurahDetailPageState();
}

class _SurahDetailPageState extends State<SurahDetailPage> {
  bool isLoading = true;
  Map<String, dynamic> surahData = {};

  final String apiKey = 'd3cad798d1mshf5935dd76e2df2dp1ee4dejsnc13230b82812'; // API key kamu

  @override
  void initState() {
    super.initState();
    _fetchSurahData();
  }

  Future<void> _fetchSurahData() async {
    final response = await http.get(
      Uri.parse('https://api.alquran.cloud/v1/surah/${widget.surahId}'),
      headers: {
        'X-RapidAPI-Key': apiKey, // Menambahkan header API key
        'X-RapidAPI-Host': 'api.alquran.cloud',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        surahData = data['data'];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      throw Exception('Failed to load Surah');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surah ${widget.surahId}'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: surahData['ayahs']?.length ?? 0,
          itemBuilder: (context, index) {
            final ayat = surahData['ayahs'][index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(ayat['text'] ?? ''),
              ),
            );
          },
        ),
      ),
    );
  }
}