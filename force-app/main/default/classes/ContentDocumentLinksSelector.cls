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

    public List<ContentDocumentLink> selectByLinkedEntityIdAndFileTypes(
        Id linkedEntityId,
        Set<String> fileTypes
    ) {
        Set<String> fieldsToQuery = new Set<String>{ 'ContentDocument.Title' };

        fflib_QueryFactory query = newQueryFactory(false, false, true); // assertCRUD, enforceFLS, includeSelectorFields
        query.selectFields(fieldsToQuery);
        query.setCondition(
            'LinkedEntityId = :linkedEntityId AND ContentDocument.FileType IN :fileTypes'
        );
        System.debug(query.toSOQL());
        return (List<ContentDocumentLink>) Database.query(
            String.escapeSingleQuotes(query.toSOQL())
        );
    }
}
