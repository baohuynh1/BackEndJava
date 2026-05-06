import java.util.Scanner;

public class SelectionSortAndSearch {
    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);

        // 1. Khởi tạo mảng
        System.out.print("Nhập kích thước của mảng: ");
        int n = sc.nextInt();
        int[] arr = new int[n];

        for (int i = 0; i < n; i++) {
            System.out.print("Nhập phần tử thứ " + (i + 1) + ": ");
            arr[i] = sc.nextInt();
        }

        // 2. Sắp xếp chọn (Selection Sort) - Thứ tự GIẢM DẦN
        for (int i = 0; i < n - 1; i++) {
            int maxIdx = i; // Giả định phần tử đầu tiên là lớn nhất
            for (int j = i + 1; j < n; j++) {
                if (arr[j] > arr[maxIdx]) {
                    maxIdx = j;
                }
            }
            // Hoán đổi phần tử lớn nhất tìm được với phần tử đầu đoạn
            int temp = arr[maxIdx];
            arr[maxIdx] = arr[i];
            arr[i] = temp;
        }

        // Hiển thị mảng đã sắp xếp
        System.out.print("\nMảng sau khi sắp xếp giảm dần: ");
        for (int x : arr) System.out.print(x + " ");
        System.out.println();

        // 3. Nhập số cần tìm
        System.out.print("\nNhập số cần tìm: ");
        int x = sc.nextInt();

        // 4. Tìm kiếm tuyến tính (Linear Search)
        int linearRes = -1;
        for (int i = 0; i < n; i++) {
            if (arr[i] == x) {
                linearRes = i;
                break;
            }
        }

        // 5. Tìm kiếm nhị phân (Binary Search) - Áp dụng cho mảng GIẢM DẦN
        int binaryRes = -1;
        int left = 0;
        int right = n - 1;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            if (arr[mid] == x) {
                binaryRes = mid;
                break;
            }
            // Vì mảng giảm dần: nếu arr[mid] < x, x phải nằm bên trái
            if (arr[mid] < x) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        // 6. Đầu ra: Kết quả
        System.out.println("--- Kết quả tìm kiếm ---");
        System.out.println("Tìm kiếm tuyến tính: " + (linearRes != -1 ? "Thấy tại chỉ số " + linearRes : "Không tìm thấy"));
        System.out.println("Tìm kiếm nhị phân: " + (binaryRes != -1 ? "Thấy tại chỉ số " + binaryRes : "Không tìm thấy"));

        sc.close();
    }
}


