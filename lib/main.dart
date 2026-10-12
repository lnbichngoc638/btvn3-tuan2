import 'package:flutter/material.dart';

// Bước 1: class Student gồm name và score (có thể null)
class Student {
  final String name;
  final double? score;

  Student({required this.name, this.score});
}

// Dữ liệu khai báo sẵn
final List<Student> students = [
  Student(name: 'Nguyễn Văn An', score: 9.0),
  Student(name: 'Trần Thị Bình', score: 7.2),
  Student(name: 'Lê Minh Chi', score: null),
  Student(name: 'Phạm Quốc Dũng', score: 4.5),
  Student(name: 'Võ Thanh Em', score: 5.8),
];

const Color navy = Color(0xFF2B4478);

// ---- Dùng lại hàm của Bài 2 ----
String xepLoai(double d) {
  if (d < 0 || d > 10) {
    return 'Không hợp lệ';
  } else if (d >= 8.0) {
    return 'Giỏi';
  } else if (d >= 6.5) {
    return 'Khá';
  } else if (d >= 5.0) {
    return 'Trung bình';
  } else {
    return 'Yếu';
  }
}

Color mauChu(String loai) {
  if (loai == 'Giỏi') {
    return const Color(0xFF2E7D32);
  } else if (loai == 'Khá') {
    return const Color(0xFF1E5AA8);
  } else if (loai == 'Trung bình') {
    return const Color(0xFFB26A00);
  } else if (loai == 'Yếu') {
    return const Color(0xFFC62828);
  } else {
    return const Color(0xFF757575);
  }
}
// --------------------------------

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BangDiemScreen(),
    );
  }
}

class BangDiemScreen extends StatelessWidget {
  const BangDiemScreen({super.key});

  // Một ô thống kê trong thẻ xanh: nhãn nhỏ + giá trị
  Widget _buildStat(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, color: Colors.white70),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  // Bước 2: thẻ của một sinh viên (có xử lý score == null)
  Widget _buildStudentCard(Student s) {
    final double? diem = s.score;

    String loai;
    Color mau;
    String diemText;

    if (diem == null) {
      loai = 'Chưa có điểm';
      mau = const Color(0xFF757575);
      diemText = '—';
    } else {
      loai = xepLoai(diem);
      mau = mauChu(loai);
      diemText = diem.toStringAsFixed(1);
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                s.name,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                loai,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: mau,
                ),
              ),
            ],
          ),
          Text(
            diemText,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: diem == null ? Colors.black38 : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Bước 3: dùng for + if để tính các thống kê
    double tongDiem = 0;
    int soCoDiem = 0;
    int soGioi = 0;
    int soChuaCoDiem = 0;
    double? caoNhat;

    for (final s in students) {
      final double? diem = s.score;

      if (diem == null) {
        soChuaCoDiem++; // chưa có điểm: bỏ qua khi tính trung bình
      } else {
        tongDiem += diem;
        soCoDiem++;

        if (xepLoai(diem) == 'Giỏi') {
          soGioi++;
        }
        if (caoNhat == null || diem > caoNhat) {
          caoNhat = diem;
        }
      }
    }

    double diemTrungBinh = 0;
    if (soCoDiem > 0) {
      diemTrungBinh = tongDiem / soCoDiem;
    }

    String caoNhatText = '—';
    if (caoNhat != null) {
      caoNhatText = caoNhat.toStringAsFixed(1);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        title: const Text(
          'Bảng điểm lớp',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      body: Container(
        width: double.infinity,
        color: const Color(0xFFF2F4F8),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thẻ thống kê màu xanh
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: navy,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Điểm trung bình lớp',
                    style: TextStyle(fontSize: 13, color: Colors.white70),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    diemTrungBinh.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 44,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(height: 1, color: Colors.white24),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStat('Giỏi', '$soGioi'),
                      _buildStat('Chưa có điểm', '$soChuaCoDiem'),
                      _buildStat('Cao nhất', caoNhatText),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            Text(
              'DANH SÁCH · ${students.length} SINH VIÊN',
              style: const TextStyle(
                fontSize: 12,
                letterSpacing: 1,
                fontWeight: FontWeight.w600,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 8),

            // Bước 2: dùng for để hiển thị từng sinh viên
            for (final s in students) _buildStudentCard(s),
          ],
        ),
      ),
    );
  }
}