public class Tea {
    public static void orderTea(){
    Set<String> teaTypes = new Set <String>{'Black', 'White', 'Herbal'};
    system.debug(teaTypes);
    teaTypes.add('Green');
    teaTypes.add('Black');
    system.debug(teaTypes);
	}
}