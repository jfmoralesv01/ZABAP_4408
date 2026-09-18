CLASS zcl_4408_agency_model DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS get_agency IMPORTING i_agency        TYPE /dmo/agency_id
                       RETURNING VALUE(r_agency) TYPE zc_abapd_agency
                       RAISING zcx_4408_no_agency.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_4408_agency_model IMPLEMENTATION.
  METHOD get_agency.
    SELECT SINGLE FROM zc_abapd_agency
    FIELDS *
    WHERE agencyId = @i_agency
    INTO @r_agency.

    if sy-subrc NE 0.

      RAISE  EXCEPTION NEW zcx_4408_no_agency( agency_id = i_agency ).

    ENDIF.

* To Do: Add suitable error handling if no data is returned
  ENDMETHOD.
ENDCLASS.
