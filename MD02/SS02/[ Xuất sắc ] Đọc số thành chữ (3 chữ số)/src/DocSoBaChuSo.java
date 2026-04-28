import java.util.Scanner;

public class DocSoBaChuSo {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Nhập số từ bàn phím
        System.out.print("Nhập một số từ 100 đến 999: ");
        int number = scanner.nextInt();

        // Kiểm tra hợp lệ
        if (number < 100 || number > 999) {
            System.out.println("Số nhập vào không hợp lệ");
        } else {
            // Tách số thành hàng trăm, chục, đơn vị
            int hundreds = number / 100;
            int tens = (number / 10) % 10;
            int units = number % 10;

            // Đọc hàng trăm
            String result = "";
            switch (hundreds) {
                case 1: result += "Một trăm "; break;
                case 2: result += "Hai trăm "; break;
                case 3: result += "Ba trăm "; break;
                case 4: result += "Bốn trăm "; break;
                case 5: result += "Năm trăm "; break;
                case 6: result += "Sáu trăm "; break;
                case 7: result += "Bảy trăm "; break;
                case 8: result += "Tám trăm "; break;
                case 9: result += "Chín trăm "; break;
            }

            // Đọc hàng chục
            switch (tens) {
                case 0:
                    if (units != 0) result += "lẻ ";
                    break;
                case 1: result += "mười "; break;
                case 2: result += "hai mươi "; break;
                case 3: result += "ba mươi "; break;
                case 4: result += "bốn mươi "; break;
                case 5: result += "năm mươi "; break;
                case 6: result += "sáu mươi "; break;
                case 7: result += "bảy mươi "; break;
                case 8: result += "tám mươi "; break;
                case 9: result += "chín mươi "; break;
            }

            // Đọc hàng đơn vị
            switch (units) {
                case 1: result += "một"; break;
                case 2: result += "hai"; break;
                case 3: result += "ba"; break;
                case 4: result += "bốn"; break;
                case 5: result += "năm"; break;
                case 6: result += "sáu"; break;
                case 7: result += "bảy"; break;
                case 8: result += "tám"; break;
                case 9: result += "chín"; break;
            }

            // In kết quả
            System.out.println("Kết quả: " + result.trim());
        }

        scanner.close();
    }
}
