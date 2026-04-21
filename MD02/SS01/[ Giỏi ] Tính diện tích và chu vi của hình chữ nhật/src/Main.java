import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Nhập
        System.out.print("Nhập chiều rộng (width): ");
        float width = scanner.nextFloat();

        System.out.print("Nhập chiều cao (height): ");
        float height = scanner.nextFloat();

        // Tính diện tích và chu vi
        float area = width * height;
        float perimeter = 2 * (width + height);

        // In
        System.out.println("\n--- Kết quả ---");
        System.out.println("Chiều rộng = " + width);
        System.out.println("Chiều cao = " + height);
        System.out.println("Diện tích hình chữ nhật = " + area);
        System.out.println("Chu vi hình chữ nhật = " + perimeter);
    }
}

//Nhập chiều rộng (width): 7
//Nhập chiều cao (height): 8
//
//--- Kết quả ---
//Chiều rộng = 7.0
//Chiều cao = 8.0
//Diện tích hình chữ nhật = 56.0
//Chu vi hình chữ nhật = 30.0