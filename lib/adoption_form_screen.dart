import 'package:flutter/material.dart';
import 'theme_provider.dart';

class AdoptionFormScreen extends StatefulWidget {
  const AdoptionFormScreen({super.key});

  @override
  State<AdoptionFormScreen> createState() => _AdoptionFormScreenState();
}

class _AdoptionFormScreenState extends State<AdoptionFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String? fullName;
  String? email;
  String? phone;
  String? address;
  String? petPreference;
  String? idCardNumber;
  bool agreeToTerms = false;

  @override
  Widget build(BuildContext context) {
    // Get arguments from navigation if available
    final Map<String, dynamic>? args = 
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String petName = args?['petName'] ?? 'Pet';
    final String petImage = args?['petImage'] ?? '';
    
    return Scaffold(
      backgroundColor: ThemeProvider.lightBackground,
      appBar: AppBar(
        backgroundColor: ThemeProvider.primaryAmber,
        foregroundColor: ThemeProvider.lightTextColor,
        elevation: 0,
        title: Text(
          "Adoption Application",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: ThemeProvider.lightTextColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Pet info header
            if (petImage.isNotEmpty)
              Container(
                height: 150,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ThemeProvider.primaryAmber.withOpacity(0.2),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      margin: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: ThemeProvider.lightTextColor.withOpacity(0.2),
                            blurRadius: 8,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          petImage,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => 
                            Container(
                              color: ThemeProvider.lightBackground.withOpacity(0.7),
                              child: Icon(Icons.pets, size: 50, color: ThemeProvider.primaryAmber),
                            ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Adopting: $petName",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: ThemeProvider.lightTextColor,
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              "Please complete this form to apply for adoption",
                              style: TextStyle(
                                fontSize: 14,
                                color: ThemeProvider.secondaryTextColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Personal Information",
                      style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold,
                        color: ThemeProvider.lightTextColor,
                      ),
                    ),
                    Divider(height: 30, thickness: 1, color: ThemeProvider.primaryAmber.withOpacity(0.3)),

                    // Full Name
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: ThemeProvider.primaryAmber),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: ThemeProvider.primaryAmber, width: 2),
                        ),
                        prefixIcon: Icon(Icons.person, color: ThemeProvider.primaryAmber),
                        labelStyle: TextStyle(color: ThemeProvider.secondaryTextColor),
                        filled: true,
                        fillColor: ThemeProvider.lightCardColor,
                      ),
                      validator: (value) => value!.isEmpty ? 'Please enter your name' : null,
                      onSaved: (value) => fullName = value,
                    ),
                    const SizedBox(height: 16),

                    // Email
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: ThemeProvider.primaryAmber),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: ThemeProvider.primaryAmber, width: 2),
                        ),
                        prefixIcon: Icon(Icons.email, color: ThemeProvider.primaryAmber),
                        labelStyle: TextStyle(color: ThemeProvider.secondaryTextColor),
                        filled: true,
                        fillColor: ThemeProvider.lightCardColor,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.isEmpty ? 'Please enter email' : null,
                      onSaved: (value) => email = value,
                    ),
                    const SizedBox(height: 16),

                    // Phone
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: ThemeProvider.primaryAmber),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: ThemeProvider.primaryAmber, width: 2),
                        ),
                        prefixIcon: Icon(Icons.phone, color: ThemeProvider.primaryAmber),
                        labelStyle: TextStyle(color: ThemeProvider.secondaryTextColor),
                        filled: true,
                        fillColor: ThemeProvider.lightCardColor,
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value!.isEmpty ? 'Please enter phone number' : null,
                      onSaved: (value) => phone = value,
                    ),
                    const SizedBox(height: 16),

                    // Address
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Home Address',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: ThemeProvider.primaryAmber),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: ThemeProvider.primaryAmber, width: 2),
                        ),
                        prefixIcon: Icon(Icons.home, color: ThemeProvider.primaryAmber),
                        labelStyle: TextStyle(color: ThemeProvider.secondaryTextColor),
                        filled: true,
                        fillColor: ThemeProvider.lightCardColor,
                      ),
                      maxLines: 2,
                      validator: (value) => value!.isEmpty ? 'Please enter your address' : null,
                      onSaved: (value) => address = value,
                    ),
                    const SizedBox(height: 24),
                    
                    Text(
                      "Adoption Details",
                      style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold,
                        color: ThemeProvider.lightTextColor,
                      ),
                    ),
                    Divider(height: 30, thickness: 1, color: ThemeProvider.primaryAmber.withOpacity(0.3)),

                    // Pet Preference
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Pet Preference',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: ThemeProvider.primaryAmber),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: ThemeProvider.primaryAmber, width: 2),
                        ),
                        prefixIcon: Icon(Icons.pets, color: ThemeProvider.primaryAmber),
                        labelStyle: TextStyle(color: ThemeProvider.secondaryTextColor),
                        filled: true,
                        fillColor: ThemeProvider.lightCardColor,
                      ),
                      items: [
                        DropdownMenuItem(
                          value: 'Dog', 
                          child: Row(
                            children: [
                              Icon(Icons.pets, color: ThemeProvider.primaryAmber),
                              SizedBox(width: 10),
                              Text('Dog'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Cat', 
                          child: Row(
                            children: [
                              Icon(Icons.pets, color: ThemeProvider.primaryAmber),
                              SizedBox(width: 10),
                              Text('Cat'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Bird', 
                          child: Row(
                            children: [
                              Icon(Icons.flutter_dash, color: ThemeProvider.primaryAmber),
                              SizedBox(width: 10),
                              Text('Bird'),
                            ],
                          ),
                        ),
                        DropdownMenuItem(
                          value: 'Other', 
                          child: Row(
                            children: [
                              Icon(Icons.all_inclusive, color: ThemeProvider.primaryAmber),
                              SizedBox(width: 10),
                              Text('Other'),
                            ],
                          ),
                        ),
                      ],
                      onChanged: (value) => petPreference = value,
                      validator: (value) => value == null ? 'Please select a preference' : null,
                    ),
                    const SizedBox(height: 16),

                    // ID Card Number
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'National ID Card Number (CNIC)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: ThemeProvider.primaryAmber),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: ThemeProvider.primaryAmber, width: 2),
                        ),
                        prefixIcon: Icon(Icons.badge, color: ThemeProvider.primaryAmber),
                        labelStyle: TextStyle(color: ThemeProvider.secondaryTextColor),
                        filled: true,
                        fillColor: ThemeProvider.lightCardColor,
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Please enter ID card number' : null,
                      onSaved: (value) => idCardNumber = value,
                    ),
                    const SizedBox(height: 24),
                    
                    Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        fontSize: 20, 
                        fontWeight: FontWeight.bold,
                        color: ThemeProvider.lightTextColor,
                      ),
                    ),
                    Divider(height: 30, thickness: 1, color: ThemeProvider.primaryAmber.withOpacity(0.3)),

                    // Agreement Checkbox
                    Container(
                      decoration: BoxDecoration(
                        color: ThemeProvider.lightCardColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: !agreeToTerms ? ThemeProvider.errorColor.withOpacity(0.5) : ThemeProvider.primaryAmber.withOpacity(0.5),
                          width: 1,
                        ),
                      ),
                      child: CheckboxListTile(
                        title: Text(
                          "I agree to provide proper care and shelter for the adopted pet.",
                          style: TextStyle(fontSize: 15),
                        ),
                        value: agreeToTerms,
                        onChanged: (value) {
                          setState(() {
                            agreeToTerms = value!;
                          });
                        },
                        activeColor: ThemeProvider.primaryAmber,
                        checkColor: ThemeProvider.lightCardColor,
                        controlAffinity: ListTileControlAffinity.leading,
                        subtitle: !agreeToTerms
                            ? Text(
                                'You must accept before submitting.',
                                style: TextStyle(
                                  color: ThemeProvider.errorColor,
                                  fontSize: 12,
                                ),
                              )
                            : null,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Submit Button
                    Container(
                      width: double.infinity,
                      height: 55,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate() && agreeToTerms) {
                            _formKey.currentState!.save();
                            
                            // Show loading dialog
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Row(
                                    children: [
                                      CircularProgressIndicator(color: ThemeProvider.primaryAmber),
                                      SizedBox(width: 20),
                                      Text("Submitting application..."),
                                    ],
                                  ),
                                );
                              },
                            );
                            
                            // Simulate network delay
                            Future.delayed(Duration(seconds: 2), () {
                              Navigator.pop(context); // Close loading dialog
                              
                              // Show success dialog
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                    title: Row(
                                      children: [
                                        Icon(Icons.check_circle, color: ThemeProvider.accentColor, size: 28),
                                        SizedBox(width: 10),
                                        Text("Application Submitted"),
                                      ],
                                    ),
                                    content: Text(
                                      "Your adoption application has been submitted successfully. We will review your application and contact you soon.",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context); // Close dialog
                                          Navigator.pop(context); // Go back to previous screen
                                        },
                                        child: Text(
                                          "OK",
                                          style: TextStyle(color: ThemeProvider.primaryAmber),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                          }
                        },
                        icon: Icon(Icons.pets, size: 24),
                        label: Text(
                          "Submit Adoption Application",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeProvider.primaryAmber,
                          foregroundColor: ThemeProvider.lightTextColor,
                          elevation: 4,
                          shadowColor: ThemeProvider.primaryAmber.withOpacity(0.5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ])
      )
    );
  }
}
