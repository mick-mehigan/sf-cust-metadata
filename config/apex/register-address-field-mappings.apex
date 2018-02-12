ObjectRegistration registration = new ObjectRegistration();

List<FieldMapping> fieldMappings = new List<FieldMapping> {
  new FieldMapping('Street1', 'Addr Line 1'),
  new FieldMapping('Street2', 'Addr Line 2'),
  new FieldMapping('Region', 'State'),
  new FieldMapping('State', 'Country')
};

registration.registerFieldMapping('Address', fieldMappings);
