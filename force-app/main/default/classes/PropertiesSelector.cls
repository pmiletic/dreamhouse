public with sharing class PropertiesSelector extends fflib_SObjectSelector {
    public Schema.SObjectType getSObjectType() {
        return Property__c.sObjectType;
    }

    public List<Schema.SObjectField> getSObjectFieldList() {
        return new List<Schema.SObjectField>{
            Property__c.Id,
            Property__c.Name
        };
    }

    public static PropertiesSelector newInstance() {
        return (PropertiesSelector) Application.selector.newInstance(
            Schema.Property__c.sObjectType
        );
    }

    public Integer selectCountByNameAndOtherCriteria(
        String searchPattern,
        Decimal safeMaxPrice,
        Integer safeMinBedrooms,
        Integer safeMinBathrooms
    ) {
        Set<String> fieldsToQuery = new Set<String>{ 'Id', 'Description__c' };
        String query = 'SELECT COUNT() FROM Property__c WHERE ';
        query += '(Name LIKE :searchPattern OR City__c LIKE :searchPattern OR Tags__c LIKE :searchPattern) ';
        query += 'AND Price__c <= :safeMaxPrice ';
        query += 'AND Beds__c >= :safeMinBedrooms ';
        query += 'AND Baths__c >= :safeMinBathrooms';

        return Database.countQuery(String.escapeSingleQuotes(query));
    }

    public List<Property__c> selectByNameAndOtherCriteria(
        String searchPattern,
        Decimal safeMaxPrice,
        Integer safeMinBedrooms,
        Integer safeMinBathrooms,
        Integer safePageSize,
        Integer offset
    ) {
        Set<String> fieldsToQuery = new Set<String>{
            'Id',
            'Name',
            'Address__c',
            'City__c',
            'State__c',
            'Description__c',
            'Price__c',
            'Baths__c',
            'Beds__c',
            'Thumbnail__c',
            'Location__Latitude__s',
            'Location__Longitude__s'
        };

        fflib_QueryFactory query = newQueryFactory(false, false, false); // assertCRUD, enforceFLS, includeSelectorFields
        query.selectFields(fieldsToQuery);
        query.setCondition(
            '(Name LIKE :searchPattern OR City__c LIKE :searchPattern OR Tags__c LIKE :searchPattern) AND Price__c <= :safeMaxPrice AND Beds__c >= :safeMinBedrooms AND Baths__c >= :safeMinBathrooms'
        );
        query.addOrdering('Price__c', fflib_QueryFactory.SortOrder.DESCENDING);
        query.setLimit(safePageSize);
        query.setOffset(offset);

        return (List<Property__c>) Database.query(
            String.escapeSingleQuotes(query.toSOQL())
        );
    }
}
