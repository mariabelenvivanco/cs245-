/* Author: Richard Eisenberg and <your name here>
File: BSTMapExercise.java

An implementation of a binary tree, ripe for conversion into a generic class.
*/

// One node in a binary tree, storing two ints as data.
class BSTNode<K extends Comparable<K>, V>
{
  public K key;
  public V value;

  public BSTNode<K,V> left = null;
  public BSTNode<K,V> right = null;

  public BSTNode(K key, V value)
  {
    this.key = key;
    this.value = value;
  }
}

// An implementation of an associative map from ints to ints, stored using
// a binary search tree implementation.
class BSTMap<K extends Comparable<K>, V>
{
  // The root of the tree.
  BSTNode root = null;

  // Construct an empty tree.
  public BSTMap()
  {
  }

  // Add a new mapping in the map from key to value.
  // Postcondition: the key is mapped to the value.
  public <K extends Comparable<K>> void insert (K key, V value)
  {
    if(key == null) {
      return;
    }
    BSTNode<K,V> newNode = new BSTNode<K,V>(key, value);

    if(root == null)
    {
      root = newNode;
    }
    else
    {
      BSTNode<K,V> cur = root;

      // INVARIANT: cur != null
      while(cur != null)
      {
        if(key.equals (cur.key))
        {
          // The newNode becomes garbage in this case.
          cur.value = value;
          return;
        }

        else if(key.compareTo(cur.key) < 0)
        {


          if(cur.left == null)
          {
            cur.left = newNode;
            return;
          }
          else
          {
            cur = cur.left;
          }
        }
        else
        {
          if(cur.right == null)
          {
            cur.right = newNode;
            return;
          }
          else
          {
            cur = cur.right;
          }
        }
      }
    }
  }

  // Retrieve a value from the map given a key; returns -1 of the key
  // is not mapped to anything.
  public <K extends Comparable<K>> Optional<V> lookup(K key)
  {
    BSTNode<K,V> cur = root;

    if(cur.key == null) {
      return Optional.ofNullable(null);
    }

    if(key == null) {
      return Optional.ofNullable(null);
    }

    while(cur != null)
    {
      if(cur.key.equals(key))
      {
        return optional.of(cur.value);
      }
        else if(key.compareTo(cur.key) < 0)
      {
        cur = cur.left;
      }
      else
      {
        cur = cur.right;
      }
    }

    return Optional.ofNullable(null);; // default value
  }
}

// This class just tests our work, above.
public class BSTMapExercise
{
  public static void main(String[] args)
  {
    BSTMap<Integer, Integer> map = new BSTMap<Integer, Integer>();
    map.insert(100, 3);
    map.insert(120, 5);
    map.insert(-4, 8);
    map.insert(6, 10);

    System.out.println(map.lookup(6));
    System.out.println(map.lookup(120));
    System.out.println(map.lookup(5));
  }
}
