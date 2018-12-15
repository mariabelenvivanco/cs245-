import java.util.*;
//import java.lang.*;

public class lab7 {
  public static void main (String[] args){
    Object num[] = new Integer[3];
    //num[0] = new String("hi"); //causes an ArrayStoreException
    ArrayList<Integer> l1 = new ArrayList <Integer>();
    ArrayList<String> l2 = new ArrayList <String>();  // creates an arraylist of integers
    ArrayList l3 = l2; //sets list of integers equal to list of strings
    l1 = l3;
    l2.add("hello");
    //int i = l1.get(0).intValue();
    //System.out.println("Value of i = " + i);

   }

   public static <T> void addAll(Collection<T> to, List<? extends T> from) {
     for(int i = 0; i < from.size(); i++){
       to.add(from.get(i));
     }
   }

   public static <A extends Comparable<B>,B> A findSmaller(List<A> where, B what) {
     for(int i = 0; i < where.size(); i++) {
       if(where.get(i).compareTo(what) < 0){
         return where.get(i);
       }
     }
     return null;
   }

}
