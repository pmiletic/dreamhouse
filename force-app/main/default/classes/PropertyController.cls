public with sharing class PropertyController {
    private static final Decimal DEFAULT_MAX_PRICE = 9999999;
    private static final Integer DEFAULT_PAGE_SIZE = 9;

    /**
     * Endpoint that retrieves a paged and filtered list of properties
     * @param searchKey String used for searching on property title, city and tags
     * @param maxPrice Maximum price
     * @param minBedrooms Minimum number of bedrooms
     * @param minBathrooms Minimum number of bathrooms
     * @param pageSize Number of properties per page
     * @param pageNumber Page number
     * @return PagedResult object holding the paged and filtered list of properties
     */
    @AuraEnabled(cacheable=true scope='global')
    public static PagedResult getPagedPropertyList(
        String searchKey,
        Decimal maxPrice,
        Integer minBedrooms,
        Integer minBathrooms,
        Integer pageSize,
        Integer pageNumber
    ) {
        // Normalize inputs
        Decimal safeMaxPrice = maxPrice ?? DEFAULT_MAX_PRICE;
        Integer safeMinBedrooms = minBedrooms ?? 0;
        Integer safeMinBathrooms = minBathrooms ?? 0;
        Integer safePageSize = pageSize ?? DEFAULT_PAGE_SIZE;
        Integer safePageNumber = pageNumber ?? 1;

        String searchPattern = '%' + searchKey + '%';
        Integer offset = (safePageNumber - 1) * safePageSize;

        PagedResult result = new PagedResult();
        result.pageSize = safePageSize;
        result.pageNumber = safePageNumber;
        result.totalItemCount = PropertiesSelector.newInstance()
            .selectCountByNameAndOtherCriteria(
                searchPattern,
                safeMaxPrice,
                safeMinBedrooms,
                safeMinBathrooms
            );

        result.records = PropertiesSelector.newInstance()
            .selectByNameAndOtherCriteria(
                searchPattern,
                safeMaxPrice,
                safeMinBedrooms,
                safeMinBathrooms,
                safePageSize,
                offset
            );

        return result;
    }

    /**
     * Endpoint that retrieves pictures associated with a property
     * @param propertyId Property Id
     * @return List of ContentVersion holding the pictures
     */
    @AuraEnabled(cacheable=true scope='global')
    public static List<ContentVersion> getPictures(Id propertyId) {
        List<ContentDocumentLink> links = ContentDocumentLinksSelector.newInstance()
            .selectByLinkedEntityIdAndFileTypes(
                propertyId,
                new Set<String>{ 'PNG', 'JPG', 'GIF' }
            );

        if (links.isEmpty()) {
            return null;
        }

        Set<Id> contentIds = new Set<Id>();

        for (ContentDocumentLink link : links) {
            contentIds.add(link.ContentDocumentId);
        }

        return ContentVersionsSelector.newInstance()
            .selectByIdsAndLatest(contentIds);
    }
}
