public with sharing class ContentDocumentLinksSelector extends fflib_SObjectSelector {
    public Schema.SObjectType getSObjectType() {
        return ContentDocumentLink.sObjectType;
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
            ContentDocumentLink.Id,
            ContentDocumentLink.LinkedEntityId,
            ContentDocumentLink.ContentDocumentId
        };
    }

    public static ContentDocumentLinksSelector newInstance() {
        return (ContentDocumentLinksSelector) Application.selector.newInstance(
            Schema.ContentDocumentLink.sObjectType
        );
    }

    public List<ContentDocumentLink> selectByIds(
        Set<Id> contentDocumentLinkIds
    ) {
        return (List<ContentDocumentLink>) this.selectSObjectsById(
            contentDocumentLinkIds
        );
    }

    public List<ContentDocumentLink> selectByIdsAndFileTypes(
        Set<Id> linkedEntityIds,
        Set<String> fileTypes
    ) {
        Set<String> fieldsToQuery = new Set<String>{ 'ContentDocument.Title' };

        fflib_QueryFactory query = newQueryFactory(false, false, true); // assertCRUD, enforceFLS, includeSelectorFields
        query.selectFields(fieldsToQuery);
        query.setCondition('LinkedEntityId IN :linkedEntityIds');
        query.setCondition('ContentDocument.FileType IN :fileTypes');

        return (List<ContentDocumentLink>) Database.query(
            String.escapeSingleQuotes(query.toSOQL())
        );
    }
}
