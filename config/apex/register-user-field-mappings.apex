ObjectRegistration registration = new ObjectRegistration();

List<FieldMapping> fieldMappings = new List<FieldMapping> {
  new FieldMapping('Name', 'firstName'),
  new FieldMapping('Id', 'identifier'),
  new FieldMapping('Account', 'Subscription'),
  new FieldMapping('Contact', 'PointOfContact')
};

registration.registerFieldMapping('User', fieldMappings);
