import java.util.Scanner;

public class TongTu1DenN {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.print("Nhập một số nguyên dương N: ");
        int N = scanner.nextInt();

        if (N <= 0) {
            System.out.println(" Số nhập vào không hợp lệ");
        } else {
            int tong = 0;
            for (int i = 1; i <= N; i++) {
                tong += i;
            }
            System.out.println("tổng các số từ 1 " + N + "là: " + tong);
        }
        scanner.close();
    }
}
