public with sharing class FileUtilities {
    @AuraEnabled
    public static String createFile(
        String base64data,
        String filename,
        String recordId
    ) {
        try {
            ContentVersion contentVersion = new ContentVersion();
            contentVersion.VersionData = EncodingUtil.base64Decode(base64data);
            contentVersion.Title = filename;
            contentVersion.PathOnClient = filename;
            insert contentVersion;

            ContentVersionsSelector selector = ContentVersionsSelector.newInstance();
            selector.setDataAccess(fflib_SObjectSelector.DataAccess.USER_MODE);
            List<ContentVersion> contentVersions = selector.selectByIds(
                new Set<Id>{ contentVersion.Id }
            );

            contentVersion = contentVersions[0];

            ContentDocumentLink contentDocumentLink = new ContentDocumentLink();
            contentDocumentLink.ContentDocumentId = contentVersion.ContentDocumentId;
            contentDocumentLink.LinkedEntityId = recordId;
            contentDocumentLink.ShareType = 'V';
            insert contentDocumentLink;

            return contentDocumentLink.Id;
        } catch (Exception ex) {
            throw new AuraHandledException(
                'Error creating file: ' + ex.getMessage()
            );
        }
    }
}
