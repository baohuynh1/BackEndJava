import java.util.Scanner;

public class ThaoTacChuoi {

    static Scanner scanner = new Scanner(System.in);
    static String chuoi = "";  // Chuỗi hiện tại người dùng đã nhập

    // ══════════════════════════════════════════
    // 1. Nhập chuỗi
    // ══════════════════════════════════════════
    static void nhapChuoi() {
        System.out.print("Nhập chuỗi: ");
        chuoi = scanner.nextLine();
        System.out.println("Đã lưu chuỗi: \"" + chuoi + "\"");
    }

    // ══════════════════════════════════════════
    // 2. Đếm số ký tự thường, hoa, số, đặc biệt
    // ══════════════════════════════════════════
    static void demKyTu() {
        if (chuoi.isEmpty()) { thongBaoChưaNhap(); return; }

        int soHoa = 0, soThuong = 0, soSo = 0, soDacBiet = 0;

        for (char c : chuoi.toCharArray()) {
            if      (Character.isUpperCase(c)) soHoa++;
            else if (Character.isLowerCase(c)) soThuong++;
            else if (Character.isDigit(c))     soSo++;
            else                               soDacBiet++;
        }

        System.out.println("Chuỗi       : \"" + chuoi + "\"");
        System.out.println("Chữ hoa     : " + soHoa);
        System.out.println("Chữ thường  : " + soThuong);
        System.out.println("Chữ số      : " + soSo);
        System.out.println("Ký tự đặc biệt: " + soDacBiet);
    }

    // ══════════════════════════════════════════
    // 3. Đảo ngược chuỗi
    // ══════════════════════════════════════════
    static void daoNguocChuoi() {
        if (chuoi.isEmpty()) { thongBaoChưaNhap(); return; }

        String daoNguoc = new StringBuilder(chuoi).reverse().toString();
        System.out.println("Chuỗi gốc   : \"" + chuoi + "\"");
        System.out.println("Đảo ngược   : \"" + daoNguoc + "\"");
    }

    // ══════════════════════════════════════════
    // 4. Kiểm tra Palindrome
    // ══════════════════════════════════════════
    static void kiemTraPalindrome() {
        if (chuoi.isEmpty()) { thongBaoChưaNhap(); return; }

        // Chuẩn hóa: bỏ khoảng trắng, chuyển thường để so sánh
        String chuan = chuoi.replaceAll("\\s+", "").toLowerCase();
        String daoNguoc = new StringBuilder(chuan).reverse().toString();

        System.out.println("Chuỗi       : \"" + chuoi + "\"");
        if (chuan.equals(daoNguoc)) {
            System.out.println("Kết quả     : Là Palindrome ✔");
        } else {
            System.out.println("Kết quả     : Không phải Palindrome ✘");
        }
    }

    // ══════════════════════════════════════════
    // 5. Chuẩn hóa chuỗi
    // ══════════════════════════════════════════
    static void chuanHoaChuoi() {
        if (chuoi.isEmpty()) { thongBaoChưaNhap(); return; }

        // Xóa khoảng trắng đầu/cuối và thu gọn khoảng trắng ở giữa
        String chuan = chuoi.trim().replaceAll("\\s+", " ");

        // Viết hoa chữ cái đầu tiên, giữ nguyên các ký tự còn lại
        if (!chuan.isEmpty()) {
            chuan = Character.toUpperCase(chuan.charAt(0)) + chuan.substring(1);
        }

        System.out.println("Chuỗi gốc   : \"" + chuoi + "\"");
        System.out.println("Sau chuẩn hóa: \"" + chuan + "\"");

        // Cập nhật lại chuỗi hiện tại
        chuoi = chuan;
    }

    // ══════════════════════════════════════════
    // Tiện ích
    // ══════════════════════════════════════════
    static void thongBaoChưaNhap() {
        System.out.println("⚠ Bạn chưa nhập chuỗi! Vui lòng chọn chức năng 1 trước.");
    }

    static void inMenu() {
        System.out.println("\n**************************** MENU ****************************");
        System.out.println("1. Nhập chuỗi");
        System.out.println("2. Đếm số ký tự thường, hoa, số, đặc biệt");
        System.out.println("3. Đảo ngược chuỗi");
        System.out.println("4. Kiểm tra Palindrome");
        System.out.println("5. Chuẩn hóa chuỗi (xóa khoảng trắng dư thừa, viết hoa chữ cái đầu)");
        System.out.println("6. Thoát");
        System.out.println("**************************************************************");
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
                case 1 -> nhapChuoi();
                case 2 -> demKyTu();
                case 3 -> daoNguocChuoi();
                case 4 -> kiemTraPalindrome();
                case 5 -> chuanHoaChuoi();
                case 6 -> System.out.println("Tạm biệt!");
                default -> System.out.println("Lựa chọn không hợp lệ. Vui lòng chọn từ 1 đến 6.");
            }

        } while (luaChon != 6);

        scanner.close();
    }
}