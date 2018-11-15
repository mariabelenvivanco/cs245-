/* Author: Richard Eisenberg
   File: Pet.java

   An abstract class storing a Pet
*/

public abstract class Pet implements Comparable<Pet>
{
  public abstract String getName();

  public abstract void speak(); // print out the animal's sound

  @Override
  public int compareTo(Pet other)
  {
    return getName().compareTo(other.getName());
  }
}
