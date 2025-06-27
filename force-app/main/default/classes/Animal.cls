public class Animal {
    // by default acces modifier will be private for any variable 
	public String name = 'max';
    Integer age = 5;
    public static String address = '123 Main Street'; // This is a class variable // One time memory allocation
    
    private class InnerClass {
        String name = 'This is a inner private class';

        // Instance Variable OR Object Variable
    }
}