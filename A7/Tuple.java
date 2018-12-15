/* Author: Richard Eisenberg
   File: Tuple.java

   Immutable tuples, with a nice functional interface.
*/

import java.util.function.*;

public final class Tuple<A,B>
{
  public final A fst;
  public final B snd;
  
  public Tuple(final A a, final B b)
  {
    fst = a;
    snd = b;
  }

  public <C,D> Tuple<C,D> map(final Function<A,C> f, final Function<B,D> g)
  {
    return new Tuple<>(f.apply(fst), g.apply(snd));
  }
  
  public <C> Tuple<C,B> mapFirst(final Function<A,C> f)
  {
    return map(f, Function.identity());
  }

  public <D> Tuple<A,D> mapSecond(final Function<B,D> g)
  {
    return map(Function.identity(), g);
  }
  
  public Tuple<A,B> changeFirst(final A a)
  {
    return map(x -> a, Function.identity());
  }

  public Tuple<A,B> changeSecond(final B b)
  {
    return map(Function.identity(), x -> b);
  }
}

  
