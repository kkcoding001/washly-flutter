import 'package:flutter/material.dart';

import '../../../booking/presentation/screens/select_vehicle_screen.dart';
import '../../../notifications/presentation/screens/notifications_screen.dart';
import '../../../profile/presentation/screens/profile_screen.dart';
import '../../../vehicles/presentation/screens/add_vehicle_screen.dart';
import '../../../booking/presentation/screens/bookings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  int _selectedIndex = 0;

  // Map<String, String>? _vehicle;
  final List<Map<String, String>> _vehicles = [];

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _selectedIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        // If user is on Bookings, Notifications, or Profile,
        // Android Back should return to Home tab.
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0;
          });
        }
      },
      child: Scaffold(
        backgroundColor: const Color(0xFF0B0F12),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _buildCurrentTab(),
              ),

              _buildBottomNavigationBar(),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // CURRENT TAB
  // ============================================================

  Widget _buildCurrentTab() {
    switch (_selectedIndex) {
      case 0:
        return _buildHomeContent();

      case 1:
        return BookingsScreen(
          onBackToHome: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
        );

      case 2:
        return NotificationsScreen(
          onBackToHome: () {
            setState(() {
              _selectedIndex = 0;
            });
          },
        );

      // case 3:
      //   return ProfileScreen(
      //     onBackToHome: () {
      //       setState(() {
      //         _selectedIndex = 0;
      //       });
      //     },
      //   );
      case 3:
        return ProfileScreen(
          onBackToHome: () {
            setState(() {
              _selectedIndex = 0;
            });
          },

          vehicles: _vehicles,

          onVehiclesChanged: (updatedVehicles) {
            setState(() {
              _vehicles
                ..clear()
                ..addAll(updatedVehicles);
            });
          },
        );

      default:
        return _buildHomeContent();
    }
  }

  // ============================================================
  // HOME CONTENT
  // ============================================================

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        20,
        16,
        20,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),

          const SizedBox(height: 28),

          _buildGreeting(),

          const SizedBox(height: 40),

          _buildHeroCard(),

          const SizedBox(height: 40),

          _buildUpcomingBookingHeader(),

          const SizedBox(height: 12),

          _buildEmptyBookingCard(),

          const SizedBox(height: 40),

          _buildVehiclesHeader(),

          const SizedBox(height: 12),

          _buildEmptyVehicleCard(),
        ],
      ),
    );
  }

  // ============================================================
  // PLACEHOLDER SCREENS
  // ============================================================

  Widget _buildPlaceholderScreen(
      String title,
      IconData icon,
      ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: const Color(0xFF9DBBFF),
            size: 48,
          ),

          const SizedBox(height: 16),

          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'This screen will be developed later.',
            style: TextStyle(
              color: Color(0xFF9EA6B3),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          // onTap: () {
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (_) => ProfileScreen(
          //         onBackToHome: () {
          //           Navigator.pop(context);
          //         },
          //       ),
          //     ),
          //   );
          // },
          onTap: () {
            setState(() {
              _selectedIndex = 3;
            });
          },
          child: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1B2025),
              border: Border.all(
                color: const Color(0xFF30363D),
              ),
            ),
            child: const Icon(
              Icons.person_outline,
              color: Color(0xFFBFC6D2),
              size: 23,
            ),
          ),
        ),

        const SizedBox(width: 12),

        const Text(
          'Washly',
          style: TextStyle(
            color: Color(0xFFB9CBFF),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),

        const Spacer(),

      ],
    );
  }

  // ============================================================
  // GREETING
  // ============================================================

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Good morning, Rahul',
          style: TextStyle(
            color: Color(0xFFE8EAF0),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 8),

        const Text(
          'Ready for a spotless drive?',
          style: TextStyle(
            color: Color(0xFF9EA6B3),
            fontSize: 15,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // HERO CARD
  // ============================================================

  Widget _buildHeroCard() {
    return Container(
      width: double.infinity,
      height: 282,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF283038),
        ),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF18242D),
            Color(0xFF10161B),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -50,
            top: -30,
            child: Container(
              width: 190,
              height: 190,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1769D5).withValues(
                  alpha: 0.12,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PREMIUM CAR CARE',
                  style: TextStyle(
                    color: Color(0xFFB8C2D2),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.6,
                  ),
                ),

                const SizedBox(height: 14),

                const Text(
                  'Take care of your car\nwithout the wait.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    height: 1.18,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 12),

                const SizedBox(
                  width: 255,
                  child: Text(
                    'Premium mobile detailing delivered to your location.',
                    style: TextStyle(
                      color: Color(0xFFB2BAC6),
                      fontSize: 14,
                      height: 1.45,
                    ),
                  ),
                ),

                const Spacer(),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'STARTING FROM',
                          style: TextStyle(
                            color: Color(0xFFB8C2D2),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          '₹300',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),

                    const Spacer(),

                    SizedBox(
                      height: 46,
                      child: ElevatedButton(
                        onPressed: () {
                          // Booking navigation will be added
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SelectVehicleScreen(
                                vehicles: _vehicles,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2878E8),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Text(
                              'Book a Wash',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            SizedBox(width: 8),

                            Icon(
                              Icons.arrow_forward,
                              size: 17,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // UPCOMING BOOKING
  // ============================================================

  Widget _buildUpcomingBookingHeader() {
    return const Text(
      'UPCOMING BOOKING',
      style: TextStyle(
        color: Color(0xFFB8C0CC),
        fontSize: 12,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildEmptyBookingCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 30,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF151A1E),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: const Color(0xFF252C32),
        ),
      ),
      child: Column(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF1B2025),
            ),
            child: const Icon(
              Icons.calendar_month_outlined,
              color: Color(0xFF9DBBFF),
              size: 28,
            ),
          ),

          const SizedBox(height: 18),

          const Text(
            'No upcoming bookings',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFE1E4E9),
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 10),

          const Text(
            'Your next wash will appear here\nonce you make a booking.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF9DA5B1),
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 18),

          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SelectVehicleScreen(
                    vehicles: _vehicles,
                  ),
                ),
              );
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF9DBBFF),
            ),
            child: const Text(
              'Book a Wash',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // VEHICLES
  // ============================================================

  Widget _buildVehiclesHeader() {
    return Row(
      children: [
        const Text(
          'YOUR VEHICLES',
          style: TextStyle(
            color: Color(0xFFB8C0CC),
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),

        const Spacer(),

        TextButton(
          onPressed: () async {
            // final vehicle = await Navigator.of(context).push<Map<String, String>>(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => const AddVehicleScreen(),
            //   ),
            // );
            final vehicle = await Navigator.push<Map<String, String>>(
              context,
              MaterialPageRoute(
                builder: (_) => const AddVehicleScreen(),
              ),
            );

            if (vehicle != null) {
              setState(() {
                _vehicles.add(vehicle);
              });
            }
          },
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF9DBBFF),
            padding: EdgeInsets.zero,
          ),
          child: const Text(
            '+ Add',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildEmptyVehicleCard() {
    if (_vehicles.isEmpty) {
      return Container(
        width: double.infinity,
        height: 74,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFF151A1E),
          borderRadius: BorderRadius.circular(11),
          border: Border.all(
            color: const Color(0xFF292F35),
          ),
        ),
        child: const Center(
          child: Text(
            'No Vehicle',
            style: TextStyle(
              color: Color(0xFF8E959F),
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    return Column(
      children: _vehicles.map((vehicle) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(
            bottom: 10,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFF151A1E),
            borderRadius: BorderRadius.circular(11),
            border: Border.all(
              color: const Color(0xFF292F35),
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: const BoxDecoration(
                  color: Color(0xFF1B2025),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                   Icons.directions_car_outlined,
                  color: const Color(0xFF9DBBFF),
                  size: 24,
                ),
              ),

              const SizedBox(width: 14),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${vehicle['brand']} ${vehicle['model']}',
                      style: const TextStyle(
                        color: Color(0xFFE1E4E9),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Text(
                      vehicle['registration'] ?? '',
                      style: const TextStyle(
                        color: Color(0xFF9DA5B1),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      height: 72,
      decoration: const BoxDecoration(
        color: Color(0xFF101417),
        border: Border(
          top: BorderSide(
            color: Color(0xFF252B31),
            width: 1,
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem(
              icon: Icons.home_outlined,
              label: 'Home',
              selected: _selectedIndex == 0,
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
            ),

            _buildNavItem(
              icon: Icons.calendar_month_outlined,
              label: 'Bookings',
              selected: _selectedIndex == 1,
              onTap: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),

            _buildNavItem(
              icon: Icons.notifications_none_outlined,
              label: 'Notifications',
              selected: _selectedIndex == 2,
              hasNotification: true,
              onTap: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),

            _buildNavItem(
              icon: Icons.person_outline,
              label: 'Profile',
              selected: _selectedIndex == 3,
              onTap: () {
                setState(() {
                  _selectedIndex = 3;
                });
              },
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required bool selected,
    required VoidCallback onTap,
    bool hasNotification = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 68,
        height: 52,
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF2878E8)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(26),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  icon,
                  color: selected
                      ? Colors.white
                      : const Color(0xFFA8AFBB),
                  size: 24,
                ),

                if (hasNotification)
                  Positioned(
                    right: -3,
                    top: -3,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF9A93),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 2),

            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.visible,
              style: TextStyle(
                color: selected
                    ? Colors.white
                    : const Color(0xFFA8AFBB),
                fontSize: 11,
                fontWeight: selected
                    ? FontWeight.w600
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }


}