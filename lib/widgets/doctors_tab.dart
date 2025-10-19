import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../constants/app_constants.dart';

class DoctorsTab extends StatelessWidget {
  DoctorsTab({Key? key}) : super(key: key);
  
  final List<Doctor> doctors = [
    Doctor(
      name: 'Dr. Priya Sharma',
      specialty: 'Gynecologist',
      rating: 4.9,
      reviews: 324,
      phone: '+880 1711 223344',
      experience: '15 years',
      image: '👨‍⚕️',
    ),
    Doctor(
      name: 'Dr. Anjali Patel',
      specialty: 'Reproductive Health',
      rating: 4.8,
      reviews: 287,
      phone: '+880 1811 334455',
      experience: '12 years',
      image: '👩‍⚕️',
    ),
    Doctor(
      name: 'Dr. Meera Kumar',
      specialty: 'Women\'s Health Specialist',
      rating: 4.7,
      reviews: 215,
      phone: '+880 1911 445566',
      experience: '10 years',
      image: '👨‍⚕️',
    ),
    Doctor(
      name: 'Dr. Sana Ahmed',
      specialty: 'Gynecologist',
      rating: 4.9,
      reviews: 412,
      phone: '+880 1611 556677',
      experience: '18 years',
      image: '👩‍⚕️',
    ),
  ];
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommended Doctors',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppConstants.textColor,
              ),
            ),
            SizedBox(height: 16),
            ...List.generate(
              doctors.length,
              (index) => Column(
                children: [
                  _buildDoctorCard(doctors[index], context),
                  SizedBox(height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildDoctorCard(Doctor doctor, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2),
          )
        ],
      ),
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppConstants.primaryColor, AppConstants.secondaryColor],
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Text(
                    doctor.image,
                    style: TextStyle(fontSize: 32),
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doctor.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppConstants.textColor,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      doctor.specialty,
                      style: TextStyle(
                        fontSize: 13,
                        color: AppConstants.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.star, size: 16, color: Color(0xFFFFB800)),
                        SizedBox(width: 4),
                        Text(
                          '${doctor.rating} (${doctor.reviews} reviews)',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Divider(height: 1, color: Colors.grey[200]),
          SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.work_outline, size: 16, color: Colors.grey[600]),
              SizedBox(width: 8),
              Text(
                '${doctor.experience} experience',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Calling ${doctor.name}...'),
                        backgroundColor: AppConstants.primaryColor,
                      ),
                    );
                  },
                  icon: Icon(Icons.call),
                  label: Text('Call'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppConstants.primaryColor,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Booking appointment with ${doctor.name}...'),
                        backgroundColor: AppConstants.secondaryColor,
                      ),
                    );
                  },
                  icon: Icon(Icons.calendar_today),
                  label: Text('Book'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppConstants.primaryColor,
                    side: BorderSide(color: AppConstants.primaryColor, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}