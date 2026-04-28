import java.util.ArrayList;
import java.util.Scanner;

public class QuanLyDiem {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ArrayList<Double> danhSachDiem = new ArrayList<>();

        while (true) {
            // Hiển thị menu
            System.out.println("\n===== MENU =====");
            System.out.println("1. Nhập điểm học viên");
            System.out.println("2. Hiển thị thống kê");
            System.out.println("3. Thoát chương trình");
            System.out.print("Chọn chức năng (1-3): ");
            int choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    // Nhập điểm học viên
                    while (true) {
                        System.out.print("Nhập điểm (0-10, nhập -1 để kết thúc): ");
                        double diem = scanner.nextDouble();

                        if (diem == -1) {
                            break; // kết thúc nhập
                        }

                        if (diem < 0 || diem > 10) {
                            System.out.println("Điểm không hợp lệ, vui lòng nhập lại!");
                            continue;
                        }

                        // Thêm vào danh sách
                        danhSachDiem.add(diem);

                        // Xếp loại học lực
                        if (diem < 5) {
                            System.out.println("Xếp loại: Yếu");
                        } else if (diem < 7) {
                            System.out.println("Xếp loại: Trung Bình");
                        } else if (diem < 8) {
                            System.out.println("Xếp loại: Khá");
                        } else if (diem < 9) {
                            System.out.println("Xếp loại: Giỏi");
                        } else {
                            System.out.println("Xếp loại: Xuất sắc");
                        }
                    }

                    // Sau khi nhập xong, thống kê nhanh
                    if (!danhSachDiem.isEmpty()) {
                        double tong = 0;
                        double max = danhSachDiem.get(0);
                        double min = danhSachDiem.get(0);

                        for (double d : danhSachDiem) {
                            tong += d;
                            if (d > max) max = d;
                            if (d < min) min = d;
                        }

                        System.out.println("\n--- Thống kê sau khi nhập ---");
                        System.out.println("Tổng số học viên: " + danhSachDiem.size());
                        System.out.println("Tổng điểm: " + tong);
                        System.out.println("Điểm cao nhất: " + max);
                        System.out.println("Điểm thấp nhất: " + min);
                    }
                    break;

                case 2:
                    // Hiển thị thống kê
                    if (danhSachDiem.isEmpty()) {
                        System.out.println("Chưa có dữ liệu");
                    } else {
                        double tong = 0;
                        double max = danhSachDiem.get(0);
                        double min = danhSachDiem.get(0);

                        for (double d : danhSachDiem) {
                            tong += d;
                            if (d > max) max = d;
                            if (d < min) min = d;
                        }

                        double diemTB = tong / danhSachDiem.size();

                        System.out.println("\n--- Thống kê ---");
                        System.out.println("Số học viên: " + danhSachDiem.size());
                        System.out.println("Điểm trung bình: " + diemTB);
                        System.out.println("Điểm cao nhất: " + max);
                        System.out.println("Điểm thấp nhất: " + min);
                    }
                    break;

                case 3:
                    // Thoát chương trình
                    System.out.println("Kết thúc chương trình.");
                    System.exit(0);
                    break;

                default:
                    System.out.println("Lựa chọn không hợp lệ, vui lòng nhập lại!");
            }
        }
    }
}
