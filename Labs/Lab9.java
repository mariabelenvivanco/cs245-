import java.util.stream.Stream;
import java.util.function.ToIntFunction;
import java.util.*;

public class Lab9 {
  public static void printAll(List<?> stuff){
    stuff.stream()
         .forEach(e -> System.out.println(e));
  }

  public static List<String> toStrings(List<Integer> nums) {
     List<String> stringList = new ArrayList<>();
     nums.stream()
         .forEach(e -> stringList.add(e.toString()));

     return stringList;
   }

   public static List<Integer> noZeros(List<Integer> nums){
     List<Integer> intList = new ArrayList<>();
     ToIntFunction<String> i  = (x)-> Integer.parseInt(x);


     nums.stream()
         .filter(e -> e.toString().indexOf('0') == -1)
         .map(e -> Integer.parseInt(e));
 

         // .forEach(i -> intList.add(i));

    return intList;
   }

  public static void main(String[] args) {
     List<Integer> list = new ArrayList<>();
     list.add(3);
     list.add(3);
     list.add(3);
     list.add(3);

     printAll(list);

     List<String> a =  toStrings(list);

  }


}
