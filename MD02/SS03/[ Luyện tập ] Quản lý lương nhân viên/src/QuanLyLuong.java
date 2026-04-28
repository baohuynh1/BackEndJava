import java.util.ArrayList;
import java.util.Scanner;

public class QuanLyLuong {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        ArrayList<Double> danhSachLuong = new ArrayList<>();

        while (true) {
            // Hiển thị menu
            System.out.println("\n===== MENU =====");
            System.out.println("1. Nhập lương nhân viên");
            System.out.println("2. Hiển thị thống kê");
            System.out.println("3. Tính tổng số tiền thưởng");
            System.out.println("4. Thoát chương trình");
            System.out.print("Chọn chức năng (1-4): ");
            int choice = scanner.nextInt();

            switch (choice) {
                case 1:
                    // Nhập lương nhân viên
                    while (true) {
                        System.out.print("Nhập lương nhân viên (0-500 triệu, nhập -1 để kết thúc): ");
                        double luong = scanner.nextDouble();

                        if (luong == -1) {
                            break;
                        }

                        if (luong < 0 || luong > 500_000_000) {
                            System.out.println("Lương không hợp lệ, vui lòng nhập lại!");
                            continue;
                        }

                        danhSachLuong.add(luong);

                        // Phân loại thu nhập
                        if (luong < 5_000_000) {
                            System.out.println("Thu nhập thấp");
                        } else if (luong < 15_000_000) {
                            System.out.println("Thu nhập trung bình");
                        } else if (luong < 50_000_000) {
                            System.out.println("Thu nhập khá");
                        } else {
                            System.out.println("Thu nhập cao");
                        }
                    }

                    // Thống kê nhanh
                    if (!danhSachLuong.isEmpty()) {
                        double tong = 0;
                        double max = danhSachLuong.get(0);
                        double min = danhSachLuong.get(0);

                        for (double l : danhSachLuong) {
                            tong += l;
                            if (l > max) max = l;
                            if (l < min) min = l;
                        }

                        System.out.println("\n--- Thống kê sau khi nhập ---");
                        System.out.println("Tổng số nhân viên: " + danhSachLuong.size());
                        System.out.println("Tổng lương: " + tong);
                        System.out.println("Lương cao nhất: " + max);
                        System.out.println("Lương thấp nhất: " + min);
                    }
                    break;

                case 2:
                    // Hiển thị thống kê
                    if (danhSachLuong.isEmpty()) {
                        System.out.println("Chưa có dữ liệu");
                    } else {
                        double tong = 0;
                        double max = danhSachLuong.get(0);
                        double min = danhSachLuong.get(0);

                        for (double l : danhSachLuong) {
                            tong += l;
                            if (l > max) max = l;
                            if (l < min) min = l;
                        }

                        double luongTB = tong / danhSachLuong.size();

                        System.out.println("\n--- Thống kê ---");
                        System.out.println("Số nhân viên: " + danhSachLuong.size());
                        System.out.println("Lương trung bình: " + luongTB);
                        System.out.println("Lương cao nhất: " + max);
                        System.out.println("Lương thấp nhất: " + min);
                        System.out.println("Tổng tiền lương: " + tong);
                    }
                    break;

                case 3:
                    // Tính tổng số tiền thưởng
                    if (danhSachLuong.isEmpty()) {
                        System.out.println("Chưa có dữ liệu");
                    } else {
                        double tongThuong = 0;
                        for (double l : danhSachLuong) {
                            double thuong = 0;
                            if (l < 5_000_000) {
                                thuong = l * 0.05;
                            } else if (l < 15_000_000) {
                                thuong = l * 0.10;
                            } else if (l < 50_000_000) {
                                thuong = l * 0.15;
                            } else if (l < 100_000_000) {
                                thuong = l * 0.20;
                            } else {
                                thuong = l * 0.25;
                            }
                            tongThuong += thuong;
                        }
                        System.out.println("Tổng số tiền thưởng cho nhân viên: " + tongThuong);
                    }
                    break;

                case 4:
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

