import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Nhập tử số và mẫu số của phân số thứ nhất
        System.out.print("Nhập tử số của phân số thứ nhất (a): ");
        int a = scanner.nextInt();
        System.out.print("Nhập mẫu số của phân số thứ nhất (b): ");
        int b = scanner.nextInt();

        // Nhập tử số và mẫu số của phân số thứ hai
        System.out.print("Nhập tử số của phân số thứ hai (c): ");
        int c = scanner.nextInt();
        System.out.print("Nhập mẫu số của phân số thứ hai (d): ");
        int d = scanner.nextInt();

        // Tính tổng theo công thức (a/b + c/d) = (ad + bc) / (bd)
        int numerator = a * d + b * c; // tử số
        int denominator = b * d;       // mẫu số

        // In kết quả ra màn hình dưới dạng phân số
        System.out.println("\n--- Kết quả ---");
        System.out.println("Tổng của hai phân số = " + numerator + "/" + denominator);
    }
}

//Nhập tử số của phân số thứ nhất (a): 4
//Nhập mẫu số của phân số thứ nhất (b): 6
//Nhập tử số của phân số thứ hai (c): 9
//Nhập mẫu số của phân số thứ hai (d): 5
//
//--- Kết quả ---
//Tổng của hai phân số = 74/30