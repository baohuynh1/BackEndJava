import java.util.Scanner;

public class HoaDonThanhToan {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        // Nhập
        System.out.print("Nhập tên khách hàng: ");
        String tenKhachHang = scanner.nextLine();

        System.out.print("Nhập tên sản phẩm: ");
        String tenSanPham = scanner.nextLine();

        System.out.print("Nhập giá sản phẩm: ");
        double giaSanPham = scanner.nextDouble();

        System.out.print("Nhập số lượng mua: ");
        int soLuong = scanner.nextInt();

        System.out.print("Khách có thẻ thành viên không (true/false): ");
        boolean laThanhVien = scanner.nextBoolean();

        // Tính toán
        double thanhTien = giaSanPham * soLuong;
        double giamGia = laThanhVien ? thanhTien * 0.10 : 0; // giảm 10% nếu là thành viên
        double vat = (thanhTien - giamGia) * 0.08;           // VAT 8% trên số tiền sau giảm giá
        double tongThanhToan = thanhTien - giamGia + vat;

        // In thông tin hóa đơn
        System.out.println("\n===== HÓA ĐƠN THANH TOÁN =====");
        System.out.println("Khách hàng: " + tenKhachHang);
        System.out.println("Sản phẩm: " + tenSanPham);
        System.out.println("Số lượng: " + soLuong);
        System.out.println("Đơn giá: " + giaSanPham);
        System.out.println("Thành tiền: " + thanhTien);
        System.out.println("Giảm giá: " + giamGia);
        System.out.println("Tiền VAT (8%): " + vat);
        System.out.println("Tổng thanh toán: " + tongThanhToan);

        scanner.close();
    }
}
