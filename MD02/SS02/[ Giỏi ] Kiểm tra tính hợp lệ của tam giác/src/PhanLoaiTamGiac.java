import java.util.Scanner;

public class PhanLoaiTamGiac {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Nhập ba cạnh của tam giác
        System.out.print("Nhập cạnh a: ");
        int a = scanner.nextInt();
        System.out.print("Nhập cạnh b: ");
        int b = scanner.nextInt();
        System.out.print("Nhập cạnh c: ");
        int c = scanner.nextInt();

        // Kiểm tra tam giác hợp lệ
        if (a + b > c && a + c > b && b + c > a) {
            // Nếu hợp lệ, phân loại tam giác
            if (a == b && b == c) {
                System.out.println("Đây là tam giác đều.");
            } else if (a == b || b == c || a == c) {
                System.out.println("Đây là tam giác cân.");
            } else if (a * a + b * b == c * c ||
                    a * a + c * c == b * b ||
                    b * b + c * c == a * a) {
                System.out.println("Đây là tam giác vuông.");
            } else {
                System.out.println("Đây là tam giác thường.");
            }
        } else {
            // Không hợp lệ
            System.out.println("Ba cạnh không tạo thành tam giác.");
        }

        scanner.close();
    }
}
