import java.util.Arrays;
import java.util.Scanner;

public class QuanLyDIemSV {

    static Scanner scanner = new Scanner(System.in);
    static double[] danhSachDiem = new double[0];

    // ══════════════════════════════════════════
    // 1. Nhập danh sách điểm sinh viên
    // ══════════════════════════════════════════
    static void nhapDanhSach() {
        System.out.print("Nhập số lượng sinh viên: ");
        int n = Integer.parseInt(scanner.nextLine().trim());

        danhSachDiem = new double[n];
        for (int i = 0; i < n; i++) {
            System.out.print("Nhập điểm sinh viên " + (i + 1) + ": ");
            danhSachDiem[i] = Double.parseDouble(scanner.nextLine().trim());
        }
        System.out.println("Đã nhập xong danh sách điểm.");
    }

    // ══════════════════════════════════════════
    // 2. In danh sách điểm
    // ══════════════════════════════════════════
    static void inDanhSach() {
        if (chuaNhap()) return;

        System.out.println("Danh sách điểm sinh viên:");
        for (int i = 0; i < danhSachDiem.length; i++) {
            System.out.printf("  SV %2d: %.1f%n", i + 1, danhSachDiem[i]);
        }
    }

    // ══════════════════════════════════════════
    // 3. Tính điểm trung bình
    // ══════════════════════════════════════════
    static void tinhTrungBinh() {
        if (chuaNhap()) return;

        double tong = 0;
        for (double d : danhSachDiem) tong += d;
        double trungBinh = tong / danhSachDiem.length;

        System.out.printf("Điểm trung bình: %.2f%n", trungBinh);
    }

    // ══════════════════════════════════════════
    // 4. Tìm điểm cao nhất và thấp nhất
    // ══════════════════════════════════════════
    static void timCaoNhatThapNhat() {
        if (chuaNhap()) return;

        double caoNhat = danhSachDiem[0];
        double thapNhat = danhSachDiem[0];

        for (double d : danhSachDiem) {
            if (d > caoNhat)  caoNhat  = d;
            if (d < thapNhat) thapNhat = d;
        }

        System.out.printf("Điểm cao nhất : %.1f%n", caoNhat);
        System.out.printf("Điểm thấp nhất: %.1f%n", thapNhat);
    }

    // ══════════════════════════════════════════
    // 5. Đếm số lượng sinh viên đạt và trượt
    // ══════════════════════════════════════════
    static void demDatTruot() {
        if (chuaNhap()) return;

        int dat = 0, truot = 0;
        for (double d : danhSachDiem) {
            if (d >= 5) dat++;
            else        truot++;
        }

        System.out.println("Số sinh viên đạt  (≥ 5): " + dat);
        System.out.println("Số sinh viên trượt (< 5): " + truot);
    }

    // ══════════════════════════════════════════
    // 6. Sắp xếp điểm tăng dần
    // ══════════════════════════════════════════
    static void sapXepTangDan() {
        if (chuaNhap()) return;

        double[] ban = Arrays.copyOf(danhSachDiem, danhSachDiem.length);
        Arrays.sort(ban);

        System.out.print("Điểm tăng dần: ");
        for (int i = 0; i < ban.length; i++) {
            System.out.printf("%.1f%s", ban[i], i < ban.length - 1 ? ", " : "\n");
        }
    }

    // ══════════════════════════════════════════
    // 7. Thống kê sinh viên giỏi và xuất sắc
    // ══════════════════════════════════════════
    static void thongKeGioiXuatSac() {
        if (chuaNhap()) return;

        int count = 0;
        System.out.println("Sinh viên giỏi và xuất sắc (≥ 8):");
        for (int i = 0; i < danhSachDiem.length; i++) {
            if (danhSachDiem[i] >= 8) {
                System.out.printf("  SV %2d: %.1f%n", i + 1, danhSachDiem[i]);
                count++;
            }
        }
        System.out.println("Tổng số: " + count + " sinh viên");
    }

    // ══════════════════════════════════════════
    // Tiện ích
    // ══════════════════════════════════════════
    static boolean chuaNhap() {
        if (danhSachDiem.length == 0) {
            System.out.println("⚠ Chưa có dữ liệu! Vui lòng chọn chức năng 1 để nhập điểm.");
            return true;
        }
        return false;
    }

    static void inMenu() {
        System.out.println("\n******************QUẢN LÝ ĐIỂM SV*****************");
        System.out.println("1. Nhập danh sách điểm sinh viên");
        System.out.println("2. In danh sách điểm");
        System.out.println("3. Tính điểm trung bình của các sinh viên");
        System.out.println("4. Tìm điểm cao nhất và thấp nhất");
        System.out.println("5. Đếm số lượng sinh viên đạt và trượt");
        System.out.println("6. Sắp xếp điểm tăng dần");
        System.out.println("7. Thống kê số lượng sinh viên giỏi và xuất sắc");
        System.out.println("8. Thoát");
        System.out.println("****************************************************");
        System.out.print("Lựa chọn của bạn: ");
    }

    // ══════════════════════════════════════════
    // Main
    // ══════════════════════════════════════════
    public static void main(String[] args) {
        int luaChon;

        do {
            inMenu();
            luaChon = Integer.parseInt(scanner.nextLine().trim());
            System.out.println();

            switch (luaChon) {
                case 1 -> nhapDanhSach();
                case 2 -> inDanhSach();
                case 3 -> tinhTrungBinh();
                case 4 -> timCaoNhatThapNhat();
                case 5 -> demDatTruot();
                case 6 -> sapXepTangDan();
                case 7 -> thongKeGioiXuatSac();
                case 8 -> System.out.println("Tạm biệt!");
                default -> System.out.println("Lựa chọn không hợp lệ. Vui lòng chọn từ 1 đến 8.");
            }

        } while (luaChon != 8);

        scanner.close();
    }
}