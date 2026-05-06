import java.util.Scanner ;

public class SapXepNoiBot {
    public static void main(String[] args){
        Scanner sc= new Scanner(System.in);

        System.out.print("Nhập kích thước mảng:");
        int n= sc.nextInt();
        int[] arr = new int[n];

        for(int i=0;i<n;i++){
            System.out.print("Nhập phần tử thứ"+(i+1) + ":");
            arr[i]=sc.nextInt();
        }

        for(int i=0;i<n-1;i++){
            for(int j=0;j<n-i-1;j++){
                if(arr[j]<arr[j+1]){
                    int temp=arr[j];
                    arr[i]=arr[j+1];
                    arr[j+1]=temp;
                }
            }
        }
        System.out.println("\nMang sau khi sắp xếp giảm dẩn: ");
        for(int x:arr){
            System.out.print(x+" ");
        }
        sc.close();
    }
}


