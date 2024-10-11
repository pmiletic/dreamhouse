@IsTest(IsParallel=true)
private class ContentDocumentLinksSelectorTest {
    @IsTest
    static void testSelectByIds() {
        ContentDocumentLinksSelector.newInstance().selectByIds(new Set<Id>());
        Assert.areEqual(1, Limits.getQueries(), 'One query expected');
    }

    @IsTest
    static void testSelectByIdsAndFileTypes() {
        ContentDocumentLinksSelector.newInstance()
            .selectByIdsAndFileTypes(new Set<Id>(), new Set<String>());
        Assert.areEqual(1, Limits.getQueries(), 'One query expected');
    }
}
