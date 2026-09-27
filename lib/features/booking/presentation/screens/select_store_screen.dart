import 'package:flutter/material.dart';
import 'package:washly/features/booking/presentation/screens/select_date_screen.dart';

class SelectStoreScreen extends StatefulWidget {
  final Map<String, String> selectedVehicle;
  final Map<String, dynamic> selectedService;

  const SelectStoreScreen({
    super.key,
    required this.selectedVehicle,
    required this.selectedService,
  });

  @override
  State<SelectStoreScreen> createState() =>
      _SelectStoreScreenState();
}

class _SelectStoreScreenState
    extends State<SelectStoreScreen> {
  int _selectedStoreIndex = 0;

  final List<Map<String, dynamic>> _stores = [
    {
      'name': 'Bopal Car Wash',
      'location': 'Bopal, Ahmedabad',
      'hours': 'Open · 9:00 AM – 8:00 PM',
      'distance': '2.4 km away',
    },
    {
      'name': 'Satellite Car Wash',
      'location': 'Satellite, Ahmedabad',
      'hours': 'Open · 9:00 AM – 8:00 PM',
      'distance': '5.8 km away',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  24,
                  20,
                  24,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    _buildStepIndicator(),

                    const SizedBox(height: 28),

                    const Text(
                      'Choose a location',
                      style: TextStyle(
                        color: Color(0xFFE8EAF0),
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Where would you like to get your car washed?',
                      style: TextStyle(
                        color: Color(0xFFB8C0CC),
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    const SizedBox(height: 20),

                    _buildStoreList(),

                    const SizedBox(height: 14),

                    // _buildMapButton(),
                  ],
                ),
              ),
            ),

            _buildContinueButton(),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF252B31),
          ),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xFFD7DDE8),
              size: 24,
            ),
          ),

          const Expanded(
            child: Center(
              child: Text(
                'Book a Wash',
                style: TextStyle(
                  color: Color(0xFFE8EAF0),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),

          const SizedBox(width: 48),
        ],
      ),
    );
  }

  // ============================================================
  // STEP INDICATOR
  // ============================================================

  Widget _buildStepIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 3 of 4',
          style: TextStyle(
            color: Color(0xFFB8C0CC),
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 14),

        SizedBox(
          height: 68,
          child: Stack(
            children: [
              Positioned(
                left: 36,
                right: 36,
                top: 20,
                child: Container(
                  height: 3,
                  color: const Color(0xFF292F35),
                ),
              ),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  _buildBookingStep(
                    icon: Icons.directions_car_outlined,
                    label: 'Vehicle',
                    completed: true,
                    active: false,
                  ),

                  _buildBookingStep(
                    icon: Icons.local_car_wash_outlined,
                    label: 'Service',
                    completed: true,
                    active: false,
                  ),

                  _buildBookingStep(
                    icon: Icons.storefront_outlined,
                    label: 'Store',
                    completed: false,
                    active: true,
                  ),

                  _buildBookingStep(
                    icon: Icons.calendar_month_outlined,
                    label: 'Date',
                    completed: false,
                    active: false,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBookingStep({
    required IconData icon,
    required String label,
    required bool completed,
    required bool active,
  }) {
    return SizedBox(
      width: 72,
      child: Column(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: active || completed
                  ? const Color(0xFF2878E8)
                  : const Color(0xFF252A2F),
              shape: BoxShape.circle,
            ),
            child: Icon(
              completed && !active
                  ? Icons.check
                  : icon,
              color: active || completed
                  ? Colors.white
                  : const Color(0xFF9DA5B1),
              size: 20,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: active
                  ? const Color(0xFF9DBBFF)
                  : const Color(0xFFB8C0CC),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // STORE LIST
  // ============================================================

  Widget _buildStoreList() {
    return Column(
      children: List.generate(
        _stores.length,
            (index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
            ),
            child: _buildStoreCard(
              store: _stores[index],
              index: index,
            ),
          );
        },
      ),
    );
  }

  Widget _buildStoreCard({
    required Map<String, dynamic> store,
    required int index,
  }) {
    final bool selected =
        _selectedStoreIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStoreIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(
          24,
          18,
          24,
          16,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFF101D2F)
              : const Color(0xFF1B1F22),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? const Color(0xFF2878E8)
                : const Color(0xFF252B31),
            width: selected ? 1.2 : 1,
          ),
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        store['name'],
                        style: const TextStyle(
                          color: Color(0xFFE1E4E9),
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 5),

                      Row(
                        children: [
                          const Icon(
                            Icons.map_outlined,
                            color: Color(0xFFB0B8C4),
                            size: 15,
                          ),

                          const SizedBox(width: 4),

                          Text(
                            store['location'],
                            style: const TextStyle(
                              color: Color(0xFFB0B8C4),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                _buildSelectionIndicator(selected),
              ],
            ),

            const SizedBox(height: 18),

            Container(
              height: 1,
              color: const Color(0xFF252B31),
            ),

            const SizedBox(height: 13),

            Row(
              children: [
                const Icon(
                  Icons.circle,
                  color: Color(0xFF57D879),
                  size: 9,
                ),

                const SizedBox(width: 6),

                Expanded(
                  child: Text(
                    store['hours'],
                    style: const TextStyle(
                      color: Color(0xFFC1C8D2),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF30343A),
                    borderRadius:
                    BorderRadius.circular(6),
                  ),
                  child: Text(
                    store['distance'],
                    style: const TextStyle(
                      color: Color(0xFFBFC6D0),
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectionIndicator(bool selected) {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: selected
            ? const Color(0xFF2878E8)
            : Colors.transparent,
        border: Border.all(
          color: selected
              ? const Color(0xFF2878E8)
              : const Color(0xFF69717D),
          width: 1.5,
        ),
      ),
      child: selected
          ? const Icon(
        Icons.check,
        color: Colors.white,
        size: 16,
      )
          : null,
    );
  }

  // ============================================================
  // MAP
  // ============================================================

  // Widget _buildMapButton() {
  //   return GestureDetector(
  //     onTap: () {
  //       // Map screen will be implemented later.
  //     },
  //     child: Container(
  //       width: double.infinity,
  //       height: 120,
  //       decoration: BoxDecoration(
  //         color: const Color(0xFF151A1E),
  //         borderRadius: BorderRadius.circular(14),
  //         border: Border.all(
  //           color: const Color(0xFF4B535E),
  //           style: BorderStyle.solid,
  //         ),
  //       ),
  //       child: Column(
  //         mainAxisAlignment:
  //         MainAxisAlignment.center,
  //         children: [
  //           const Icon(
  //             Icons.map_outlined,
  //             color: Color(0xFFB8C0CC),
  //             size: 30,
  //           ),
  //
  //           const SizedBox(height: 7),
  //
  //           const Text(
  //             'Explore Map View',
  //             style: TextStyle(
  //               color: Color(0xFFB8C0CC),
  //               fontSize: 12,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  // ============================================================
  // CONTINUE
  // ============================================================

  Widget _buildContinueButton() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        20,
        12,
        20,
        16,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF0B0F12),
        border: Border(
          top: BorderSide(
            color: Color(0xFF252B31),
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 56,
        child: ElevatedButton(
          onPressed: () {
            final selectedStore =
            _stores[_selectedStoreIndex];

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SelectDateScreen(
                  selectedVehicle: widget.selectedVehicle,
                  selectedService: widget.selectedService,
                  selectedStore: selectedStore,
                ),
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2878E8),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(11),
            ),
          ),
          child: const Row(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              Text(
                'Continue',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(width: 10),

              Icon(
                Icons.arrow_forward,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}