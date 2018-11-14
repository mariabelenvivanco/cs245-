/* Author: Richard Eisenberg
   File: ComparableTreeMap.java

   A simple wrapper around TreeMap that requires its keys be Comparable.
   The "real" TreeMap allows clients to specify a Comparator instead of
   having the keys be Comparable.
*/

import java.util.*;

class ComparableTreeMap<K extends Comparable<? super K>, V> extends TreeMap<K, V>
{
  public ComparableTreeMap()
  {
    // this will implicitly call the default, no-arg constructor of TreeMap
  }
}
