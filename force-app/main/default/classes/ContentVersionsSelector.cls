public with sharing class ContentVersionsSelector extends fflib_SObjectSelector {
    public Schema.SObjectType getSObjectType() {
        return ContentVersion.sObjectType;
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
            ContentVersion.Id,
            ContentVersion.Title,
            ContentVersion.ContentDocumentId
        };
    }

    public static ContentVersionsSelector newInstance() {
        return (ContentVersionsSelector) Application.selector.newInstance(
            Schema.ContentVersion.sObjectType
        );
    }

    public List<ContentVersion> selectByIds(Set<Id> contentVersionIds) {
        return (List<ContentVersion>) this.selectSObjectsById(
            contentVersionIds
        );
    }

    public List<ContentVersion> selectByIdsAndLatest(
        Set<Id> contentDocumentIds
    ) {
        fflib_QueryFactory query = newQueryFactory(false, false, true); // assertCRUD, enforceFLS, includeSelectorFields
        query.setCondition('ContentDocumentId IN :contentDocumentIds');
        query.setCondition('IsLatest = TRUE');

        return (List<ContentVersion>) Database.query(
            String.escapeSingleQuotes(query.toSOQL())
        );
    }
}
