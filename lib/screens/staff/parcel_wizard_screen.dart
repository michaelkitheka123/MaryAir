import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import '../../theme/app_theme.dart';
import '../../models/parcel_model.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/parcel_ticket_widget.dart';
import '../../widgets/dashed_container.dart';
import '../../data/airports_data.dart'; // Import airport data

class ParcelWizardScreen extends StatefulWidget {
  const ParcelWizardScreen({super.key});

  @override
  State<ParcelWizardScreen> createState() => _ParcelWizardScreenState();
}

class _ParcelWizardScreenState extends State<ParcelWizardScreen> {
  int _currentStep = 0;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _senderNameCtrl = TextEditingController();
  final _senderContactCtrl = TextEditingController();
  final _receiverNameCtrl = TextEditingController();
  final _receiverContactCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _weightCtrl = TextEditingController();
  final _dimsCtrl = TextEditingController();

  // State
  Uint8List? _parcelPhoto;
  String _commodityType = 'Others'; // Default

  // Route State
  String? _originCountry;
  String? _originAirportCode;
  String? _destCountry;
  String? _destAirportCode;

  String? _selectedFlight; // Optional/Preferred flight
  DateTime _flightDate = DateTime.now().add(const Duration(days: 1));
  double _calculatedCost = 0.0;

  // Commodity Options
  final List<String> _commodityTypes = [
    'General Goods',
    'Electronics',
    'Perishables',
    'Documents',
    'Fragile',
    'Others',
  ];

  // Mock Flights
  final List<String> _flights = [
    'MA101 (NBO-DXB)',
    'MA202 (DXB-LHR)',
    'MA305 (NBO-JFK)',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.maryBlack,
      appBar: AppBar(
        title: const Text('Send Parcel Wizard'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Steps Indicator
          _buildProgressIndicator(),

          Expanded(
            child: Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: const ColorScheme.dark(
                  primary: AppTheme.maryOrangeRed,
                ),
              ),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                child: Form(key: _formKey, child: _buildStepContent()),
              ),
            ),
          ),

