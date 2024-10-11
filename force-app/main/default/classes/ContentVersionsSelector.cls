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
}
