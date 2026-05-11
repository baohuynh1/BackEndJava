import java.util.*;
import java.util.regex.Pattern;

public class QuanLyBienSoXe {

    static Scanner scanner = new Scanner(System.in);
    static List<String> danhSach = new ArrayList<>();

    // Bảng mã tỉnh/thành phố
    static final Map<String, String> MA_TINH = new HashMap<>();
    static {
        MA_TINH.put("11", "Cao Bằng");      MA_TINH.put("12", "Lạng Sơn");
        MA_TINH.put("14", "Quảng Ninh");    MA_TINH.put("15", "Hải Phòng");
        MA_TINH.put("25", "Thừa Thiên Huế");MA_TINH.put("26", "Đà Nẵng");
        MA_TINH.put("27", "Quảng Nam");     MA_TINH.put("28", "Quảng Ngãi");
        MA_TINH.put("29", "Hà Nội");        MA_TINH.put("30", "Hà Nội");
        MA_TINH.put("36", "Bắc Ninh");      MA_TINH.put("37", "Hưng Yên");
        MA_TINH.put("38", "Hà Nam");        MA_TINH.put("40", "Hà Giang");
        MA_TINH.put("43", "Đắk Lắk");       MA_TINH.put("47", "Đắk Nông");
        MA_TINH.put("48", "Lâm Đồng");      MA_TINH.put("49", "Bình Phước");
        MA_TINH.put("58", "TP. Hồ Chí Minh");MA_TINH.put("59", "TP. Hồ Chí Minh");

    }

    // Định dạng biển số: 30F-123.45
    static final String PATTERN_BIEN_SO = "^\\d{2}[A-Z]{1,2}-\\d{3}\\.\\d{2}$";

    // ══════════════════════════════════════════
    // 1. Thêm biển số xe
    // ══════════════════════════════════════════
    static void themBienSo() {
        System.out.print("Nhập số lượng biển số cần thêm: ");
        int n = Integer.parseInt(scanner.nextLine().trim());

        for (int i = 0; i < n; i++) {
            System.out.print("Nhập biển số " + (i + 1) + " (VD: 30F-123.45): ");
            String bs = scanner.nextLine().trim().toUpperCase();

            if (!Pattern.matches(PATTERN_BIEN_SO, bs)) {
                System.out.println("  ⚠ Định dạng không hợp lệ, bỏ qua: " + bs);
            } else if (danhSach.contains(bs)) {
                System.out.println("  ⚠ Biển số đã tồn tại, bỏ qua: " + bs);
            } else {
                danhSach.add(bs);
                System.out.println("  ✔ Đã thêm: " + bs);
            }
        }
    }

    // ══════════════════════════════════════════
    // 2. Hiển thị danh sách biển số xe
    // ══════════════════════════════════════════
    static void hienThiDanhSach() {
        if (chuaNhap()) return;

        System.out.println("Danh sách biển số xe (" + danhSach.size() + " biển):");
        for (int i = 0; i < danhSach.size(); i++) {
            String bs = danhSach.get(i);
            String maTinh = bs.substring(0, 2);
            String tenTinh = MA_TINH.getOrDefault(maTinh, "Không rõ");
            System.out.printf("  %2d. %-12s [%s]%n", i + 1, bs, tenTinh);
        }
    }

    // ══════════════════════════════════════════
    // 3. Tìm kiếm chính xác theo biển số xe
    // ══════════════════════════════════════════
    static void timKiemBienSo() {
        if (chuaNhap()) return;

        System.out.print("Nhập biển số cần tìm: ");
        String timKiem = scanner.nextLine().trim().toUpperCase();

        if (danhSach.contains(timKiem)) {
            String maTinh = timKiem.substring(0, 2);
            String tenTinh = MA_TINH.getOrDefault(maTinh, "Không rõ");
            System.out.println("✔ Tìm thấy: " + timKiem + " [" + tenTinh + "]");
        } else {
            System.out.println("✘ Không tìm thấy biển số: " + timKiem);
        }
    }

    // ══════════════════════════════════════════
    // 4. Tìm biển số xe theo mã tỉnh
    // ══════════════════════════════════════════
    static void timTheoMaTinh() {
        if (chuaNhap()) return;

        System.out.print("Nhập mã tỉnh cần tìm (VD: 29, 51): ");
        String maTinh = scanner.nextLine().trim();

        String tenTinh = MA_TINH.getOrDefault(maTinh, null);
        if (tenTinh == null) {
            System.out.println("⚠ Mã tỉnh không hợp lệ hoặc không có trong danh mục.");
            return;
        }

        List<String> ketQua = new ArrayList<>();
        for (String bs : danhSach) {
            if (bs.startsWith(maTinh)) ketQua.add(bs);
        }

        System.out.println("Tỉnh/Thành: " + tenTinh + " (mã " + maTinh + ")");
        if (ketQua.isEmpty()) {
            System.out.println("Không có biển số nào thuộc tỉnh này.");
        } else {
            System.out.println("Tìm thấy " + ketQua.size() + " biển số:");
            ketQua.forEach(bs -> System.out.println("  - " + bs));
        }
    }

    // ══════════════════════════════════════════
    // 5. Sắp xếp biển số xe tăng dần
    // ══════════════════════════════════════════
    static void sapXepTangDan() {
        if (chuaNhap()) return;

        List<String> ban = new ArrayList<>(danhSach);
        Collections.sort(ban);

        System.out.println("Danh sách biển số xe (sắp xếp tăng dần):");
        for (int i = 0; i < ban.size(); i++) {
            System.out.printf("  %2d. %s%n", i + 1, ban.get(i));
        }
    }

    // ══════════════════════════════════════════
    // Tiện ích
    // ══════════════════════════════════════════
    static boolean chuaNhap() {
        if (danhSach.isEmpty()) {
            System.out.println("⚠ Danh sách trống! Vui lòng chọn chức năng 1 để thêm biển số.");
            return true;
        }
        return false;
    }

    static void inMenu() {
        System.out.println("\n****************** QUẢN LÝ BIỂN SỐ XE ****************");
        System.out.println("1. Thêm các biển số xe");
        System.out.println("2. Hiển thị danh sách biển số xe");
        System.out.println("3. Tìm kiếm biển số xe");
        System.out.println("4. Tìm biển số xe theo mã tỉnh");
        System.out.println("5. Sắp xếp biển số xe tăng dần");
        System.out.println("6. Thoát");
        System.out.println("********************************************************");
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
                case 1 -> themBienSo();
                case 2 -> hienThiDanhSach();
                case 3 -> timKiemBienSo();
                case 4 -> timTheoMaTinh();
                case 5 -> sapXepTangDan();
                case 6 -> System.out.println("Tạm biệt!");
                default -> System.out.println("Lựa chọn không hợp lệ. Vui lòng chọn từ 1 đến 6.");
            }

        } while (luaChon != 6);

        scanner.close();
    }
}