import java.util.stream.*;
import java.util.function.*;
// import java.util.Optional;
// import java.util.Comparator;
import java.util.*;


public class StreamExercises {
  public static Optional<String> longest(List<String> strings){ // returns longest string
    return strings.stream()
                  .max(Comparator.comparingInt(String::length));
  }
  public static <A extends Comparable<? super A>> Stream<A> top5(Stream<A> input){ //returns max 5 elements
      return input.sorted(Collections.reverseOrder()) //stack overflow
                  .limit(5);
  }
  public static boolean isPrime(int i) {
       IntPredicate isDivisible = index ->  i % index == 0;
       return i > 1 && IntStream.range(2, i).noneMatch(isDivisible); //finding if there are factors  source:StackOverflow
  } //stack overflow
  public static int sumPrimes(int lo, int hi){ // sum of all prime numbers btwn lo-hi include
      return  IntStream.rangeClosed(lo,hi)
                          .filter(StreamExercises::isPrime)
                          .sum();

  }
  public static void main(String[] args) {
    System.out.println(longest(Arrays.asList("these","are","some","strings","in","a","list")));
    // prints Optional[strings]
    System.out.println(longest(new ArrayList<>()));
     // prints Optional.empty
    System.out.println(top5(Stream.of(6,2,9,10,3,8,6,34)).collect(Collectors.toList()));
    // prints [34, 10, 9, 8, 6]
    System.out.println(sumPrimes(5,15));
    // prints 36
  }


}
