CLASS lhc_zr_z4408travel DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.
    METHODS:
      get_global_authorizations FOR GLOBAL AUTHORIZATION
        IMPORTING
        REQUEST requested_authorizations FOR ZrZ4408travel
        RESULT result,
      setInitialStatus FOR DETERMINE ON SAVE
       keys FOR ZrZ4408travel~setInitialStatus.
ENDCLASS.

CLASS lhc_zr_z4408travel IMPLEMENTATION.
  METHOD get_global_authorizations.
  ENDMETHOD.
  METHOD setInitialStatus.

    READ ENTITIES OF zr_z4408travel IN LOCAL MODE
            ENTITY ZrZ4408travel
              FIELDS ( Status )
              WITH CORRESPONDING #( keys )
            RESULT DATA(travels).

    DELETE travels WHERE Status IS NOT INITIAL.
    CHECK travels IS NOT INITIAL.

    MODIFY ENTITIES OF zr_z4408travel IN LOCAL MODE
      ENTITY ZrZ4408travel
        UPDATE FIELDS ( Status )
        WITH VALUE #( FOR travel IN travels
                      ( %tky   = travel-%tky
                        Status = 'N' ) )
      REPORTED DATA(update_reported).

    reported = CORRESPONDING #( DEEP update_reported ).


  ENDMETHOD.

ENDCLASS.
