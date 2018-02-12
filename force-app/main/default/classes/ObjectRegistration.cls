public class ObjectRegistration {
  public void registerProvider(String provider, String objType) {
    Metadata.DeployContainer metaDataContainer = new Metadata.DeployContainer();
    Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
    customMetadata.fullName = 'SOB_CFG_Provider.' + getProvider(objType);
    customMetadata.label = objType;
    customMetadata.values.add(createcustomField('Object_Provider_Class__c', provider));
    customMetadata.values.add(createcustomField('Object_Type__c', objType));
    metadataContainer.addMetadata(customMetadata);

    CustomMetadataCallback callback = new CustomMetadataCallback();
    Id jobId = Metadata.Operations.enqueueDeployment(metaDataContainer, callback);
    if (jobId != null) {
      System.debug('Successfully queued metadata deployment');
    } else {
      System.debug('Failed to queue metadata deployment');
    }
  }

  public void registerFieldMapping(String objType, List<FieldMapping> fieldMap) {
    Metadata.DeployContainer metaDataContainer = new Metadata.DeployContainer();
    for(FieldMapping fm : fieldMap) {
      Metadata.CustomMetadata customMetadata = createCustomMetaData(objType, fm);
      metadataContainer.addMetadata(customMetadata);
    }

    CustomMetadataCallback callback = new CustomMetadataCallback();
    Id jobId = Metadata.Operations.enqueueDeployment(metaDataContainer, callback);
    if (jobId != null) {
      System.debug('Successfully queued metadata deployment');
    } else {
      System.debug('Failed to queue metadata deployment');
    }
  }

  private String getProvider(String objType) {
    return 'AppIdentity_' + objType;
  }

  private Metadata.CustomMetadata createCustomMetaData(String objType, FieldMapping fieldMap) {
    Metadata.CustomMetadata customMetadata = new Metadata.CustomMetadata();
    customMetadata.fullName = 'SOB_CFG_Field_Mapping.' + getProvider(objType) + '_' + fieldMap.dest.replace(' ', '_');
    customMetadata.label = objType;
    customMetadata.values.add(createcustomField('Object_Type__c', objType));
    customMetadata.values.add(createcustomField('Provider__c', getProvider(objType)));
    customMetadata.values.add(createcustomField('Destination_Field__c', fieldMap.dest));
    customMetadata.values.add(createcustomField('Source_Field__c', fieldMap.src));

    return customMetadata;
  }

  private Metadata.CustomMetadataValue createCustomField(String field, String value) {
    Metadata.CustomMetadataValue customField = new Metadata.CustomMetadataValue();
    customField.field = field;
    customField.value = value;
    return customField;
  }
}