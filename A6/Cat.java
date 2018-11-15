/* Author: Richard Eisenberg
   File: Cat.java

   Represents a pet dog
*/

public class Cat extends Pet
{
  private String name;
  private boolean hasClaws;
  
  public Cat(String n, boolean c)
  {
    name = n;
    hasClaws = c;
  }

  @Override
  public String getName()
  {
    return name;
  }

  public boolean hasClaws()
  {
    return hasClaws;
  }

  @Override
  public void speak()
  {
    System.out.println(name + ": meow.");
  }
}
