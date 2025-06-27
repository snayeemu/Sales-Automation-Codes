public class StringListTest {
    public static list<String> generateStringList (Integer i){
        list<String> listOfTestString = new list<String>();
        for(Integer j = 0; j < i; j++){
            listOfTestString.add('Test ' + j);
        }
        return listOfTestString;
    }
}