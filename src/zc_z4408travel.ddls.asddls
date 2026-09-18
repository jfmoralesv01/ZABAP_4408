@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'Z4408TRAVEL'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_Z4408TRAVEL
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_Z4408TRAVEL
  association [1..1] to ZR_Z4408TRAVEL as _BaseEntity on $projection.TRAVELUUID = _BaseEntity.TRAVELUUID
{
  key TravelUUID,
  AgencyID,
  TravelID,
  Description,
  StartDate,
  EndDate,
  Status,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CreatedAt,
  @Semantics: {
    User.Createdby: true
  }
  CreatedBy,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  @Semantics: {
    User.Lastchangedby: true
  }
  LastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  _BaseEntity
}
