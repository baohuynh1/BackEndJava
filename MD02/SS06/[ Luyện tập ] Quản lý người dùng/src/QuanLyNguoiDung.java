import java.util.Scanner;
import java.util.regex.Pattern;

public class QuanLyNguoiDung {

    static Scanner scanner = new Scanner(System.in);

    // Thông tin người dùng
    static String hoTen    = "";
    static String email    = "";
    static String dienThoai = "";
    static String matKhau  = "";

    // ══════════════════════════════════════════
    // 1. Nhập thông tin người dùng
    // ══════════════════════════════════════════
    static void nhapThongTin() {
        System.out.print("Nhập họ và tên   : "); hoTen     = scanner.nextLine();
        System.out.print("Nhập email       : "); email     = scanner.nextLine();
        System.out.print("Nhập số điện thoại: "); dienThoai = scanner.nextLine();
        System.out.print("Nhập mật khẩu    : "); matKhau   = scanner.nextLine();
        System.out.println("Đã lưu thông tin người dùng.");
    }

    // ══════════════════════════════════════════
    // 2. Chuẩn hóa họ tên
    //    - Xóa khoảng trắng thừa
    //    - Viết hoa chữ cái đầu mỗi từ
    // ══════════════════════════════════════════
    static void chuanHoaHoTen() {
        if (chuaNhap()) return;

        // Xóa khoảng trắng đầu/cuối, thu gọn khoảng trắng giữa
        String[] words = hoTen.trim().replaceAll("\\s+", " ").split(" ");
        StringBuilder sb = new StringBuilder();

        for (String w : words) {
            if (!w.isEmpty()) {
                sb.append(Character.toUpperCase(w.charAt(0)))
                        .append(w.substring(1).toLowerCase())
                        .append(" ");
            }
        }

        String chuanHoa = sb.toString().trim();
        System.out.println("Họ tên gốc      : \"" + hoTen + "\"");
        System.out.println("Sau chuẩn hóa   : \"" + chuanHoa + "\"");
        hoTen = chuanHoa; // cập nhật lại
    }

    // ══════════════════════════════════════════
    // 3. Kiểm tra email hợp lệ
    //    username: chữ cái, số, dấu chấm, gạch dưới
    //    domain  : chữ cái, số, dấu chấm
    //    TLD     : 2–6 chữ cái
    // ══════════════════════════════════════════
    static void kiemTraEmail() {
        if (chuaNhap()) return;

        String pattern = "^[\\w.]+@[a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)*\\.[a-zA-Z]{2,6}$";
        boolean hopLe = Pattern.matches(pattern, email.trim());

        System.out.println("Email           : \"" + email + "\"");
        System.out.println("Kết quả         : " + (hopLe ? "Email hợp lệ ✔" : "Email không hợp lệ ✘"));
    }

    // ══════════════════════════════════════════
    // 4. Kiểm tra số điện thoại hợp lệ (VN)
    //    - Bắt đầu bằng 0
    //    - Đầu số: 03x, 05x, 07x, 08x, 09x
    //    - Tổng 10 chữ số
    // ══════════════════════════════════════════
    static void kiemTraDienThoai() {
        if (chuaNhap()) return;

        String pattern = "^(0)(3[2-9]|5[6-9]|7[06-9]|8[0-9]|9[0-9])[0-9]{7}$";
        boolean hopLe = Pattern.matches(pattern, dienThoai.trim());

        System.out.println("Số điện thoại   : \"" + dienThoai + "\"");
        System.out.println("Kết quả         : " + (hopLe ? "Số điện thoại hợp lệ ✔" : "Số điện thoại không hợp lệ ✘"));
    }

    // ══════════════════════════════════════════
    // 5. Kiểm tra mật khẩu hợp lệ
    //    - Tối thiểu 8 ký tự
    //    - Có chữ thường, chữ hoa, số, ký tự đặc biệt
    // ══════════════════════════════════════════
    static void kiemTraMatKhau() {
        if (chuaNhap()) return;

        boolean duDo      = matKhau.length() >= 8;
        boolean coHoa     = Pattern.compile("[A-Z]").matcher(matKhau).find();
        boolean coThuong  = Pattern.compile("[a-z]").matcher(matKhau).find();
        boolean coSo      = Pattern.compile("[0-9]").matcher(matKhau).find();
        boolean coDacBiet = Pattern.compile("[^a-zA-Z0-9]").matcher(matKhau).find();

        boolean hopLe = duDo && coHoa && coThuong && coSo && coDacBiet;

        System.out.println("Mật khẩu        : \"" + matKhau + "\"");
        System.out.println("  ≥ 8 ký tự     : " + (duDo      ? "✔" : "✘"));
        System.out.println("  Chữ hoa        : " + (coHoa     ? "✔" : "✘"));
        System.out.println("  Chữ thường     : " + (coThuong  ? "✔" : "✘"));
        System.out.println("  Chữ số         : " + (coSo      ? "✔" : "✘"));
        System.out.println("  Ký tự đặc biệt : " + (coDacBiet ? "✔" : "✘"));
        System.out.println("Kết quả         : " + (hopLe ? "Mật khẩu hợp lệ ✔" : "Mật khẩu không hợp lệ ✘"));
    }

    // ══════════════════════════════════════════
    // Tiện ích
    // ══════════════════════════════════════════
    static boolean chuaNhap() {
        if (hoTen.isEmpty() && email.isEmpty()) {
            System.out.println("⚠ Chưa có dữ liệu! Vui lòng chọn chức năng 1 để nhập thông tin.");
            return true;
        }
        return false;
    }

    static void inMenu() {
        System.out.println("\n****************** QUẢN LÝ NGƯỜI DÙNG *****************");
        System.out.println("1. Nhập thông tin người dùng");
        System.out.println("2. Chuẩn hóa họ tên");
        System.out.println("3. Kiểm tra email hợp lệ");
        System.out.println("4. Kiểm tra số điện thoại hợp lệ");
        System.out.println("5. Kiểm tra mật khẩu hợp lệ");
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
                case 1 -> nhapThongTin();
                case 2 -> chuanHoaHoTen();
                case 3 -> kiemTraEmail();
                case 4 -> kiemTraDienThoai();
                case 5 -> kiemTraMatKhau();
                case 6 -> System.out.println("Tạm biệt!");
                default -> System.out.println("Lựa chọn không hợp lệ. Vui lòng chọn từ 1 đến 6.");
            }

        } while (luaChon != 6);

        scanner.close();
    }
}