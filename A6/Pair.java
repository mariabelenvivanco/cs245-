/* Author: Cay Horstmann
   File: Pair.java

   A simple generic class (Horstmann, p. 418)
*/

public class Pair<T>
{
  private T first;
  private T second;

  public Pair()
  {
    first = null;
    second = null;
  }

  public Pair(T f, T s)
  {
    first = f;
    second = s;
  }

  public T getFirst()
  {
    return first;
  }

  public T getSecond()
  {
    return second;
  }

  public void setFirst(T value)
  {
    first = value;
  }

  public void setSecond(T value)
  {
    second = value;
  }
}
