import 'package:flutter/material.dart';
import 'package:washly/features/booking/presentation/screens/select_store_screen.dart';

class SelectServiceScreen extends StatefulWidget {
  final Map<String, String> selectedVehicle;

  const SelectServiceScreen({
    super.key,
    required this.selectedVehicle,
  });

  @override
  State<SelectServiceScreen> createState() =>
      _SelectServiceScreenState();
}

class _SelectServiceScreenState
    extends State<SelectServiceScreen> {
  int _selectedServiceIndex = 1;

  final List<Map<String, dynamic>> _services = [
    {
      'name': 'Basic Wash',
      'description': 'Essential exterior wash',
      'duration': '30 min',
      'price': '₹300',
      'icon': Icons.water_drop_outlined,
      'popular': false,
    },
    {
      'name': 'Premium Wash',
      'description': 'Deep exterior and interior clean',
      'duration': '45 min',
      'price': '₹500',
      'icon': Icons.auto_awesome_outlined,
      'popular': true,
    },
    {
      'name': 'Full Detailing',
      'description': 'Complete professional car detailing\nwith Oiling',
      'duration': '90 min',
      'price': '₹800',
      'icon': Icons.brush_outlined,
      'popular': false,
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
                      'Choose a Service',
                      style: TextStyle(
                        color: Color(0xFFE8EAF0),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    const SizedBox(height: 5),

                    const Text(
                      'Step 2 of 4',
                      style: TextStyle(
                        color: Color(0xFFB8C0CC),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 28),

                    _buildSelectedVehicle(),

                    const SizedBox(height: 38),

                    _buildServiceList(),
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
          'Step 2 of 4',
          style: TextStyle(
            color: Color(0xFFB8C0CC),
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),

        const SizedBox(height: 18),

        SizedBox(
          height: 78,
          child: Stack(
            children: [
              Positioned(
                left: 36,
                right: 36,
                top: 22,
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
                    completed: false,
                    active: true,
                  ),

                  _buildBookingStep(
                    icon: Icons.storefront_outlined,
                    label: 'Store',
                    completed: false,
                    active: false,
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
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: active
                  ? const Color(0xFF2878E8)
                  : completed
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
              size: 22,
            ),
          ),

          const SizedBox(height: 7),

          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: active
                  ? const Color(0xFF9DBBFF)
                  : completed
                  ? const Color(0xFFB8C0CC)
                  : const Color(0xFFB8C0CC),
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SELECTED VEHICLE
  // ============================================================

  // Widget _buildSelectedVehicle() {
  //   return Container(
  //     width: double.infinity,
  //     padding: const EdgeInsets.symmetric(
  //       horizontal: 16,
  //       vertical: 13,
  //     ),
  //     decoration: BoxDecoration(
  //       color: const Color(0xFF151A1E),
  //       borderRadius: BorderRadius.circular(8),
  //       border: Border.all(
  //         color: const Color(0xFF252B31),
  //       ),
  //     ),
  //     child: Text(
  //       '${widget.selectedVehicle['brand']} '
  //           '${widget.selectedVehicle['model']}'
  //           ' | '
  //           '${widget.selectedVehicle['registration']}',
  //       style: const TextStyle(
  //         color: Color(0xFFD6DBE4),
  //         fontSize: 14,
  //         fontWeight: FontWeight.w500,
  //       ),
  //     ),
  //   );
  // }
  Widget _buildSelectedVehicle() {
    final bool isMotorcycle =
        widget.selectedVehicle['type'] == 'Motorcycle';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF151A1E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF292F35),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: const BoxDecoration(
              color: Color(0xFF1D2633),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isMotorcycle
                  ? Icons.two_wheeler_outlined
                  : Icons.directions_car_outlined,
              color: const Color(0xFF9DBBFF),
              size: 24,
            ),
          ),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.selectedVehicle['brand']} '
                      '${widget.selectedVehicle['model']}',
                  style: const TextStyle(
                    color: Color(0xFFE1E4E9),
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  widget.selectedVehicle['registration'] ?? '',
                  style: const TextStyle(
                    color: Color(0xFF9DA5B1),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF9DBBFF),
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 4,
              ),
              minimumSize: Size.zero,
              tapTargetSize:
              MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text(
              'Change',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // SERVICE LIST
  // ============================================================

  Widget _buildServiceList() {
    return Column(
      children: List.generate(
        _services.length,
            (index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
            ),
            child: _buildServiceCard(
              service: _services[index],
              index: index,
            ),
          );
        },
      ),
    );
  }

  Widget _buildServiceCard({
    required Map<String, dynamic> service,
    required int index,
  }) {
    final bool selected =
        _selectedServiceIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedServiceIndex = index;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
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
                    ? const Color(0xFF9DBBFF)
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
                    Container(
                      width: 42,
                      height: 42,
                      decoration: const BoxDecoration(
                        color: Color(0xFF252A2F),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        service['icon'] as IconData,
                        color: const Color(0xFFB9CBFF),
                        size: 21,
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            service['name'] as String,
                            style: const TextStyle(
                              color: Color(0xFFE1E4E9),
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            service['description'] as String,
                            style: const TextStyle(
                              color: Color(0xFFB0B8C4),
                              fontSize: 12,
                              height: 1.4,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),

                    _buildSelectionIndicator(selected),
                  ],
                ),

                const SizedBox(height: 15),

                Container(
                  height: 1,
                  color: const Color(0xFF252B31),
                ),

                const SizedBox(height: 13),

                Row(
                  children: [
                    const Icon(
                      Icons.access_time_outlined,
                      color: Color(0xFFB0B8C4),
                      size: 17,
                    ),

                    const SizedBox(width: 5),

                    Text(
                      service['duration'] as String,
                      style: const TextStyle(
                        color: Color(0xFFC1C8D2),
                        fontSize: 13,
                      ),
                    ),

                    const Spacer(),

                    Text(
                      service['price'] as String,
                      style: const TextStyle(
                        color: Color(0xFFE1E4E9),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          if (service['popular'] == true)
            Positioned(
              right: 60,
              top: -1,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: const BoxDecoration(
                  color: Color(0xFF087A39),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                ),
                child: const Text(
                  'POPULAR',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.6,
                  ),
                ),
              ),
            ),
        ],
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
  // CONTINUE BUTTON
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
        height: 54,
        child: ElevatedButton(
          onPressed: () {
            final selectedService =
            _services[_selectedServiceIndex];

            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SelectStoreScreen(
                  selectedVehicle: widget.selectedVehicle,
                  selectedService: selectedService,
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
            mainAxisAlignment: MainAxisAlignment.center,
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