CLASS zcl_4408_connections DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS: get_connections IMPORTING i_departure          TYPE /dmo/airport_from_id
                                   RETURNING VALUE(r_connections) TYPE zcert_connections.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_4408_connections IMPLEMENTATION.
  METHOD get_connections.

    SELECT FROM /dmo/connection
      FIELDS carrier_id,
             airport_from_id,
             airport_to_id,
             CAST( '-' AS CHAR( 3 ) ) AS airport_via_id
      WHERE airport_from_id = @i_departure
      INTO TABLE @r_connections.

    SELECT FROM /dmo/connection AS t1
            INNER JOIN /dmo/connection AS t2
              ON  t1~carrier_id    = t2~carrier_id
              AND t1~airport_to_id = t2~airport_from_id
     FIELDS t1~carrier_id,
            t1~airport_from_id,
            t2~airport_to_id,
            t1~airport_to_id AS airport_via_id
     WHERE t1~airport_from_id  = @i_departure
       AND t2~airport_to_id   <> @i_departure
     APPENDING TABLE @r_connections.


  ENDMETHOD.

ENDCLASS.
