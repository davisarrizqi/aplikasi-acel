import 'package:flutter/material.dart';
import '../models/service.dart';
import 'booking.dart';
import 'akun.dart';  
import 'order.dart';   
import 'dart:ui';


class HomePage extends StatefulWidget {
  final VoidCallback onLogout;

  const HomePage({super.key, required this.onLogout});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Daftar lokasi spa
  final List<String> spaLocations = [
    'Condongcatur',
    'Seturan',
    'jl. Magelang km. 10',
    'Jakal km. 5',
    'Tamansiswa',
  ];

  // Daftar layanan spa
  final List<Service> services = [
    Service(name: "Massage Therapy", price: 50000, imagePath: 'assets/layanan1.jpg'),
    Service(name: "Facial Treatment", price: 120000, imagePath: 'assets/layanan2.jpg'),
    Service(name: "Manicure & Pedicure", price: 50000, imagePath: 'assets/layanan3.jpg'),
    Service(name: "Hair Styling", price: 90000, imagePath: 'assets/layanan4.jpg'),
    Service(name: "Body Scrub & Body Spa", price: 90000, imagePath: 'assets/layanan5.jpg'),
  ];



  String? selectedLocation;  
  int _selectedIndex = 0; 

  // Daftar halaman yang akan ditampilkan berdasarkan tab
  final List<Widget> _pages = [
    ServiceListPage(),  // Halaman daftar layanan
    AccountPage(),      // Halaman akun
    OrdersPage(),       // Halaman pesanan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text("Downtown Spa & Salon Services"),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: widget.onLogout,
          ),
        ],
      ),
      body: Stack(
        children: [
          
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/salon_spa.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Menambah blur
              child: Container(
                color: Colors.black.withOpacity(0.2), // Latar buram dan gelap
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      hint: const Text("Select a Spa Location"),
                      value: selectedLocation,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedLocation = newValue;
                        });
                      },
                      items: spaLocations.map((String location) {
                        return DropdownMenuItem<String>(
                          value: location,
                          child: Text(location),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16.0),
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.85),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: _pages[_selectedIndex],
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Akun',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Pesanan Saya',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

// Class ServiceListPage dengan bingkai tambahan
class ServiceListPage extends StatelessWidget {
  final List<Service> services = [
    Service(name: "Massage Therapy", price: 50000, imagePath: 'assets/layanan1.jpg'),
    Service(name: "Facial Treatment", price: 70000, imagePath: 'assets/layanan2.jpg'),
    Service(name: "Manicure & Pedicure", price: 30000, imagePath: 'assets/layanan3.jpg'),
    Service(name: "Hair Styling", price: 40000, imagePath: 'assets/layanan4.jpg'),
  ];

  final String? selectedLocation;

  ServiceListPage({super.key, this.selectedLocation});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: services.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 6,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ListTile(
            leading: Image.asset(services[index].imagePath, width: 50, height: 50, fit: BoxFit.cover),
            title: Text(services[index].name),
            subtitle: Text("Rp ${services[index].price.toStringAsFixed(0)}"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BookingPage(
                    service: services[index],
                    location: selectedLocation ?? 'Unknown',
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}