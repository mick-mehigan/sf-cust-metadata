ObjectRegistration registration = new ObjectRegistration();

List<FieldMapping> fieldMappings = new List<FieldMapping> {
  new FieldMapping('Name', 'Contact Name'),
  new FieldMapping('FirstName', 'Contact FirstName'),
  new FieldMapping('MiddleName', 'Contact Initial'),
  new FieldMapping('SurName', 'Contact Surname'),
  new FieldMapping('AddrLine1', 'Contact Addr Line 1'),
  new FieldMapping('AddrLine2', 'Contact Addr Line 2'),
  new FieldMapping('AddrCity', 'Contact Addr City'),
  new FieldMapping('email', 'Contact Email'),
  new FieldMapping('Phone', 'Contact Phone'),
  new FieldMapping('DOB', 'Contact DOB')
};

registration.registerFieldMapping('Contact', fieldMappings);
