import 'package:flutter/material.dart';
import 'package:washly/features/booking/presentation/screens/select_service_screen.dart';

class SelectVehicleScreen extends StatefulWidget {
  final List<Map<String, String>> vehicles;

  const SelectVehicleScreen({
    super.key,
    required this.vehicles,
  });

  @override
  State<SelectVehicleScreen> createState() =>
      _SelectVehicleScreenState();
}

class _SelectVehicleScreenState
    extends State<SelectVehicleScreen> {
  int? _selectedVehicleIndex;

  @override
  void initState() {
    super.initState();

    // Automatically select the first vehicle if available.
    if (widget.vehicles.isNotEmpty) {
      _selectedVehicleIndex = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: _buildContent(),
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
  // CONTENT
  // ============================================================

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(
        20,
        28,
        20,
        24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStepIndicator(),

          const SizedBox(height: 28),

          const Text(
            'Select your vehicle',
            style: TextStyle(
              color: Color(0xFFE8EAF0),
              fontSize: 25,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Choose the vehicle you want to get washed.',
            style: TextStyle(
              color: Color(0xFF9EA6B3),
              fontSize: 14,
              height: 1.5,
            ),
          ),

          const SizedBox(height: 28),

          if (widget.vehicles.isEmpty)
            _buildNoVehicleState()
          else
            _buildVehicleList(),

          const SizedBox(height: 20),


        ],
      ),
    );
  }

  // ============================================================
  // STEP INDICATOR
  // ============================================================

  // Widget _buildStepIndicator() {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       const Text(
  //         'STEP 1 OF 4',
  //         style: TextStyle(
  //           color: Color(0xFF9DBBFF),
  //           fontSize: 11,
  //           fontWeight: FontWeight.w700,
  //           letterSpacing: 1.4,
  //         ),
  //       ),
  //
  //       const SizedBox(height: 10),
  //
  //       Row(
  //         children: [
  //           _buildStepLine(true),
  //           _buildStepLine(false),
  //           _buildStepLine(false),
  //           _buildStepLine(false),
  //         ],
  //       ),
  //     ],
  //   );
  // }
  Widget _buildStepIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Step 1 of 4',
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
              // Connecting line
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
                    active: true,
                  ),

                  _buildBookingStep(
                    icon: Icons.local_car_wash_outlined,
                    label: 'Service',
                    active: false,
                  ),

                  _buildBookingStep(
                    icon: Icons.storefront_outlined,
                    label: 'Store',
                    active: false,
                  ),

                  _buildBookingStep(
                    icon: Icons.calendar_month_outlined,
                    label: 'Date',
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
                  : const Color(0xFF252A2F),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: active
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
  // VEHICLE LIST
  // ============================================================

  Widget _buildVehicleList() {
    return Column(
      children: List.generate(
        widget.vehicles.length,
            (index) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 12,
            ),
            child: _buildVehicleCard(
              widget.vehicles[index],
              index,
            ),
          );
        },
      ),
    );
  }

  Widget _buildVehicleCard(
      Map<String, String> vehicle,
      int index,
      ) {
    final bool selected =
        _selectedVehicleIndex == index;

    final bool isMotorcycle =
        vehicle['type'] == 'Motorcycle';

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedVehicleIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF151A1E),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: selected
                ? const Color(0xFF8FAFFF)
                : const Color(0xFF292F35),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFF1C2940)
                    : const Color(0xFF1B2025),
                shape: BoxShape.circle,
              ),
              child: Icon(
                isMotorcycle
                    ? Icons.two_wheeler_outlined
                    : Icons.directions_car_outlined,
                color: const Color(0xFF9DBBFF),
                size: 27,
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

                  const SizedBox(height: 5),

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

            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
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
                      : const Color(0xFF6D7581),
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
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // NO VEHICLE
  // ============================================================

  Widget _buildNoVehicleState() {
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
          color: const Color(0xFF292F35),
        ),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.directions_car_outlined,
            color: Color(0xFF9DBBFF),
            size: 40,
          ),

          SizedBox(height: 14),

          Text(
            'No vehicles added',
            style: TextStyle(
              color: Color(0xFFE1E4E9),
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          ),

          SizedBox(height: 8),

          Text(
            'Add a vehicle before continuing.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF9DA5B1),
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }



  // ============================================================
  // CONTINUE
  // ============================================================

  Widget _buildContinueButton() {
    final bool canContinue =
        _selectedVehicleIndex != null;

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
          onPressed: canContinue
              ? () {
            final selectedVehicle =
            widget.vehicles[_selectedVehicleIndex!];

            // Step 2 will be connected here.
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SelectServiceScreen(
                  selectedVehicle: selectedVehicle,
                ),
              ),
            );
          }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2878E8),
            disabledBackgroundColor:
            const Color(0xFF252B31),
            foregroundColor: Colors.white,
            disabledForegroundColor:
            const Color(0xFF707783),
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