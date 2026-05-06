import java.util.Scanner;
import java.util.ArrayList;

public class SapXepDacBiet {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // 1. Nhập kích thước mảng và kiểm tra tính hợp lệ
        System.out.print("Nhập số phần tử của mảng: ");
        if (!sc.hasNextInt()) {
            System.out.println("Dữ liệu không hợp lệ.");
            return;
        }

        int n = sc.nextInt();

        if (n <= 0) {
            System.out.println("Mảng không có phần tử");
            sc.close();
            return;
        }

        // 2. Khởi tạo và nhập giá trị cho mảng
        int[] arr = new int[n];
        for (int i = 0; i < n; i++) {
            System.out.print("Nhập phần tử thứ " + (i + 1) + ": ");
            arr[i] = sc.nextInt();
        }

        // 3. Xử lý logic: Tách nhóm chẵn và lẻ
        // Chúng ta sử dụng ArrayList để lưu trữ vì chưa biết số lượng chẵn/lẻ cụ thể
        ArrayList<Integer> chan = new ArrayList<>();
        ArrayList<Integer> le = new ArrayList<>();

        for (int x : arr) {
            if (x % 2 == 0) {
                chan.add(x); // Thêm vào nhóm chẵn
            } else {
                le.add(x); // Thêm vào nhóm lẻ
            }
        }

        // 4. Gộp kết quả lại mảng gốc
        int index = 0;
        for (int x : chan) {
            arr[index++] = x;
        }
        for (int x : le) {
            arr[index++] = x;
        }

        // 5. Đầu ra: Hiển thị mảng đã sắp xếp
        System.out.print("Mảng sau khi sắp xếp: ");
        for (int i = 0; i < n; i++) {
            System.out.print(arr[i] + (i == n - 1 ? "" : " "));
        }

        sc.close();
    }
}