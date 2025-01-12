import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

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
      body: BackgroundImage(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [


                const SizedBox(height: 10),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green.withOpacity(0.9),
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
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
                    backgroundColor: Colors.green.withOpacity(0.9),
                    foregroundColor: Colors.black87,
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 30),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PrayerTimesPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'Waktu Salat',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class SurahListPage extends StatelessWidget {
  const SurahListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> surahNames = [
      'Al-Fātiḥah', 'Al-Baqarah', 'Āli ‘Imrān', 'An-Nisā’', 'Al-Mā’idah', 'Al-An‘ām', 'Al-A‘rāf',
      'Al-Anfāl', 'At-Taubah', 'Yūnus', 'Hūd', 'Yusuf', 'Ar-Ra‘d', 'Ibrāhīm', 'Al-Hijr', 'An-Nahl',
      'Al-Isrā’', 'Al-Kahf', 'Maryam', 'Tā-hā', 'Al-Anbiyā’', 'Al-Hajj', 'Al-Mu’minūn', 'An-Nūr', 'Al-Furqān',
      'Ash-Shu‘arā’', 'An-Naml', 'Al-Qasas', 'Al-‘Ankabūt', 'Ar-Rūm', 'Luqmān', 'As-Sajdah', 'Al-Ahzāb', 'Sāba’',
      'Fātir', 'Yāsīn', 'As-Sāffāt', 'Sād', 'Az-Zumar', 'Al-Gāfir', 'Fussilat', 'Shūrā', 'Az-Zukhruf', 'Ad-Dukhān',
      'Al-Jāthiyah', 'Al-Ahqāf', 'Muhammad', 'Al-Fatḥ', 'Al-Hujurāt', 'Qāf', 'Az-Zāriāt', 'At-Tūr', 'An-Najm',
      'Al-Qamar', 'Ar-Raḥmān', 'Al-Wāqi‘ah', 'Al-Hadīd', 'Al-Mujadilah', 'Al-Ḥashr', 'Al-Mumtahina', 'As-Ṣaff',
      'Al-Jum‘a', 'Al-Munafiqūn', 'At-Tagābūn', 'At-Talaq', 'At-Taḥrīm', 'Al-Mulk', 'Al-Qalam', 'Al-Hāqqa', 'Al-‘Āṣir',
      'An-Nūḥ', 'Al-Jinn', 'Al-Muzzammil', 'Al-Muddaththir', 'Al-Qiyāmah', 'Al-Insān', 'Al-Mursalat', 'An-Naba’',
      'An-Nāzi‘āt', '‘Abasa', 'At-Takwīr', 'Al-Infitar', 'Al-Mutaffifīn', 'Al-Inširāḥ', 'Al-Burūj', 'At-Tariq',
      'Al-A‘lā', 'Al-Gāshiyah', 'Al-Fajr', 'Al-Balad', 'Ash-Shams', 'Al-Lail', 'Ad-Dhuḥā', 'Al-Inširāḥ', 'At-Tin',
      'Al-‘Alaq', 'Al-Qadr', 'Al-Bayyinah', 'Az-Zalzalah', 'Al-‘Ādiyāt', 'Al-Qāri‘ah', 'Al-Takāsur', 'Al-‘Asr',
      'Al-Humazah', 'Al-Fil', 'Quraysh', 'Al-Ma‘ūn', 'Al-Kawthar', 'Al-Kafirūn', 'An-Nasr', 'Al-Ihlās', 'Al-Falaq', 'An-Nās'
    ];



    int _getSurahIndex(String surahName) {
      return surahNames.indexOf(surahName) + 1;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Surah List'),
        backgroundColor: Colors.green.shade700,
      ),
      body: BackgroundImage(  // Apply BackgroundImage widget here
        child: ListView.builder(
          itemCount: surahNames.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Container(
                padding: const EdgeInsets.all(8.0),  // Add padding around the text
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),  // Slight background color with opacity
                  border: Border.all(
                    color: Colors.black.withOpacity(0.5),  // Border color with slight opacity
                    width: 1.5,  // Border width
                  ),
                  borderRadius: BorderRadius.circular(10),  // Rounded corners for the box
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),  // Shadow effect
                      blurRadius: 4,  // Blur radius for the shadow
                      offset: Offset(0, 2),  // Offset of the shadow
                    ),
                  ],
                ),
                child: Text(
                  surahNames[index],
                  style: const TextStyle(
                    fontFamily: 'Amiri',  // Font Arabic
                    fontSize: 35,         // Font size
                    color: Colors.black,  // Text color
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SurahDetailPage(surahName: surahNames[index]),
                  ),
                );
              },
            );

          },
        ),
      ),
    );
  }
}





