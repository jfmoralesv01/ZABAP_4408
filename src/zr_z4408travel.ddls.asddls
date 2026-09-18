@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'Z4408TRAVEL'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_Z4408TRAVEL
  as select from ZZ4408TRAVEL
{
  key travel_uuid as TravelUUID,
  agency_id as AgencyID,
  travel_id as TravelID,
  description as Description,
  start_date as StartDate,
  end_date as EndDate,
  status as Status,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
}
