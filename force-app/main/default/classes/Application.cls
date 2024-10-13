public with sharing class Application {
    public static final fflib_Application.SelectorFactory selector = new fflib_Application.SelectorFactory(
        new Map<SObjectType, Type>{
            ContentVersion.sObjectType => ContentVersionsSelector.class,
            ContentDocumentLink.sObjectType => ContentDocumentLinksSelector.class,
            Property__c.sObjectType => PropertiesSelector.class
        }
    );
}
