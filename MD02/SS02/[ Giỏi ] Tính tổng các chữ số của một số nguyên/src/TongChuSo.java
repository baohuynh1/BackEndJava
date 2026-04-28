import java.util.Scanner;

public class TongChuSo {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Nhập số nguyên từ bàn phím
        System.out.print("Nhập một số nguyên bất kỳ: ");
        int N = scanner.nextInt();

        // Nếu số âm thì chuyển thành số dương
        if (N < 0) {
            N = -N;
        }

        int tong = 0;

        // Sử dụng vòng lặp để tách từng chữ số
        while (N > 0) {
            int chuSo = N % 10;   // lấy chữ số cuối
            tong += chuSo;        // cộng vào tổng
            N = N / 10;           // bỏ chữ số cuối
        }

        // In kết quả
        System.out.println("Tổng các chữ số là: " + tong);

        scanner.close();
    }
}