class SurahDetailPage extends StatefulWidget {
  final String surahName;

  const SurahDetailPage({super.key, required this.surahName});

  @override
  _SurahDetailPageState createState() => _SurahDetailPageState();
}

class _SurahDetailPageState extends State<SurahDetailPage> {
  bool isLoading = true;
  List<String> ayahs = [];

  @override
  void initState() {
    super.initState();
    _loadSurahData();
  }

  // Inside _SurahDetailPageState class

  void _showErrorDialog(String error) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to load Surah data: $error'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }




  Future<void> _loadSurahData() async {
    try {
      // Dynamically select the JSON file based on the Surah name
      String surahFileName = 'assets/data/arabic_verse_uthmani${_getSurahIndex(widget.surahName)}.json';

      // Load the specific JSON file for the selected Surah
      final String response = await rootBundle.loadString(surahFileName);
      final data = json.decode(response);

      setState(() {
        ayahs = List<String>.from(data['aya']);
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error loading Surah data: $error');
      _showErrorDialog(error.toString());  // Call the error dialog method here
    }
  }



  int _getSurahIndex(String surahName) {
    // Mapping surah names to their index
    final Map<String, int> surahIndexMap = {
      'Al-Fātiḥah': 1,
      'Al-Baqarah': 2,
      'Āli ‘Imrān': 3,
      'An-Nisā’': 4,
      'Al-Mā’idah': 5,
      'Al-An‘ām': 6,
      'Al-A‘rāf': 7,
      'Al-Anfāl': 8,
      'At-Taubah': 9,
      'Yūnus': 10,
      'Hūd': 11,
      'Yusuf': 12,
      'Ar-Ra‘d': 13,
      'Ibrāhīm': 14,
      'Al-Hijr': 15,
      'An-Nahl': 16,
      'Al-Isrā’': 17,
      'Al-Kahf': 18,
      'Maryam': 19,
      'Tā-hā': 20,
      'Al-Anbiyā’': 21,
      'Al-Hajj': 22,
      'Al-Mu’minūn': 23,
      'An-Nūr': 24,
      'Al-Furqān': 25,
      'Ash-Shu‘arā’': 26,
      'An-Naml': 27,
      'Al-Qasas': 28,
      'Al-‘Ankabūt': 29,
      'Ar-Rūm': 30,
      'Luqmān': 31,
      'As-Sajdah': 32,
      'Al-Ahzāb': 33,
      'Sāba’': 34,
      'Fātir': 35,
      'Yāsīn': 36,
      'As-Sāffāt': 37,
      'Sād': 38,
      'Az-Zumar': 39,
      'Al-Gāfir': 40,
      'Fussilat': 41,
      'Shūrā': 42,
      'Az-Zukhruf': 43,
      'Ad-Dukhān': 44,
      'Al-Jāthiyah': 45,
      'Al-Ahqāf': 46,
      'Muhammad': 47,
      'Al-Fatḥ': 48,
      'Al-Hujurāt': 49,
      'Qāf': 50,
      'Az-Zāriāt': 51,
      'At-Tūr': 52,
      'An-Najm': 53,
      'Al-Qamar': 54,
      'Ar-Raḥmān': 55,
      'Al-Wāqi‘ah': 56,
      'Al-Hadīd': 57,
      'Al-Mujadilah': 58,
      'Al-Ḥashr': 59,
      'Al-Mumtahina': 60,
      'As-Ṣaff': 61,
      'Al-Jum‘a': 62,
      'Al-Munafiqūn': 63,
      'At-Tagābūn': 64,
      'At-Talaq': 65,
      'At-Taḥrīm': 66,
      'Al-Mulk': 67,
      'Al-Qalam': 68,
      'Al-Hāqqa': 69,
      'Al-Maarij': 70,
      'Nūḥ': 71,
      'Al-Jinn': 72,
      'Al-Muzzammil': 73,
      'Al-Qiyāmah': 74,
      'Al-Insān': 75,
      'Al-Mursalat': 77,
      'An-Naba’': 78,
      'An-Nāzi‘āt': 79,
      '‘Abasa': 80,
      'At-Takwīr': 81,
      'Al-Infitar': 82,
      'Al-Mutaffifīn': 83,
      'Al-Inširāḥ': 84,
      'Al-Burūj': 85,
      'At-Tariq': 86,
      'Al-A‘lā': 87,
      'Al-Gāshiyah': 88,
      'Al-Fajr': 89,
      'Al-Balad': 90,
      'Ash-Shams': 91,
      'Al-Lail': 92,
      'Ad-Dhuḥā': 93,
      'Al-Inširāḥ': 94,
      'At-Tin': 95,
      'Al-‘Alaq': 96,
      'Al-Qadr': 97,
      'Al-Bayyinah': 98,
      'Az-Zalzalah': 99,
      'Al-‘Ādiyāt': 100,
      'Al-Qāri‘ah': 101,
      'At-Takāsur': 102,
      'Al-‘Asr': 103,
      'Al-Humazah': 104,
      'Al-Fil': 105,
      'Quraysh': 106,
      'Al-Ma‘ūn': 107,
      'Al-Kawthar': 108,
      'Al-Kafirūn': 109,
      'An-Nasr': 110,
      'Al-Masad': 111,
      'Al-Ikhlas': 112,
      'Al-Falaq': 113,
      'An-Nās': 114,
    };

    return surahIndexMap[surahName] ?? -1; // Return -1 if not found
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.surahName),
        backgroundColor: Colors.green.shade700,
      ),
      body: BackgroundImage(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
          itemCount: ayahs.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(
                  ayahs[index],
                  style: const TextStyle(fontFamily: 'Amiri', fontSize: 25),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}



class BackgroundImage extends StatelessWidget {
  final Widget child;
  const BackgroundImage({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            color: Colors.blue,  // For debugging purposes
            image: DecorationImage(
              image: AssetImage('assets/images/app_icon.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        child,
      ],
    );
  }
}


class PrayerTimesPage extends StatefulWidget {
  const PrayerTimesPage({super.key});

  @override
  _PrayerTimesPageState createState() => _PrayerTimesPageState();
}

class _PrayerTimesPageState extends State<PrayerTimesPage> {
  bool isLoading = true;
  Map<String, dynamic> prayerTimes = {};

  @override
  void initState() {
    super.initState();
    _loadPrayerTimes();
  }

  Future<void> _loadPrayerTimes() async {
    try {
      final String response = await rootBundle.loadString('assets/data/prayer_times.json');
      final data = json.decode(response);

      setState(() {
        prayerTimes = data['timings'] ?? {};
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      print('Error loading prayer times: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Waktu Salat'),
        centerTitle: true,
        backgroundColor: Colors.green.shade700,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/app_icon.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              _buildPrayerTimeCard('Subuh', prayerTimes['Fajr']),
              _buildPrayerTimeCard('Dzuhur', prayerTimes['Dhuhr']),
              _buildPrayerTimeCard('Ashar', prayerTimes['Asr']),
              _buildPrayerTimeCard('Maghrib', prayerTimes['Maghrib']),
              _buildPrayerTimeCard('Isya', prayerTimes['Isha']),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPrayerTimeCard(String name, String? time) {
    return Card(
      child: ListTile(
        title: Text(
          '$name: ${time ?? 'Data tidak tersedia'}',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}



class SurahService {
  // Load Surah by its number (e.g., 2 for Al-Baqarah)
  Future<List<String>> loadSurah(int surahNumber) async {
    try {
      // Load the JSON file from assets
      String jsonData = await rootBundle.loadString('assets/data/arabic_verse_uthmani$surahNumber.json');

      // Decode the JSON
      Map<String, dynamic> data = json.decode(jsonData);

      // Get the list of verses
      List<String> verses = List<String>.from(data['verses']);

      return verses;
    } catch (e) {
      print('Error loading Surah: $e');
      return [];
    }
  }
}

class SurahPage extends StatelessWidget {
  final int surahNumber;

  SurahPage({required this.surahNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surah $surahNumber'),
      ),
      body: FutureBuilder<List<String>>(
        future: SurahService().loadSurah(surahNumber),  // Calling the loadSurah method
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading Surah.'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No verses found.'));
          } else {
            // Display the verses of the Surah
            List<String> verses = snapshot.data!;
            return ListView.builder(
              itemCount: verses.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(verses[index]),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class Ayah {
  final int number;
  final String text;

  Ayah({required this.number, required this.text});

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      number: json['number'],
      text: json['text'],
    );
  }
}

class Surah {
  final int id;
  final String name;
  final List<Ayah> ayahs;

  Surah({required this.id, required this.name, required this.ayahs});

  factory Surah.fromJson(Map<String, dynamic> json) {
    var list = json['ayahs'] as List;
    List<Ayah> ayahsList = list.map((i) => Ayah.fromJson(i)).toList();

    return Surah(
      id: json['id'],
      name: json['name'],
      ayahs: ayahsList,
    );
  }
}
//update