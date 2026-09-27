import 'package:flutter/material.dart';
import '../../../vehicles/presentation/screens/add_vehicle_screen.dart';
import 'edit_vehicle_screen.dart';

// class MyVehiclesScreen extends StatefulWidget {
//   const MyVehiclesScreen({super.key});
//
//   @override
//   State<MyVehiclesScreen> createState() => _MyVehiclesScreenState();
// }

class MyVehiclesScreen extends StatefulWidget {
  const MyVehiclesScreen({
    super.key,
    required this.vehicles,
    required this.onVehiclesChanged,
  });

  final List<Map<String, String>> vehicles;

  final ValueChanged<List<Map<String, String>>>
  onVehiclesChanged;

  @override
  State<MyVehiclesScreen> createState() =>
      _MyVehiclesScreenState();
}

class _MyVehiclesScreenState extends State<MyVehiclesScreen> {

  // final List<Map<String, String>> _vehicles = [
  //   {
  //     'brand': 'Hyundai',
  //     'model': 'Creta',
  //     'registration': 'GJ01AB1234',
  //     'type': 'CAR',
  //   },
  //   {
  //     'brand': 'Honda',
  //     'model': 'City',
  //     'registration': 'GJ05XY4567',
  //     'type': 'CAR',
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF0D1215),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              // child: _vehicles.isEmpty
              child: widget.vehicles.isEmpty
                  ? _buildEmptyState()
                  : _buildVehicleList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Color(0xFF20262B),
          ),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios_new,
                color: Color(0xFFDCE1EA),
                size: 21,
              ),
            ),
          ),
          const Text(
            'My Vehicles',
            style: TextStyle(
              color: Color(0xFFE7E9ED),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(40, 40, 40, 38),
          decoration: BoxDecoration(
            color: const Color(0xFF171C20),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF30363B),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 270,
                width: double.infinity,
                color: const Color(0xFF172025),
                child: const Icon(
                  Icons.directions_car_outlined,
                  color: Color(0xFF858B94),
                  size: 100,
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                'No vehicles yet',
                style: TextStyle(
                  color: Color(0xFFE3E6EA),
                  fontSize: 23,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 12),

              const Text(
                'Add your vehicle to make booking\nyour next wash faster.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFFB8BEC9),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),

              // const SizedBox(height: 28),

              // _buildAddVehicleButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVehicleList() {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 30),
      children: [
        const Text(
          'Your Vehicles',
          style: TextStyle(
            color: Color(0xFFE3E6EA),
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),

        const SizedBox(height: 24),

        // ..._vehicles.map(
        ...widget.vehicles.map(
              (vehicle) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: _buildVehicleCard(vehicle),
          ),
        ),
      ],
    );
  }

  Widget _buildVehicleCard(Map<String, String> vehicle) {
    return InkWell(
      onTap: () async {
        // final removed = await Navigator.push<bool>(
        //   context,
        //   MaterialPageRoute(
        //     builder: (_) => EditVehicleScreen(
        //       vehicle: vehicle,
        //     ),
        //   ),
        // );
        // final result = await Navigator.push(
        final result = await Navigator.push<Object?>(
          context,
          MaterialPageRoute(
            builder: (_) => EditVehicleScreen(
              vehicle: vehicle,
            ),
          ),
        );

        if (result == true) {
          // Remove vehicle
          final updatedVehicles =
          List<Map<String, String>>.from(widget.vehicles);

          updatedVehicles.remove(vehicle);

          widget.onVehiclesChanged(updatedVehicles);
        } else if (result is Map<String, String>) {
          // Update vehicle
          final updatedVehicles =
          List<Map<String, String>>.from(widget.vehicles);

          final index = updatedVehicles.indexOf(vehicle);

          if (index != -1) {
            updatedVehicles[index] = result;
            widget.onVehiclesChanged(updatedVehicles);
          }
        }

        // if (removed == true) {
        //   setState(() {
        //     // _vehicles.remove(vehicle);
        //     widget.vehicles.remove(vehicle);
        //   });
        // }

        // if (removed == true) {
        //   final updatedVehicles =
        //   List<Map<String, String>>.from(widget.vehicles);
        //
        //   updatedVehicles.remove(vehicle);
        //
        //   widget.onVehiclesChanged(updatedVehicles);
        // }

      },
      borderRadius: BorderRadius.circular(14),
      child: Container(
        height: 130,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: const Color(0xFF1B2024),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: const Color(0xFF292F35),
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 94,
              height: 106,
              decoration: BoxDecoration(
                color: const Color(0xFF172025),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFF293138),
                ),
              ),
              child: const Icon(
                Icons.directions_car_outlined,
                color: Color(0xFF9EA6B2),
                size: 48,
              ),
            ),

            const SizedBox(width: 24),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${vehicle['brand']} ${vehicle['model']}',
                    style: const TextStyle(
                      color: Color(0xFFE3E6EA),
                      fontSize: 19,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    vehicle['registration']!,
                    style: const TextStyle(
                      color: Color(0xFFB7BDC8),
                      fontSize: 15,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF353A40),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      vehicle['type']!,
                      style: const TextStyle(
                        color: Color(0xFFC8CDD5),
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const Text(
              'Edit',
              style: TextStyle(
                color: Color(0xFFAFC5FF),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget _buildAddVehicleButton() {
  //   return SizedBox(
  //     width: double.infinity,
  //     height: 60,
  //     child: ElevatedButton(
  //       onPressed: () async {
  //         final result = await Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (_) => const AddVehicleScreen(),
  //           ),
  //         );
  //
  //         if (result != null) {
  //           setState(() {
  //             // _vehicles.add(
  //             widget.vehicles.add(
  //               Map<String, String>.from(result),
  //             );
  //           });
  //         }
  //       },
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: const Color(0xFF2878E8),
  //         foregroundColor: Colors.white,
  //         elevation: 8,
  //         shadowColor: const Color(0x662878E8),
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(9),
  //         ),
  //       ),
  //       child: const Text(
  //         'Add Vehicle',
  //         style: TextStyle(
  //           fontSize: 18,
  //           fontWeight: FontWeight.w600,
  //         ),
  //       ),
  //     ),
  //   );
  // }
}