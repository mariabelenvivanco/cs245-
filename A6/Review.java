
import java.util.*;

public class Review {

  public static <A extends Comparable<A>> A max (A a1, A a2){
    int result = a1.compareTo(a2);
    if (result < 0){
      return a2;
    } else
      return a1;
  }
  public static void append(Collection<? super Integer> integers, int n) {
    for (int i = 1; i <= n; i++) {
        integers.add(i);
    }
  }
  public static void main(String[] args) {
    // Dog d1 = new Dog();
    // Dog d2 = new Dog ();
    // Dog max = max(d1,d2);

    List<Number> numbers = new ArrayList<Number>();
    append(numbers, 5);
    numbers.add(6.789);

    System.out.println(numbers);

    List<Integer> number= new ArrayList<Integer>(); // legal
    int x = 5;
    // System.out.println((x=7) + x); // 14
    // System.out.println( x+ (x=7)); // 12
    System.out.println((x = 8) > 6 || (x - 3) < 2);
    System.out.println(x);

    // ArrayStore Exception
    // Object c[] = new String[3];
    // c[0] = new Integer(0);

    Object d[] = new Object[3];
    d[0] = new Integer(0); // fine

    Pet a = new Pet();
    Object cat[] = new Cat[3];
    d[0] = a;




  }

}
