public class Book {

    // ── Thuộc tính (public) — đúng theo sơ đồ ──────
    public String title;
    public String author;
    public double price;

    // ── Constructor ──────────────
    public Book(String title, String author, double price) {
        this.title  = title;
        this.author = author;
        this.price  = price;
    }

    
    public void printInfo() {
        System.out.println("=== Thông tin quyển sách ===");
        System.out.println("Tên sách : " + title);
        System.out.println("Tác giả  : " + author);
        System.out.printf ("Giá      : %.0f VND%n", price);
    }

    // ── Main — chạy thử
    public static void main(String[] args) {
        Book b1 = new Book("Lập trình Java cơ bản", "Nguyễn Văn A", 120_000);
        Book b2 = new Book("Clean Code",             "Robert Martin", 350_000);

        b1.printInfo();
        System.out.println();
        b2.printInfo();
    }
}