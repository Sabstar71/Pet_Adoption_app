import 'package:flutter/material.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adoption Form"),
        backgroundColor: const Color.fromARGB(255, 255, 174, 67),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Fill out the Adoption Form",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Full Name
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator:
                    (value) => value!.isEmpty ? 'Please enter your name' : null,
                onSaved: (value) => fullName = value,
              ),
              const SizedBox(height: 12),

              // Email
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator:
                    (value) => value!.isEmpty ? 'Please enter email' : null,
                onSaved: (value) => email = value,
              ),
              const SizedBox(height: 12),

              // Phone
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.phone,
                validator:
                    (value) =>
                        value!.isEmpty ? 'Please enter phone number' : null,
                onSaved: (value) => phone = value,
              ),
              const SizedBox(height: 12),

              // Address
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Home Address',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
                validator:
                    (value) =>
                        value!.isEmpty ? 'Please enter your address' : null,
                onSaved: (value) => address = value,
              ),
              const SizedBox(height: 12),

              // Pet Preference
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: 'Pet Preference',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Dog', child: Text('Dog')),
                  DropdownMenuItem(value: 'Cat', child: Text('Cat')),
                  DropdownMenuItem(value: 'Bird', child: Text('Bird')),
                  DropdownMenuItem(value: 'Other', child: Text('Other')),
                ],
                onChanged: (value) => petPreference = value,
                validator:
                    (value) =>
                        value == null ? 'Please select a preference' : null,
              ),
              const SizedBox(height: 12),

              // ID Card Number
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'National ID Card Number (CNIC)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator:
                    (value) =>
                        value!.isEmpty ? 'Please enter ID card number' : null,
                onSaved: (value) => idCardNumber = value,
              ),
              const SizedBox(height: 12),

              // Agreement Checkbox
              CheckboxListTile(
                title: const Text(
                  "I agree to provide proper care and shelter for the adopted pet.",
                ),
                value: agreeToTerms,
                onChanged: (value) {
                  setState(() {
                    agreeToTerms = value!;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
                subtitle:
                    !agreeToTerms
                        ? const Text(
                          'You must accept before submitting.',
                          style: TextStyle(
                            color: Color.fromARGB(255, 151, 104, 43),
                          ),
                        )
                        : null,
              ),
              const SizedBox(height: 16),

              // Submit Button
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate() && agreeToTerms) {
                    _formKey.currentState!.save();
                    // Handle form submission
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Form Submitted Successfully'),
                      ),
                    );
                  }
                },
                icon: const Icon(Icons.pets),
                label: const Text("Submit Adoption Form"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 248, 202, 142),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
