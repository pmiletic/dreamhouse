@IsTest(IsParallel=true)
public with sharing class ContentVersionsSelectorTest {
    @IsTest
    static void testSelectByIds() {
        ContentVersionsSelector.newInstance().selectByIds(new Set<Id>());
        Assert.areEqual(1, Limits.getQueries(), 'One query expected');
    }
}
