// pages/add_service_provider_page.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class AddServiceProviderPage extends StatefulWidget {
  const AddServiceProviderPage({super.key});

  @override
  State<AddServiceProviderPage> createState() => _AddServiceProviderPageState();
}

class _AddServiceProviderPageState extends State<AddServiceProviderPage> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _experienceController = TextEditingController();
  final _priceRangeController = TextEditingController();

  String _serviceCategory = 'Plumbing';
  bool _hasLicense = false;
  bool _providesEmergencyService = false;

  final List<String> _serviceCategories = [
    'Plumbing',
    'Electrical',
    'Cleaning',
    'Carpentry',
    'Painting',
    'AC Repair',
    'Appliance Repair',
    'Gardening',
    'Moving Services',
    'Home Security',
    'Pest Control',
    'Interior Design',
    'Other',
  ];

  // WhatsApp admin number for registration submissions
  final String _adminWhatsAppNumber = '+1234567890';

  @override
  void dispose() {
    _businessNameController.dispose();
    _ownerNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _experienceController.dispose();
    _priceRangeController.dispose();
    super.dispose();
  }

  Future<void> _submitRegistration() async {
    if (!_formKey.currentState!.validate()) return;

    final message = '''
🏪 *New Service Provider Registration*

👤 *Business Information:*
• Business Name: ${_businessNameController.text}
• Owner Name: ${_ownerNameController.text}
• Category: $_serviceCategory
• Phone: ${_phoneController.text}
• Email: ${_emailController.text}
• Location: ${_locationController.text}

💼 *Service Details:*
• Description: ${_descriptionController.text}
• Experience: ${_experienceController.text}
• Price Range: ${_priceRangeController.text}
• Licensed: ${_hasLicense ? 'Yes' : 'No'}
• Emergency Service: ${_providesEmergencyService ? 'Available' : 'Not Available'}

📅 *Applied on:* ${DateTime.now().toString().split('.')[0]}

⚠️ *Admin Action Required:* Please review and approve this registration.
    ''';

    final encodedMessage = Uri.encodeComponent(message);
    final whatsappUrl =
        'https://wa.me/$_adminWhatsAppNumber?text=$encodedMessage';

    try {
      if (await canLaunchUrl(Uri.parse(whatsappUrl))) {
        await launchUrl(
          Uri.parse(whatsappUrl),
          mode: LaunchMode.externalApplication,
        );
        _showSuccessDialog();
      } else {
        _showErrorDialog(
          'Could not open WhatsApp. Please make sure WhatsApp is installed.',
        );
      }
    } catch (e) {
      _showErrorDialog('Error submitting registration: $e');
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Icon(Icons.check, color: Colors.green),
              ),
              const SizedBox(width: 12),
              const Text('Application Sent!'),
            ],
          ),
          content: const Text(
            'Your registration application has been submitted. Our team will review your application and contact you within 24-48 hours.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // Go back to previous page
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF2196F3),
              ),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(width: 12),
              Text('Error'),
            ],
          ),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  String _getCategoryEmoji(String category) {
    switch (category) {
      case 'Plumbing':
        return '🔧';
      case 'Electrical':
        return '⚡';
      case 'Cleaning':
        return '🧹';
      case 'Carpentry':
        return '🔨';
      case 'Painting':
        return '🎨';
      case 'AC Repair':
        return '❄️';
      case 'Appliance Repair':
        return '🔧';
      case 'Gardening':
        return '🌱';
      case 'Moving Services':
        return '📦';
      case 'Home Security':
        return '🔒';
      case 'Pest Control':
        return '🐛';
      case 'Interior Design':
        return '🏠';
      default:
        return '🛠️';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Join as Service Provider',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        shadowColor: Colors.grey.withOpacity(0.1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: const Color(0xFF2196F3).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.store,
                        size: 30,
                        color: Color(0xFF2196F3),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Register Your Business',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Join our platform and connect with customers in your area. Fill out the form below to get started.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Business Information Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Business Information',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Business Name Field
                    TextFormField(
                      controller: _businessNameController,
                      decoration: InputDecoration(
                        labelText: 'Business Name',
                        prefixIcon: const Icon(
                          Icons.business,
                          color: Color(0xFF2196F3),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2196F3),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your business name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Owner Name Field
                    TextFormField(
                      controller: _ownerNameController,
                      decoration: InputDecoration(
                        labelText: 'Owner/Manager Name',
                        prefixIcon: const Icon(
                          Icons.person,
                          color: Color(0xFF2196F3),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2196F3),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter owner name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Service Category Dropdown
                    DropdownButtonFormField<String>(
                      value: _serviceCategory,
                      decoration: InputDecoration(
                        labelText: 'Service Category',
                        prefixIcon: const Icon(
                          Icons.category,
                          color: Color(0xFF2196F3),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2196F3),
                          ),
                        ),
                      ),
                      items:
                          _serviceCategories.map((String category) {
                            return DropdownMenuItem<String>(
                              value: category,
                              child: Row(
                                children: [
                                  Text(
                                    _getCategoryEmoji(category),
                                    style: const TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(category),
                                ],
                              ),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _serviceCategory = newValue!;
                        });
                      },
                    ),

                    const SizedBox(height: 16),

                    // Phone Field
                    TextFormField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Business Phone Number',
                        prefixIcon: const Icon(
                          Icons.phone,
                          color: Color(0xFF2196F3),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2196F3),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your business phone number';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Email Field
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Color(0xFF2196F3),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2196F3),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email address';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Location Field
                    TextFormField(
                      controller: _locationController,
                      decoration: InputDecoration(
                        labelText: 'Service Area/Location',
                        prefixIcon: Icon(
                          Icons.location_on,
                          color: Colors.grey[500],
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2196F3),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your service area';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Service Details Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Service Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Description Field
                    TextFormField(
                      controller: _descriptionController,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: 'Service Description',
                        hintText: 'Describe your services and specialties...',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.only(bottom: 40),
                          child: Icon(
                            Icons.description,
                            color: Color(0xFF2196F3),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2196F3),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please provide a service description';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Experience Field
                    TextFormField(
                      controller: _experienceController,
                      decoration: InputDecoration(
                        labelText: 'Years of Experience',
                        prefixIcon: const Icon(
                          Icons.work,
                          color: Color(0xFF2196F3),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2196F3),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your experience';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // Price Range Field
                    TextFormField(
                      controller: _priceRangeController,
                      decoration: InputDecoration(
                        labelText: 'Price Range',
                        hintText: 'e.g., ₹500-2000 per service',
                        prefixIcon: const Icon(
                          Icons.currency_rupee,
                          color: Color(0xFF2196F3),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: Color(0xFF2196F3),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your price range';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 16),

                    // License Checkbox
                    CheckboxListTile(
                      value: _hasLicense,
                      onChanged: (bool? value) {
                        setState(() {
                          _hasLicense = value ?? false;
                        });
                      },
                      title: const Text('I have valid licenses/certifications'),
                      subtitle: const Text('Required for certain services'),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: const Color(0xFF2196F3),
                    ),

                    // Emergency Service Checkbox
                    CheckboxListTile(
                      value: _providesEmergencyService,
                      onChanged: (bool? value) {
                        setState(() {
                          _providesEmergencyService = value ?? false;
                        });
                      },
                      title: const Text('I provide emergency services'),
                      subtitle: const Text(
                        'Available 24/7 for urgent requests',
                      ),
                      controlAffinity: ListTileControlAffinity.leading,
                      activeColor: const Color(0xFF2196F3),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Submit Button Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.verified_user,
                            color: Colors.green,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Submit for Review',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                'Your application will be reviewed within 24-48 hours',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: _submitRegistration,
                      icon: const Icon(Icons.send, size: 20),
                      label: const Text(
                        'Submit Registration',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2196F3),
                        foregroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
