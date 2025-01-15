import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutView extends StatelessWidget {
  const AboutView({Key? key}) : super(key: key);

  final List<Map<String, String>> members = const [
    {
      'name': 'Phùng Văn Được',
      'studentId': '21130327',
      'class': 'DH21DTA',
      'image': 'assets/images/avataDuoc.jpg',
    },
    {
      'name': 'Lê Thành Tâm',
      'studentId': '21130526',
      'class': 'DH21DTA',
      'image': 'assets/images/godzulaThum.jpg',
    },
    {
      'name': 'Khổng Hữu Nhân',
      'studentId': '21130459',
      'class': 'DH21DTC',
      'image': 'assets/images/avataNhan.jpg',
    },
    {
      'name': 'Trần Hoài Nam',
      'studentId': '21130450',
      'class': 'DH21DTC',
      'image': 'assets/images/avataNam.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF84BEFA), Color(0xFF97FF98)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with Back Icon and Title
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'About',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48), // Placeholder for alignment
                ],
              ),
              const SizedBox(height: 20),

              // About Section
              const Center(
                child: Column(
                  children: [
                    Text(
                      'Giới thiệu ứng dụng:',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'Chào mừng bạn đến với ứng dụng thương mại điện tử thời trang của chúng tôi! Đây là nền tảng hoàn hảo để bạn khám phá, mua sắm và quản lý nhu cầu thời trang một cách dễ dàng và tiện lợi.',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Với giao diện hiện đại, tốc độ truy cập nhanh chóng và trải nghiệm người dùng được tối ưu hóa, chúng tôi cam kết mang đến cho bạn một hành trình mua sắm trực tuyến đầy thú vị.',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              // Features Section

              const SizedBox(height: 30),

              // Meet the Team Section
              const Text(
                'Thành viên nhóm sáng tạo:',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
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
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
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
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Mã số sinh viên: ${member['studentId']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Lớp: ${member['class']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
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
      ),
    );
  }
}

