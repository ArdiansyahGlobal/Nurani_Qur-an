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
      title: 'Nurani Al-Quran',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Amiri', // Font Arabic
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ',
          style: TextStyle(fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Stack(
        children: [
          // Background dengan pola Arabic
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/arabic_pattern.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Konten utama
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Selamat datang di Nurani Al-Quran',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      foregroundColor: Colors.green.shade800,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SurahListPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Masuk ke 114 Surat',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      foregroundColor: Colors.green.shade800,
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SuratYasinPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'Surat Yasin',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SuratYasinPage extends StatefulWidget {
  const SuratYasinPage({super.key});

  @override
  _SuratYasinPageState createState() => _SuratYasinPageState();
}

class _SuratYasinPageState extends State<SuratYasinPage> {
  bool isLoading = true;
  Map<String, dynamic> suratYasin = {};

  final String apiKey = 'd3cad798d1mshf5935dd76e2df2dp1ee4dejsnc13230b82812';

  @override
  void initState() {
    super.initState();
    _fetchSuratYasin();
  }

  Future<void> _fetchSuratYasin() async {
    final response = await http.get(
      Uri.parse('https://api.alquran.cloud/v1/surah/36'),
      headers: {
        'X-RapidAPI-Key': apiKey,
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
        title: const Text('سورة يس'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/arabic_pattern.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  'سورة يس - القرآن الكريم',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
                        margin: const EdgeInsets.symmetric(vertical: 12.0), // Tambahkan lebih banyak jarak
                        child: Padding(
                          padding: const EdgeInsets.all(16.0), // Tambahkan padding dalam ayat
                          child: Text(
                            ayat['text'] ?? '',
                            style: const TextStyle(
                              fontFamily: 'Amiri',
                              fontSize: 20, // Sesuaikan ukuran font
                              height: 1.8, // Jarak antar baris dalam satu ayat
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SurahListPage extends StatelessWidget {
  const SurahListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Daftar Surah dengan nama lengkap
    final List<String> surahNames = [
      'Al-Fatiha', 'Al-Baqarah', 'Aal-E-Imran', 'An-Nisa', 'Al-Ma\'idah', 'Al-An\'am', 'Al-A\'raf',
      'Al-Anfal', 'At-Tawbah', 'Yunus', 'Hud', 'Yusuf', 'Ar-Ra\'d', 'Ibrahim', 'Al-Hijr', 'An-Nahl',
      'Al-Isra', 'Al-Kahf', 'Maryam', 'Ta-Ha', 'Al-Anbiya', 'Al-Hajj', 'Al-Mu’minun', 'An-Nur', 'Al-Furqan',
      'Ash-Shu\'ara', 'An-Naml', 'Al-Qasas', 'Al-Ankabut', 'Ar-Rum', 'Luqman', 'As-Sajda', 'Al-Ahzab', 'Saba',
      'Fatir', 'Ya-Sin', 'As-Saffat', 'Sad', 'Az-Zumar', 'Ghafir', 'Fussilat', 'Ash-Shura', 'Az-Zukhruf',
      'Ad-Dukhan', 'Al-Jathiya', 'Al-Ahqaf', 'Muhammad', 'Al-Fath', 'Al-Hujurat', 'Qaf', 'Adh-Dhariyat',
      'At-Tur', 'An-Najm', 'Al-Qamar', 'Ar-Rahman', 'Al-Waqi’ah', 'Al-Hadid', 'Al-Mujadila', 'Al-Hashr',
      'Al-Mumtahina', 'As-Saff', 'Al-Jumu\'ah', 'Al-Munafiqun', 'At-Taghabun', 'At-Talaq', 'At-Tahrim',
      'Al-Mulk', 'Al-Qalam', 'Al-Haqqah', 'Al-Maarij', 'Nuh', 'Al-Jinn', 'Al-Muzzammil', 'Al-Qiyama',
      'Al-Insan', 'Al-Mursalat', 'An-Naba', 'An-Nazi\'at', 'Abasa', 'At-Takwir', 'Al-Infitar',
      'Al-Mutaffifin', 'Al-Inshiqaq', 'Al-Buruj', 'At-Tariq', 'Al-Alaq', 'Al-Qadr', 'Al-Bayyina',
      'Az-Zalzalah', 'Al-Adiyat', 'Ash-Shams', 'Al-Lail', 'Ad-Duhaa', 'Ash-Sharh', 'At-Tin', 'Al-Alaq',
      'Al-Qadr', 'Al-Bayyina', 'Az-Zalzalah', 'Al-Adiyat', 'Al-Qari\'ah', 'At-Takathur', 'Al-Asr',
      'Al-Humazah', 'Al-Fil', 'Quraish', 'Al-Ma’un', 'Al-Kawthar', 'Al-Kafirun', 'An-Nasr', 'Al-Masad',
      'Al-Ikhlas', 'Al-Falaq', 'An-Nas'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('قائمة السور'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/arabic_pattern.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView.builder(
            itemCount: surahNames.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  '${index + 1}. ${surahNames[index]}',
                  style: const TextStyle(fontFamily: 'Amiri'),
                ),
                onTap: () {
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
        ],
      ),
    );
  }
}

class SurahDetailPage extends StatefulWidget {
  final int surahId;

  const SurahDetailPage({super.key, required this.surahId});

  @override
  _SurahDetailPageState createState() => _SurahDetailPageState();
}

class _SurahDetailPageState extends State<SurahDetailPage> {
  bool isLoading = true;
  Map<String, dynamic> surahData = {};

  final String apiKey = 'd3cad798d1mshf5935dd76e2df2dp1ee4dejsnc13230b82812';

  @override
  void initState() {
    super.initState();
    _fetchSurahData();
  }

  Future<void> _fetchSurahData() async {
    final response = await http.get(
      Uri.parse('https://api.alquran.cloud/v1/surah/${widget.surahId}'),
      headers: {
        'X-RapidAPI-Key': apiKey,
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
        title: Text('سورة ${widget.surahId}'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/arabic_pattern.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16.0), // Tambahkan jarak atas dan bawah
            itemCount: surahData['ayahs']?.length ?? 0,
            itemBuilder: (context, index) {
              final ayat = surahData['ayahs'][index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  title: Text(
                    ayat['text'] ?? '',
                    style: const TextStyle(fontFamily: 'Amiri'),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
