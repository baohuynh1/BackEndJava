import java.util.Scanner;

public class TinhTongChanLe {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // 1. Khởi tạo mảng: Nhập kích thước
        System.out.print("Nhập số hàng (rows): ");
        int rows = sc.nextInt();
        System.out.print("Nhập số cột (cols): ");
        int cols = sc.nextInt();

        int[][] matrix = new int[rows][cols];

        // 2. Nhập từng giá trị cho mảng theo từng hàng
        System.out.println("Nhập các phần tử của mảng:");
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                System.out.printf("Phần tử [%d][%d]: ", i, j);
                matrix[i][j] = sc.nextInt();
            }
        }

        // 3. Tính Tổng: Duyệt qua từng phần tử
        int tongChan = 0;
        int tongLe = 0;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (matrix[i][j] % 2 == 0) {
                    tongChan += matrix[i][j];
                } else {
                    tongLe += matrix[i][j];
                }
            }
        }

        // 4. Đầu ra: Hiển thị kết quả
        System.out.println("--------------------------");
        System.out.println("Tổng các số chẵn: " + tongChan);
        System.out.println("Tổng các số lẻ: " + tongLe);

        sc.close();
    }
}