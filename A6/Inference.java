/* Name: Maria Vivanco
   File: Inference.java

   Write the most general type for each of the following methods. Note that
   a most general type makes the fewest assumptions about its inputs (parameters)
   and offers the most information about its outputs (return type). That means
   that ArrayList<String> frob(List<String> l) is more general than
   ArrayList<String> frob(ArrayList<String> l), which is more general than
   List<String> frob(ArrayList<String> l).

   Include tests for your functions in the main method. Note that this assignment
   is all about *compiling*, not about runtime behavior (though your methods shouldn't
   fail at runtime either).
*/

import java.util.*;

public class Inference
{
  // HPair: Takes reference types
  public static <Object> void hpairSwap(HPair <Object,Object> hpair)
  {
    Object temp = hpair.getFirst(); // getFirst: returns first Type, A
    hpair.setFirst(hpair.getSecond()); // setFirst(A), getSecond: returns second type: type B
    hpair.setSecond(temp); // setSecond(B) -- takes in second type
  }
  // Copy the elements of an HPair into a Pair
  public static <A> void setPair(Pair<A> pair, HPair <A,A> hpair)
  {
    pair.setFirst(hpair.getFirst());
    pair.setSecond(hpair.getSecond());
  }

  // Copy the contents of a Pair into an HPair
  public static <A> void setHPair(HPair <A,A> hpair, Pair <A> pair)
  {
    hpair.setFirst(pair.getFirst());
    hpair.setSecond(pair.getSecond());
  }

  //Given a map m, add a new binding in m for each value v in m, where v maps to itself
  public static <V> void selfMap(Map <V,V> m)
  {
    for(V v : new ArrayList<>(m.values()))
    {
      m.put(v,v);
    }
  }

  //Add all the elements in a collection of collections into a target data structure.
   public static <T>  void unions(Collection <T> to , Collection <? extends Collection <T>> from)
  {
    for(Collection<T> coll : from)
    {
      for( T e : coll)
      {
	        to.add(e);
      }
    }
  }

  // Sort a list in place
  public static <T extends Comparable<T>> void sort(List <T> list)
  {
    for(int i = 0; i < list.size() - 1; i++)
    {
      int minIndex = i;
      for(int j = i+1; j < list.size(); j++)
      {
      	if(list.get(minIndex).compareTo(list.get(j)) > 0)
      	{
      	  minIndex = j;
      	}

      	T temp = list.get(minIndex);
      	list.set(minIndex, list.get(i));
      	list.set(i, temp);
      }
    }
  }

  // Find the maximum element in a collection of collections; returns null
  // if there are no elements in the collections
  public static <T extends Comparable<T>> T maxs(Collection <? extends Collection <T>>  colls)
  {
    T max = null;
    for(Collection<T> coll : colls)
    {
      for(T elem : coll)
      {
      	if(max != null)
      	{
      	  if(max.compareTo(elem) < 0)
      	  {
      	    max = elem;
      	  }
      	}
      	else
      	{
      	  max = elem;
      	}
      }
    }
    return max;
  }

  //Given a collection from, copy all the elements from 'from' into several "to" collections
  // tos - collection of collections
  public static <T> void copyTo(Collection<T> from, Collection<? extends Collection<T>> tos)
  {
    for(Collection<T> coll : tos)
    {
      for(T elem : from)
      {
	        coll.add(elem);
      }
    }
  }

  // Reverse a map; that is, produce a new map where each value in the original maps to its
  // key. If a value in the original is mapped to by several keys, the resulting map will
  // map that value to one such key, chosen arbitrarily.

  public static <K extends Comparable<? super K>,V extends Comparable<V>> ComparableTreeMap<V,K> reverseMap(Map<K,V> m)
  {
    ComparableTreeMap<V,K> result = new ComparableTreeMap<>();
    for(K k : m.keySet())
    {
      result.put(m.get(k), k);
    }
    return result;
  }

  // Like reverseMap, but if a value is mapped by multiple keys, stores all such keys
  // in a set.
  public static <K,V> Map <V,? extends Set<K>> reverseMapMany(Map<K,V> m)
  {
    Map <V, HashSet <K>> result = new HashMap<>();
    for(K k : m.keySet())
    {
      V v = m.get(k);
      if(!result.containsKey(v))
      {
	       result.put(v, new HashSet<>());
      }
      result.get(v).add(k);
    }
    return result;
  }

  // Extract the keys and values from a map.
  public static <K,V> HPair <? extends Collection <K>, ? extends Collection <V>> keysAndValues(Map <K,V> m)
  {
    return new HPair<>(m.keySet(), m.values());
  }

  // Given two lists, produce a list of Pairs of the corresponding elements of the lists.
  public static <T> List<Pair<T>> zip(List <T> as, List<T> bs)
  {
    ArrayList <Pair <T>> result = new ArrayList<>();
    for(int i = 0; i < as.size() && i < bs.size(); i++)
    {
      result.add(new Pair<>(as.get(i), bs.get(i)));
    }
    return result;
  }

