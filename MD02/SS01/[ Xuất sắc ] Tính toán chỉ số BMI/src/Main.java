import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Nhập cân nặng và chiều cao
        System.out.print("Nhập cân nặng (kg): ");
        float weight = scanner.nextFloat();

        System.out.print("Nhập chiều cao (m): ");
        float height = scanner.nextFloat();

        // Tính chỉ số BMI
        float bmi = weight / (height * height);

        // In kết quả
        System.out.println("\n--- Kết quả ---");
        System.out.println("Cân nặng: " + weight + " kg");
        System.out.println("Chiều cao: " + height + " m");
        System.out.println("Chỉ số BMI = " + bmi);
    }
}
//Nhập cân nặng (kg): 60
//Nhập chiều cao (m): 1.7
//
//--- Kết quả ---
//Cân nặng: 60.0 kg
//Chiều cao: 1.7 m
//Chỉ số BMI = 20.761246