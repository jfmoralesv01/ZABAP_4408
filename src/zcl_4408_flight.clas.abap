CLASS zcl_4408_flight DEFINITION
  PUBLIC

  CREATE PUBLIC .

  PUBLIC SECTION.
    DATA: carrier_Id    TYPE /dmo/carrier_id READ-ONLY,
          connection_Id TYPE /dmo/connection_id READ-ONLY,
          airport_from  TYPE /dmo/airport_from_id READ-ONLY,
          airport_to    TYPE /dmo/airport_to_id READ-ONLY.

     METHODS: constructor IMPORTING carrier_Id    TYPE /dmo/carrier_id
                                   connection_Id TYPE /dmo/connection_id
                                   plane_type    TYPE /dmo/plane_type_id
                         RAISING   zcx_c_abapd_no_connection.


  PROTECTED SECTION.
  DATA: plane_type TYPE /dmo/plane_type_id.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_4408_flight IMPLEMENTATION.
  METHOD constructor.
    me->carrier_id = carrier_id.
    me->connection_id = connection_id.
    me->plane_type = plane_type.

    SELECT SINGLE FROM /dmo/connection
    FIELDS airport_from_id,
           airport_to_id
    WHERE carrier_id = @carrier_id
    AND connection_id = @connection_id
    INTO ( @airport_from, @airport_to ).

    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_c_abapd_no_connection
        MESSAGE e001(ZCM_ABAP_4408) WITH carrier_id connection_id.
    ENDIF.

  ENDMETHOD.

ENDCLASS.
