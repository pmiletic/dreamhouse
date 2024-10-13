@IsTest(IsParallel=true)
public with sharing class PropertiesSelectorTest {
    @IsTest
    static void testSelectCountByNameAndOtherCriteria() {
        PropertiesSelector.newInstance()
            .selectCountByNameAndOtherCriteria('%test%', 250000, 1, 5);
        Assert.areEqual(1, Limits.getQueries(), 'One query expected');
    }

    @IsTest
    static void testSelectByNameAndOtherCriteria() {
        PropertiesSelector.newInstance()
            .selectByNameAndOtherCriteria('%test%', 250000, 1, 5, 25, 0);
        Assert.areEqual(1, Limits.getQueries(), 'One query expected');
    }
}
