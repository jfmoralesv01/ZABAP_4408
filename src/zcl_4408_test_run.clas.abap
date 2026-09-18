CLASS zcl_4408_test_run DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PRIVATE SECTION.
    METHODS test_flight
      IMPORTING out TYPE REF TO if_oo_adt_classrun_out.
    METHODS test_passenger_flight
      IMPORTING out TYPE REF TO if_oo_adt_classrun_out.
    METHODS test_connections
      IMPORTING out TYPE REF TO if_oo_adt_classrun_out.
    METHODS test_agency
      IMPORTING out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.



CLASS zcl_4408_test_run IMPLEMENTATION.
METHOD if_oo_adt_classrun~main.
    out->write( '=== TASK 3: ZCL_####_FLIGHT ===' ).
    test_flight( out ).

    out->write( '=== TASK 3: ZCL_####_PASSENGER_FLIGHT ===' ).
    test_passenger_flight( out ).

    out->write( '=== TASK 4: ZCL_####_CONNECTIONS ===' ).
    test_connections( out ).

    out->write( '=== TASK 7: ZCL_####_AGENCY_MODEL ===' ).
    test_agency( out ).
  ENDMETHOD.

  METHOD test_flight.
    " Caso OK: conexión existente
    TRY.
        DATA(flight) = NEW zcl_4408_flight(
                           carrier_id    = 'LH'
                           connection_id = '0400'
                           plane_type    = '747-400' ).
        out->write( |OK  -> { flight->carrier_id } { flight->connection_id }: | &&
                    |{ flight->airport_from } -> { flight->airport_to }| ).
      CATCH zcx_c_abapd_no_connection INTO DATA(lx).
        out->write( |ERROR inesperado: { lx->get_text( ) }| ).
    ENDTRY.

    " Caso error: conexión inexistente
    TRY.
        flight = NEW zcl_4408_flight(
                     carrier_id    = 'XX'
                     connection_id = '9999'
                     plane_type    = '747-400' ).
        out->write( 'FALLO: debió lanzar la excepción' ).
      CATCH zcx_c_abapd_no_connection INTO lx.
        out->write( |OK  -> Excepción capturada: { lx->get_text( ) }| ).
    ENDTRY.
  ENDMETHOD.

  METHOD test_passenger_flight.
    " Caso OK: tipo de avión válido (A320-200, 737-800 o 747-400)
    TRY.
        DATA(pflight) = NEW zcl_4408_passenger_flight(
                            carrier_id    = 'LH'
                            connection_id = '0400'
                            plane_type    = 'A320-200' ).
        out->write( |OK  -> { pflight->carrier_id } { pflight->connection_id }: | &&
                    |{ pflight->airport_from } -> { pflight->airport_to }| ).
        " seats_max es privado: se valida por depuración (breakpoint en el constructor)
      CATCH zcx_c_abapd_no_connection INTO DATA(lx).
        out->write( |ERROR inesperado: { lx->get_text( ) }| ).
    ENDTRY.

    " Caso error: tipo de avión inexistente
    TRY.
        pflight = NEW zcl_4408_passenger_flight(
                      carrier_id    = 'LH'
                      connection_id = '0400'
                      plane_type    = 'ZZZ-000' ).
        out->write( 'FALLO: debió lanzar la excepción' ).
      CATCH zcx_c_abapd_no_connection INTO lx.
        out->write( |OK  -> Excepción capturada: { lx->get_text( ) }| ).
    ENDTRY.
  ENDMETHOD.

  METHOD test_connections.
    DATA(connections) = NEW zcl_4408_connections( ).

    DATA(result) = connections->get_connections( i_departure = 'EDI' ).
    out->write( |Conexiones desde EDI: { lines( result ) }| ).
    out->write( result ).

    result = connections->get_connections( i_departure = 'FRA' ).
    out->write( |Conexiones desde FRA: { lines( result ) }| ).
    out->write( result ).
  ENdMETHOD.

  METHOD test_agency.
    DATA(model) = NEW zcl_4408_agency_model( ).

    " Caso OK: agencia existente (ajuste el número según los datos del sistema)
    TRY.
        DATA(agency) = model->get_agency( i_agency = '070001' ).
        out->write( 'OK  -> Agencia encontrada:' ).
        out->write( agency ).
      CATCH zcx_4408_no_agency INTO DATA(lx).
        out->write( |ERROR inesperado: { lx->get_text( ) }| ).
    ENDTRY.

    " Caso error: agencia inexistente -> mensaje ZC_ABAPD 002 con &1
    TRY.
        agency = model->get_agency( i_agency = '999999' ).
        out->write( 'FALLO: debió lanzar la excepción' ).
      CATCH zcx_4408_no_agency INTO lx.
        out->write( |OK  -> Excepción capturada: { lx->get_text( ) }| ).
        out->write( |       agency_id en el objeto: { lx->agency_id }| ).
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
