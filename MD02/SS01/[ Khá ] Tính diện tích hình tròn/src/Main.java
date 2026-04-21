import java.util.Scanner; // để nhập dữ liệu từ bàn phím

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Yêu cầu người dùng nhập bán kính
        System.out.print("Nhập bán kính hình tròn: ");
        double radius = scanner.nextDouble(); // lưu bán kính vào biến radius

        // Tính diện tích theo công thức A = π * r * r
        double area = Math.PI * radius * radius;

        // Hiển thị kết quả
        System.out.println("Diện tích hình tròn là: " + area);
    }
}