          // Navigation
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      color: Colors.black26,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStepDot(0, 'Contacts'),
          _buildLine(0),
          _buildStepDot(1, 'Goods'),
          _buildLine(1),
          _buildStepDot(2, 'Flight'),
          _buildLine(2),
          _buildStepDot(3, 'Confirm'),
        ],
      ),
    );
  }

  Widget _buildStepDot(int index, String label) {
    bool isActive = index <= _currentStep;
    return Column(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: isActive ? AppTheme.maryOrangeRed : Colors.grey,
          child: Text(
            '${index + 1}',
            style: const TextStyle(fontSize: 10, color: Colors.white),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isActive ? Colors.white : Colors.grey,
            fontSize: 10,
          ),
        ),
      ],
    );
  }

  Widget _buildLine(int index) {
    return Container(
      width: 40,
      height: 2,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      color: index < _currentStep ? AppTheme.maryOrangeRed : Colors.grey,
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildStep1Contacts();
      case 1:
        return _buildStep2Goods();
      case 2:
        return _buildStep3Flight();
      case 3:
        return _buildStep4Review();
      default:
        return Container();
    }
  }

  Widget _buildStep1Contacts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sender Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Sender Name',
          hint: 'Full Name',
          controller: _senderNameCtrl,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Sender Contact',
          hint: 'Phone or Email',
          controller: _senderContactCtrl,
        ),
        const Divider(height: 32, color: Colors.grey),
        const Text(
          'Receiver Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Receiver Name',
          hint: 'Full Name',
          controller: _receiverNameCtrl,
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Receiver Contact',
          hint: 'Phone or Email',
          controller: _receiverContactCtrl,
        ),
      ],
    );
  }

  Widget _buildStep2Goods() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Parcel Details',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const SizedBox(height: 16),
        // Commodity Dropdown
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white24),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _commodityType,
              isExpanded: true,
              dropdownColor: AppTheme.maryBlack,
              style: const TextStyle(color: Colors.white),
              items: _commodityTypes.map((type) {
                return DropdownMenuItem(value: type, child: Text(type));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _commodityType = val);
              },
            ),
          ),
        ),
        const SizedBox(height: 16),
        CustomTextField(
          label: 'Description',
          hint: 'What is inside?',
          controller: _descCtrl,
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                label: 'Weight (kg) *',
                hint: '0.0',
                keyboardType: TextInputType.number,
                controller: _weightCtrl,
                validator: (val) {
                  if (val == null || val.isEmpty) return 'Required';
                  if (double.tryParse(val) == null) return 'Invalid';
                  return null;
                },
                onChanged: (val) => setState(() {}),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                label: 'Dimensions',
                hint: 'LxWxH cm',
                controller: _dimsCtrl,
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Photo Capture
        const Text('Parcel Photo', style: TextStyle(color: Colors.white70)),
        const SizedBox(height: 8),

        // Photo preview or placeholder
        DashedContainer(
          color: Colors.white24,
          dashLength: 5,
          gapLength: 5,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(12),
            ),
            child: _parcelPhoto == null
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.add_photo_alternate,
                        color: Colors.white54,
                        size: 40,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Add Photo',
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.memory(_parcelPhoto!, fit: BoxFit.cover),
                  ),
          ),
        ),
        const SizedBox(height: 12),

        // Camera and Gallery buttons
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _pickImage(ImageSource.camera),
                icon: const Icon(
                  Icons.camera_alt,
                  color: AppTheme.maryOrangeRed,
                ),
                label: const Text(
                  'Take Photo',
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.maryOrangeRed),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _pickImage(ImageSource.gallery),
                icon: const Icon(
                  Icons.photo_library,
                  color: AppTheme.maryOrangeRed,
                ),
                label: const Text(
                  'From Gallery',
                  style: TextStyle(color: Colors.white),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.maryOrangeRed),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStep3Flight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Route Selection',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),

        // Origin
        _buildDropdown(
          label: 'Origin Country',
          value: _originCountry,
          items: airportsByCountry.keys.toList(),
          onChanged: (val) => setState(() {
            _originCountry = val;
            _originAirportCode = null; // Reset airport
          }),
        ),
        if (_originCountry != null) ...[
          const SizedBox(height: 12),
          _buildDropdown(
            label: 'Origin Airport',
            value: _originAirportCode,
            items: airportsByCountry[_originCountry]!
                .map((a) => a.code)
                .toList(),
            onChanged: (val) => setState(() => _originAirportCode = val),
            displayMap: {
              for (var a in airportsByCountry[_originCountry!]!)
                a.code: '${a.code} - ${a.name}',
            },
          ),
        ],

        const SizedBox(height: 24),

        // Destination
        _buildDropdown(
          label: 'Destination Country',
          value: _destCountry,
          items: airportsByCountry.keys.toList(),
          onChanged: (val) => setState(() {
            _destCountry = val;
            _destAirportCode = null;
          }),
        ),
        if (_destCountry != null) ...[
          const SizedBox(height: 12),
          _buildDropdown(
            label: 'Destination Airport',
            value: _destAirportCode,
            items: airportsByCountry[_destCountry]!.map((a) => a.code).toList(),
            onChanged: (val) => setState(() => _destAirportCode = val),
            displayMap: {
              for (var a in airportsByCountry[_destCountry!]!)
                a.code: '${a.code} - ${a.name}',
            },
          ),
        ],

        const SizedBox(height: 24),
        const Divider(color: Colors.grey),
        const SizedBox(height: 16),

        const Text(
          'Flight (Optional)',
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedFlight,
              hint: const Text(
                'Auto-Assign / Select Flight',
                style: TextStyle(color: Colors.white54),
              ),
              dropdownColor: AppTheme.maryBlack,
              isExpanded: true,
              style: const TextStyle(color: Colors.white),
              items: _flights
                  .map((f) => DropdownMenuItem(value: f, child: Text(f)))
                  .toList(),
              onChanged: (val) => setState(() => _selectedFlight = val),
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'Cost Calculation',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // The original Text widget for Estimated Cost
              const Text(
                'Estimated Cost:',
                style: TextStyle(color: Colors.white70),
              ),
              // This is the line being changed based on the instruction
              Text(
                'KES ${_calculateCost().toStringAsFixed(2)}',
                style: const TextStyle(
                  color: AppTheme.maryOrangeRed,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStep4Review() {
    final parcel = _createParcel();
    return Column(
      children: [
        const Icon(Icons.check_circle, color: Colors.green, size: 60),
        const SizedBox(height: 16),
        const Text(
          'Review Information',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 24),
        ParcelTicketWidget(parcel: parcel),
      ],
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      color: Colors.black54,
      child: Row(
        children: [
          if (_currentStep > 0)
            Expanded(
              child: CustomButton(
                text: 'Back',
                isOutlined: true,
                onPressed: () => setState(() => _currentStep--),
              ),
            ),
          if (_currentStep > 0) const SizedBox(width: 16),
          Expanded(
            child: CustomButton(
              text: _currentStep == 3 ? 'Generate Ticket' : 'Next',
              onPressed: () async {
                if (_currentStep < 3) {
                  setState(() => _currentStep++);
                } else {
                  // Save Parcel logic
                  try {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (c) => const Center(
                        child: CircularProgressIndicator(
                          color: AppTheme.maryOrangeRed,
                        ),
                      ),
                    );

                    final parcel = _createParcel();
                    await FirebaseFirestore.instance
                        .collection('parcels')
                        .add(parcel.toJson());

                    if (mounted) {
                      Navigator.pop(context); // dismiss loader
                      Navigator.pop(context); // exit wizard
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Parcel Ticket Generated & Saved!'),
                        ),
                      );
                    }
                  } catch (e) {
                    if (mounted) Navigator.pop(context); // dismiss loader
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error saving parcel: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: source,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        final bytes = await image.readAsBytes();
        setState(() {
          _parcelPhoto = bytes;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                source == ImageSource.camera
                    ? 'Photo captured!'
                    : 'Photo selected from gallery!',
              ),
              backgroundColor: AppTheme.maryOrangeRed,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error picking image: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  double _calculateCost() {
    double weight = double.tryParse(_weightCtrl.text) ?? 0.0;
    double baseRate = 20.0;
    double weightRate = weight * 15.0; // $15/kg

    // Commodity Surcharge
    double surcharge = 1.0;
    if (_commodityType == 'Electronics') surcharge = 1.2;
    if (_commodityType == 'Perishables') surcharge = 1.3;
    if (_commodityType == 'Fragile') surcharge = 1.25;

    // Route Factor (Simplified)
    double distanceFactor = 1.0;
    if (_originCountry != null &&
        _destCountry != null &&
        _originCountry != _destCountry) {
      distanceFactor = 1.5; // International
    }

    return (baseRate + weightRate) * surcharge * distanceFactor;
  }

  Parcel _createParcel() {
    return Parcel(
      id: 'PKG-${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
      senderName: _senderNameCtrl.text,
      senderContact: _senderContactCtrl.text,
      receiverName: _receiverNameCtrl.text,
      receiverContact: _receiverContactCtrl.text,
      description: _descCtrl.text,
      weightKg: double.tryParse(_weightCtrl.text) ?? 0.0,
      dimensions: _dimsCtrl.text,
      commodityType: _commodityType,
      photoBytes: _parcelPhoto,
      flightNumber: _selectedFlight?.split(' ')[0] ?? 'PENDING',
      departureDate: _flightDate,
      origin: _originAirportCode ?? 'N/A',
      destination: _destAirportCode ?? 'N/A',
      cost: _calculateCost(),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    Map<String, String>? displayMap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: Colors.white10,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.white24),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              hint: Text(
                'Select $label',
                style: const TextStyle(color: Colors.white54),
              ),
              dropdownColor: AppTheme.maryBlack,
              isExpanded: true,
              style: const TextStyle(color: Colors.white),
              items: items.map((item) {
                return DropdownMenuItem(
                  value: item,
                  child: Text(
                    displayMap != null ? (displayMap[item] ?? item) : item,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