  // Given a list of Pairs, produce a Pair of lists containing the original elements
  public static <T> Pair <List <T>> unzip(List <Pair <T>> asbs) // asbs: list of pairs
  {
    ArrayList <T>  as = new ArrayList<>();
    ArrayList <T>  bs = new ArrayList<>();
    for(Pair <T> pair : asbs)
    {
      as.add(pair.getFirst());
      bs.add(pair.getSecond());
    }
    return new Pair<>(as, bs);
  }

  // TODO: Given two lists, produce a list of HPairs of the corresponding elements of the lists.
  public static <A,B> List <HPair <A,B>> hzip(List <A> as, List <B> bs)
  {
    ArrayList <HPair <A,B>> result = new ArrayList<>();
    for(int i = 0; i < as.size() && i < bs.size(); i++)
    {
      result.add(new HPair<>(as.get(i), bs.get(i)));
    }
    return result;
  }

  // TODO: Given a list of HPairs, produce an HPair of lists containing the original elements.
  public static <A,B> HPair<List<A>,List<B>> hunzip(List <HPair <A,B>> asbs)
  {
    ArrayList <A> as = new ArrayList<>();
    ArrayList <B> bs = new ArrayList<>();
    for(HPair <A,B> pair : asbs)
    {
      as.add(pair.getFirst());
      bs.add(pair.getSecond());
    }
    return new HPair<>(as, bs);
  }

  // Given a collection of pairs, return the String representation of the greater element
  // of the pair, according to compareTo.
  // It is an interesting puzzle as to why this must return string representations, not
  // the elements themselves. It is not required as part of this homework, but it may be
  // interesting to try to answer this question.
  public static <T extends Comparable <T>> List<String> maxes(Collection <HPair <T,T>> coll)
  {
    List <String> result = new ArrayList<>();
    for(HPair<T,T> pair : coll)
    {
      if(pair.getFirst().compareTo(pair.getSecond()) > 0)
      {
	       result.add(pair.getFirst().toString()); // converts to string, adds string to collection
      }
      else
      {
	       result.add(pair.getSecond().toString());
      }
    }
    return result;
  }

  public static void main(String[] args)
  {

    Pair<String> pairString = new Pair<>();
    Pair<Integer> pairInteger = new Pair<> (2,3); // compiles
    Pair<Object> pairObject = new Pair<>("2",2); // compiles
    Pair<ArrayList<Integer>> pairArrayList  = new Pair<>(); // compiles
    HPair<String, String> hpairString = new HPair<>("x", "y");
    // Pair<Pair<Object>> pairofPair = new Pair<> (pairString, pairInteger); // does not compile
    // Pair<Pair<Object>> pairofPair = new Pair<> (pairString, pairInteger); // does not compile
    // HPair<int,float> hPair1  = new HPair<>(1, 2.3); // does not compile because int/float are not reference types


    /***** hPairSwap tests *****/
    hpairSwap(hpairString); // passes
    HPair<String, Integer> hPairStringInt = new HPair <> ("2",3);
    Integer temp = 3;
    //hPairStringInt.setFirst(temp); // integer cannot be be converted to string
    // hpairSwap(hPairStringInt); // does not compile


    /***** setPair() tests*****/
    //setPair (pairObject, hpairString); // doesn't compile
    setPair(pairString, hpairString); // passes
    Pair<Object> pairObject3  = new Pair<>();
    setPair(pairObject3, hpairString); // doesn't compile
    HPair<String, Object> hpair2 = new HPair<>("x", "y");
    //setPair(pairString, hpair2); // doesn't pass bc cannot conform to equality contraints
    HPair<Object, Object> hpairObject = new HPair<> ("x", "y");
    //setPair(pairString,hpairObject); // doesn't pass bc cannot conform to equality contraints

    /***** setHPair() test*****/
    HPair<Object,Object> hpair = new HPair<>();
    Pair<Object> pairObject2 = new Pair<>("2",pairString); //compiles
    setHPair(hpair, pairObject2); // passes
    setHPair(hpairString, pairString); //passes

    /***** selfMap() tests *****/
    TreeMap<String, String> mapString = new TreeMap<>();
    mapString.put("Monday", "Tuesday");
    mapString.put("Tuesday", "Wednesday");
    selfMap(mapString);
    TreeMap<int,int> mapInt = new TreeMap<>();

    /***** unions() test *****/
    ArrayList<ArrayList<String>> stringss = new ArrayList<>();
    stringss.add(new ArrayList<>());
    stringss.add(new ArrayList<>());
    stringss.get(0).add("a");
    stringss.get(1).add("b");
    stringss.get(0).add("c");
    stringss.get(1).add("d");

    ArrayList<String> strings = new ArrayList<>();
    unions(strings, stringss);


    sort(strings);
    String max = maxs(stringss);
    copyTo(strings, stringss);

    mapString = reverseMap(mapString);
    Map<String, ? extends Set<String>> reversed = reverseMapMany(mapString);

    HPair<? extends Collection<String>, ? extends Collection<String>> kv = keysAndValues(mapString);

    List<Pair<String>> zipped = zip(strings, strings);

    Pair<? extends List<String>> unzipped = unzip(zipped);

    List<HPair<String, String>> hzipped = hzip(strings, strings);

    HPair<? extends List<String>, ? extends List<String>> hunzipped = hunzip(hzipped);

    Collection<String> maxes = maxes(hzipped);

  }
}
