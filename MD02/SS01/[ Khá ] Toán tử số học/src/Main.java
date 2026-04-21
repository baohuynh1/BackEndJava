import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Nhập giá trị
        System.out.print("Nhập số thứ nhất (firstNumber): ");
        int firstNumber = scanner.nextInt();

        System.out.print("Nhập số thứ hai (secondNumber): ");
        int secondNumber = scanner.nextInt();

        //  phép toán
        int sum = firstNumber + secondNumber;
        int difference = firstNumber - secondNumber;
        int product = firstNumber * secondNumber;
        int quotient = firstNumber / secondNumber;
        int remainder = firstNumber % secondNumber;

        // In
        System.out.println("\n--- Kết quả ---");
        System.out.println("firstNumber = " + firstNumber);
        System.out.println("secondNumber = " + secondNumber);
        System.out.println("Tổng = " + sum);
        System.out.println("Hiệu = " + difference);
        System.out.println("Tích = " + product);
        System.out.println("Thương = " + quotient);
        System.out.println("Phần dư = " + remainder);
    }
}
//Nhập số thứ nhất (firstNumber): 20
//Nhập số thứ hai (secondNumber): 10
//
//--- Kết quả ---
//firstNumber = 20
//secondNumber = 10
//Tổng = 30
//Hiệu = 10
//Tích = 200
//Thương = 2
//Phần dư = 0
