import java.util.Scanner;
import java.util.regex.Pattern;

public class KiemTraMatKhau {

    static boolean kiemTraMatKhau(String matKhau) {

        if (matKhau.length() < 8) return false;


        if (!Pattern.compile("[A-Z]").matcher(matKhau).find()) return false;


        if (!Pattern.compile("[a-z]").matcher(matKhau).find()) return false;


        if (!Pattern.compile("[0-9]").matcher(matKhau).find()) return false;


        if (!Pattern.compile("[@#$!%]").matcher(matKhau).find()) return false;

        return true;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Nhập mật khẩu cần kiểm tra: ");
        String matKhau = scanner.nextLine();

        if (kiemTraMatKhau(matKhau)) {
            System.out.println("Mật khẩu hợp lệ");
        } else {
            System.out.println("Mật khẩu không hợp lệ");
        }

        scanner.close();
    }
}