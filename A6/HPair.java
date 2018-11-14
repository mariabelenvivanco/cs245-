/* Author: Richard Eisenberg
   File: HPair.java

   A heterogeneous pair class. It's heterogeneous because the two
   elements of the pair might have different types. Based on
   Horstmann's Pair class.

  Types: Reference Types
*/

public class HPair<A,B>
{
  private A first;
  private B second;

  public HPair()
  {
    first = null;
    second = null;
  }

  public HPair(A f, B s)
  {
    first = f;
    second = s;
  }

  public A getFirst()
  {
    return first;
  }

  public B getSecond()
  {
    return second;
  }

  public void setFirst(A value)
  {
    first = value;
  }

  public void setSecond(B value)
  {
    second = value;
  }
}
