@IsTest(IsParallel=true)
private class ContentDocumentLinksSelectorTest {
    @IsTest
    static void testSelectByLinkedEntityIdAndFileTypes() {
        Id propertId = fflib_IDGenerator.generate(
            Schema.Property__c.sObjectType
        );
        ContentDocumentLinksSelector.newInstance()
            .selectByLinkedEntityIdAndFileTypes(propertId, new Set<String>());
        Assert.areEqual(1, Limits.getQueries(), 'One query expected');
    }
}
