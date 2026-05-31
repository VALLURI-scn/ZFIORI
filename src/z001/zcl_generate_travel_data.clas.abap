CLASS zcl_generate_travel_data DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_generate_travel_data IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    " 1. Clean up existing data
    DELETE FROM ztravel.
    DELETE FROM zbooking.
    DELETE FROM zbook_suppl.

    " 2. Load TRAVEL data
    INSERT ztravel FROM (
      SELECT
        FROM /dmo/travel_m
        FIELDS
          travel_id,
  agency_id,
  customer_id,
  begin_date,
  end_date,
  booking_fee,
  total_price,
  currency_code,
  description,
 CASE
            WHEN booking_fee < 70 THEN 'O'  " Open
            WHEN booking_fee < 100  THEN 'A'  " Accepted
            ELSE 'X'         " Cancelled
          END AS overall_status
*  overall_satus
*  created_by      : abp_creation_user;
*  created_at      : abp_creation_tstmpl;
*  last_changed_by : abp_locinst_lastchange_user;
*  last_changed_at : abp_locinst_lastchange_tstmpl;
    ).
    out->write( |{ sy-dbcnt } travel records inserted.| ).

    " 3. Load BOOKING data
    INSERT zbooking FROM (
      SELECT
        FROM /dmo/booking_m
        FIELDS
          travel_id,
          booking_id,
          booking_date,
          customer_id,
          carrier_id,
          connection_id,
          flight_date,
          flight_price,
          currency_code,
          booking_status,
          last_changed_at AS last_changed_at " Source uses last_changed_at
    ).
    out->write( |{ sy-dbcnt } booking records inserted.| ).

    " 4. Load BOOKING SUPPLEMENT data
    INSERT zbook_suppl FROM (
      SELECT
        FROM /dmo/book_suppl
        FIELDS
              travel_id,
              booking_id,
              booking_supplement_id,
              supplement_id,
              price,
              currency_code
    ).
    out->write( |{ sy-dbcnt } supplement records inserted.| ).

    COMMIT WORK.
    out->write( 'Data generation completed successfully.' ).

  ENDMETHOD.
ENDCLASS.
