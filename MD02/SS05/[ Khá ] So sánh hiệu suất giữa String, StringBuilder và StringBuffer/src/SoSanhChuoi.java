
public class SoSanhChuoi {

    static final int    SO_LAN_LAP = 1_000_000;
    static final String CHUOI_GOC  = "Hello";
    static final String CHUOI_THEM = " World";


    // 1. String (immutable – tạo object mới mỗi lần)

    static long doiString() {
        long batDau = System.currentTimeMillis();

        String s = CHUOI_GOC;
        for (int i = 0; i < SO_LAN_LAP; i++) {
            s += CHUOI_THEM;
        }

        return System.currentTimeMillis() - batDau;
    }


    // 2. StringBuilder (mutable – không đồng bộ)

    static long doiStringBuilder() {
        long batDau = System.currentTimeMillis();

        StringBuilder sb = new StringBuilder(CHUOI_GOC);
        for (int i = 0; i < SO_LAN_LAP; i++) {
            sb.append(CHUOI_THEM);
        }

        return System.currentTimeMillis() - batDau;
    }


    // 3. StringBuffer (mutable – có đồng bộ hóa)

    static long doiStringBuffer() {
        long batDau = System.currentTimeMillis();

        StringBuffer sbf = new StringBuffer(CHUOI_GOC);
        for (int i = 0; i < SO_LAN_LAP; i++) {
            sbf.append(CHUOI_THEM);
        }

        return System.currentTimeMillis() - batDau;
    }

    public static void main(String[] args) {
        long tgString        = doiString();
        long tgStringBuilder = doiStringBuilder();
        long tgStringBuffer  = doiStringBuffer();

        // In kết quả
        System.out.println("Thời gian thực hiện với String: "        + tgString        + " ms");
        System.out.println("Thời gian thực hiện với StringBuilder: " + tgStringBuilder + " ms");
        System.out.println("Thời gian thực hiện với StringBuffer: "  + tgStringBuffer  + " ms");

        // Nhận xét
        System.out.println();
        System.out.println("Nhận xét:");
        System.out.println("- String: Không hiệu quả cho phép nối chuỗi nhiều lần do tạo ra nhiều đối tượng mới.");
        System.out.println("- StringBuilder: Hiệu quả và nhanh chóng, thích hợp cho nhiều thao tác nối chuỗi trong một luồng.");
        System.out.println("- StringBuffer: Tương tự như StringBuilder nhưng an toàn với đa luồng, có thể chậm hơn một chút do đồng bộ hóa.");
    }
}