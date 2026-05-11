import java.util.Random;
import java.util.Scanner;

public class TaoChuoiNgauNhien {

    // Bảng ký tự hợp lệ: A-Z, a-z, 0-9
    static final char[] BANG_KY_TU =
            "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789".toCharArray();

    static String taoChuoi(int n) {
        Random random = new Random();
        StringBuilder sb = new StringBuilder(n);

        for (int i = 0; i < n; i++) {
            // Chọn ngẫu nhiên một chỉ số trong bảng ký tự (0 – 61)
            int viTri = random.nextInt(BANG_KY_TU.length);
            sb.append(BANG_KY_TU[viTri]);
        }

        return sb.toString();
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        System.out.print("Nhập độ dài chuỗi n (1 – 1000): ");
        int n = scanner.nextInt();

        // Kiểm tra đầu vào hợp lệ
        if (n < 1 || n > 1000) {
            System.out.println("Lỗi: n phải nằm trong khoảng từ 1 đến 1000.");
        } else {
            String chuoi = taoChuoi(n);
            System.out.println("Chuỗi ngẫu nhiên: " + chuoi);
            System.out.println("Độ dài thực tế  : " + chuoi.length());
        }

        scanner.close();
    }
}
//test case 1: 8 - 1E7qhYG0
//test case 1: 9 - suk3ez70F
//test case 1: 100 - nCvvxIRT82XdAoxJZniBqMt1enGEWcxVM01jPGDII690eIqjTAUZF099cEx3ldTfXRmY9OT55qBR2esqAaSCwmDFCcm0yRNQAUqk