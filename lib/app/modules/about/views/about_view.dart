import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  final List<Map<String, String>> members = const [
    {
      'name': 'Phùng Văn Được',
      'studentId': '21130327',
      'class': 'DH21DTA',
      'image': 'assets/images/product1.jpg',
    },
    {
      'name': 'Lê Thành Tâm',
      'studentId': '21130526',
      'class': 'DH21DTA',
      'image': 'assets/images/product1.jpg',
    },
    {
      'name': 'Khổng Hữu Nhân',
      'studentId': '21130459',
      'class': 'DH21DTC',
      'image': 'assets/images/product1.jpg',
    },
    {
      'name': 'Trần Hoài Nam',
      'studentId': '21130450',
      'class': 'DH21DTC',
      'image': 'assets/images/product1.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Center(
              child: Text(
                'About the Application',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              'Welcome to our clothing e-commerce application! This app provides a seamless shopping experience, enabling you to explore, purchase, and manage your fashion needs effortlessly.',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20),

            // Members Section
            Text(
              'Meet the Team',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),

            // Members List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: members.length,
              itemBuilder: (context, index) {
                final member = members[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        // Member Image
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(member['image']!),
                        ),
                        const SizedBox(width: 16),

                        // Member Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                member['name']!,
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Student ID: ${member['studentId']}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Class: ${member['class']}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
