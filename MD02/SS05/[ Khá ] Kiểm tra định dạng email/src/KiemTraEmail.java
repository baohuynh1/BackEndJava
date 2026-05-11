import java.util.Scanner;
import java.util.regex.Pattern;
import java.util.regex.Matcher;

public class KiemTraEmail {

    public static String kiemTraEmail(String email) {

        email = email.trim();


        String pattern = "^[\\w.]+@[a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)*\\.[a-zA-Z]{2,6}$";

        Pattern regex = Pattern.compile(pattern);
        Matcher matcher = regex.matcher(email);

        if (matcher.matches()) {
            return "Email hợp lệ";
        } else {
            return "Email không hợp lệ";
        }
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        
        System.out.print("Nhập địa chỉ email: ");
        String emailNhap = scanner.nextLine();

        String ketQua = kiemTraEmail(emailNhap);
        System.out.println(ketQua);

        scanner.close();
    }
}