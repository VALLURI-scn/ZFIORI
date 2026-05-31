@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View Entity for Bookings'
@Metadata.ignorePropagatedAnnotations: true
define view entity zi_booking
  as select from zbooking
  association to parent zi_travel as _Travel on $projection.TravelId = _Travel.TravelId
  composition [0..*] of zibook_suppl as _BookingSuppl 
  association [1..1] to /DMO/I_Carrier    as _Carrier    on $projection.CarrierId = _Carrier.AirlineID
  association [1..1] to /DMO/I_Customer   as _Customer   on $projection.CustomerId = _Customer.CustomerID
  association [1..1] to /DMO/I_Connection as _Connection on $projection.ConnectionId = _Connection.ConnectionID
  association [0..1] to /DMO/I_Overall_Status_VH as _BookingStatus   on $projection.BookingStatus = _BookingStatus.OverallStatus
{
  key travel_id       as TravelId,
  key booking_id      as BookingId,
      booking_date    as BookingDate,
      customer_id     as CustomerId,
      carrier_id      as CarrierId,
      connection_id   as ConnectionId,
      flight_date     as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      flight_price    as FlightPrice,
      currency_code   as CurrencyCode,
      booking_status  as BookingStatus,
      last_changed_at as LastChangedAt,
      _Travel,
      _BookingSuppl,
      _Carrier,
      _Customer,
      _Connection,
      _BookingStatus
      
}
