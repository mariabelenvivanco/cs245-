/* Author: Richard Eisenberg
   File: Dog.java

   Represents a pet dog
*/

public class Dog extends Pet
{
  private String name;
  private String breed;
  
  public Dog(String n, String b)
  {
    name = n;
    breed = b;
  }

  @Override
  public String getName()
  {
    return name;
  }

  public String getBreed()
  {
    return breed;
  }

  @Override
  public void speak()
  {
    System.out.println(name + ": woof!");
  }
}
