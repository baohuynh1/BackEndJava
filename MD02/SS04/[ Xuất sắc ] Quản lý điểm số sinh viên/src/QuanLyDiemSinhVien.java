import java.util.Scanner;
import java.util.Arrays;

public class QuanLyDiemSinhVien {
    static Scanner sc = new Scanner(System.in);
    static boolean isSorted = false; // Biến kiểm tra mảng đã sắp xếp chưa

    public static void main(String[] args) {
        System.out.print("Nhập số lượng sinh viên (n): ");
        int n = sc.nextInt();
        if (n <= 0) {
            System.out.println("Số lượng sinh viên không hợp lệ!");
            return;
        }

        double[] diem = new double[n];
        for (int i = 0; i < n; i++) {
            System.out.print("Nhập điểm sinh viên thứ " + (i + 1) + ": ");
            diem[i] = sc.nextDouble();
        }

        int choice;
        do {
            System.out.println("\n===== MENU QUẢN LÝ ĐIỂM =====");
            System.out.println("1. Xem tất cả điểm");
            System.out.println("2. Sắp xếp điểm (Tăng/Giảm)");
            System.out.println("3. Tìm kiếm điểm (Tuyến tính/Nhị phân)");
            System.out.println("4. Thống kê điểm");
            System.out.println("0. Thoát");
            System.out.print("Lựa chọn của bạn: ");
            choice = sc.nextInt();

            switch (choice) {
                case 1: hienThi(diem); break;
                case 2: sapXepMenu(diem); break;
                case 3: timKiemMenu(diem); break;
                case 4: thongKe(diem); break;
                case 0: System.out.println("Kết thúc chương trình!"); break;
                default: System.out.println("Lựa chọn không hợp lệ!");
            }
        } while (choice != 0);
    }

    // 1. Xem tất cả điểm
    public static void hienThi(double[] a) {
        System.out.print("Danh sách điểm: ");
        for (double d : a) System.out.print(d + "  ");
        System.out.println(isSorted ? "(Đã sắp xếp)" : "(Thứ tự gốc)");
    }

    // 2. Sắp xếp điểm
    public static void sapXepMenu(double[] a) {
        System.out.println("1. Sắp xếp Tăng dần (Bubble Sort)");
        System.out.println("2. Sắp xếp Giảm dần (Selection Sort)");
        int loai = sc.nextInt();

        if (loai == 1) {
            // Bubble Sort Tăng dần
            for (int i = 0; i < a.length - 1; i++) {
                for (int j = 0; j < a.length - i - 1; j++) {
                    if (a[j] > a[j + 1]) {
                        double temp = a[j]; a[j] = a[j + 1]; a[j + 1] = temp;
                    }
                }
            }
            isSorted = true;
        } else {
            // Selection Sort Giảm dần
            for (int i = 0; i < a.length - 1; i++) {
                int maxIdx = i;
                for (int j = i + 1; j < a.length; j++) {
                    if (a[j] > a[maxIdx]) maxIdx = j;
                }
                double temp = a[maxIdx]; a[maxIdx] = a[i]; a[i] = temp;
            }
            isSorted = false; // Khi sắp xếp giảm, binary search chuẩn sẽ không chạy được
        }
        System.out.println("Sắp xếp thành công!");
        hienThi(a);
    }

    // 3. Tìm kiếm điểm
    public static void timKiemMenu(double[] a) {
        System.out.print("Nhập giá trị điểm cần tìm: ");
        double x = sc.nextDouble();

        // Tìm kiếm tuyến tính
        int linearIdx = -1;
        for (int i = 0; i < a.length; i++) {
            if (a[i] == x) { linearIdx = i; break; }
        }
        System.out.println("- Linear Search: " + (linearIdx != -1 ? "Thấy tại vị trí " + linearIdx : "Không thấy"));

        // Tìm kiếm nhị phân (Chỉ chạy nếu mảng đã sắp xếp tăng dần)
        if (isSorted) {
            int left = 0, right = a.length - 1, binaryIdx = -1;
            while (left <= right) {
                int mid = left + (right - left) / 2;
                if (a[mid] == x) { binaryIdx = mid; break; }
                if (a[mid] < x) left = mid + 1;
                else right = mid - 1;
            }
            System.out.println("- Binary Search: " + (binaryIdx != -1 ? "Thấy tại vị trí " + binaryIdx : "Không thấy"));
        } else {
            System.out.println("- Binary Search: Không thể thực hiện (Cần sắp xếp TĂNG DẦN trước)");
        }
    }

    // 4. Thống kê điểm
    public static void thongKe(double[] a) {
        double tong = 0, max = a[0], min = a[0];
        for (double d : a) {
            tong += d;
            if (d > max) max = d;
            if (d < min) min = d;
        }
        double trungBinh = tong / a.length;

        int trenTB = 0;
        for (double d : a) if (d >= trungBinh) trenTB++;

        System.out.println("--- Thống kê ---");
        System.out.printf("Điểm trung bình: %.2f\n", trungBinh);
        System.out.println("Điểm cao nhất: " + max);
        System.out.println("Điểm thấp nhất: " + min);
        System.out.println("Số SV đạt từ trung bình trở lên: " + trenTB);
    }
}