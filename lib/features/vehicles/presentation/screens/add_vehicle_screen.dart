import 'package:flutter/material.dart';

import '../../../../core/services/api_service.dart';

class AddVehicleScreen extends StatefulWidget {
  const AddVehicleScreen({super.key});

  @override
  State<AddVehicleScreen> createState() => _AddVehicleScreenState();
}

class _AddVehicleScreenState extends State<AddVehicleScreen> {

  String _selectedVehicleType = 'Car';

  bool _isSaving = false;

  final TextEditingController _brandController =
  TextEditingController();

  final TextEditingController _modelController =
  TextEditingController();

  final TextEditingController _registrationController =
  TextEditingController();

  @override
  void dispose() {
    _brandController.dispose();
    _modelController.dispose();
    _registrationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0B0F12),
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  32,
                  20,
                  24,
                ),
                child: Column(
                  children: [
                    _buildVehicleIcon(),

                    const SizedBox(height: 24),

                    _buildTitle(),

                    const SizedBox(height: 40),

                    _buildVehicleTypeField(),

                    const SizedBox(height: 26),

                    _buildTextField(
                      label: 'Vehicle Brand',
                      hint: 'e.g. Hyundai',
                      controller: _brandController,
                    ),

                    const SizedBox(height: 26),

                    _buildTextField(
                      label: 'Model',
                      hint: 'e.g. Creta',
                      controller: _modelController,
                    ),

                    const SizedBox(height: 26),

                    _buildTextField(
                      label: 'Registration Number',
                      hint: 'e.g. GJ01AB1234',
                      controller: _registrationController,
                    ),

                    const SizedBox(height: 52),

                    _buildAddVehicleButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // TOP BAR
  // ============================================================

  Widget _buildTopBar() {
    return Container(
      height: 58,
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
            ),
          ),

          const Expanded(
            child: Center(
              child: Text(
                'Add Vehicle',
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
  // VEHICLE ICON
  // ============================================================

  Widget _buildVehicleIcon() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: const Color(0xFF151A1E),
        border: Border.all(
          color: const Color(0xFF252C32),
        ),
      ),
      child: const Icon(
        Icons.directions_car_outlined,
        color: Color(0xFFB9CBFF),
        size: 32,
      ),
    );
  }

  // ============================================================
  // TITLE
  // ============================================================

  Widget _buildTitle() {
    return const Column(
      children: [
        Text(
          'Add your vehicle',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFE8EAF0),
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: 12),

        Text(
          'Save your vehicle details for faster\nbooking next time.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFB0B8C4),
            fontSize: 15,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // VEHICLE TYPE
  // ============================================================

  Widget _buildVehicleTypeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Vehicle Type',
          style: TextStyle(
            color: Color(0xFFBFC6D2),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        DropdownButtonFormField<String>(
          value: _selectedVehicleType,
          decoration: _inputDecoration(),
          dropdownColor: const Color(0xFF1B1F22),
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: Color(0xFFA8AFBB),
          ),
          style: const TextStyle(
            color: Color(0xFFE1E4E9),
            fontSize: 15,
          ),
          items: const [
            DropdownMenuItem(
              value: 'Car',
              child: Text('Car'),
            ),
          ],
          onChanged: (value) {
            if (value == null) return;

            setState(() {
              _selectedVehicleType = value;
            });
          },
        ),
      ],
    );
  }

  // ============================================================
  // TEXT FIELD
  // ============================================================

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFFBFC6D2),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: controller,
          style: const TextStyle(
            color: Color(0xFFE1E4E9),
            fontSize: 15,
          ),
          decoration: _inputDecoration().copyWith(
            hintText: hint,
            hintStyle: const TextStyle(
              color: Color(0xFF777F8B),
              fontSize: 15,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // COMMON INPUT DECORATION
  // ============================================================

  InputDecoration _inputDecoration() {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFF1B1F22),
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF30363D),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF30363D),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF8FAFFF),
        ),
      ),
    );
  }

  // ============================================================
  // ADD VEHICLE BUTTON
  // ============================================================

  // Widget _buildAddVehicleButton() {
  //   return SizedBox(
  //     width: double.infinity,
  //     height: 56,
  //     child: ElevatedButton(
  //       onPressed: () {
  //         // Save functionality will be added
  //         if (_brandController.text.trim().isEmpty ||
  //             _modelController.text.trim().isEmpty ||
  //             _registrationController.text.trim().isEmpty) {
  //           ScaffoldMessenger.of(context).showSnackBar(
  //             const SnackBar(
  //               content: Text('Please fill in all vehicle details.'),
  //             ),
  //           );
  //           return;
  //         }
  //
  //         Navigator.of(context).pop({
  //           'type': _selectedVehicleType,
  //           'brand': _brandController.text.trim(),
  //           'model': _modelController.text.trim(),
  //           'registration': _registrationController.text.trim(),
  //         });
  //       },
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: const Color(0xFF2878E8),
  //         foregroundColor: Colors.white,
  //         elevation: 0,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(11),
  //         ),
  //       ),
  //       child: const Row(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           Text(
  //             'Add Vehicle',
  //             style: TextStyle(
  //               fontSize: 15,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //           SizedBox(width: 10),
  //           Icon(
  //             Icons.arrow_forward,
  //             size: 20,
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildAddVehicleButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isSaving
            ? null
            : () async {
          final brand = _brandController.text.trim();
          final model = _modelController.text.trim();
          final registration =
          _registrationController.text.trim();

          if (brand.isEmpty ||
              model.isEmpty ||
              registration.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Please fill in all vehicle details.',
                ),
              ),
            );
            return;
          }

          setState(() {
            _isSaving = true;
          });

          final result = await ApiService.addVehicle(
            brand: brand,
            model: model,
            registrationNumber: registration,
          );

          if (!mounted) return;

          setState(() {
            _isSaving = false;
          });

          if (result['success'] == true) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  'Vehicle added successfully.',
                ),
              ),
            );

            // The My Vehicles screen will reload the list.
            Navigator.of(context).pop(true);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  result['message']?.toString() ??
                      'Unable to add vehicle. Please try again.',
                ),
              ),
            );
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2878E8),
          foregroundColor: Colors.white,
          disabledBackgroundColor: const Color(0xFF46556B),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(11),
          ),
        ),
        child: _isSaving
            ? const SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.white,
          ),
        )
            : const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Add Vehicle',
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
    );
  }


}