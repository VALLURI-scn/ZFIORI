@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Travel Projection View'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZC_Travel
  provider contract transactional_query
  as projection on zi_travel
{
  key TravelId,
      //to concatenate ID and name on list report
      @ObjectModel.text.element: [ 'AgencyName' ] 
      //To display search help values on F4 help on selection screen
      @Consumption.valueHelpDefinition: [{ entity:{ element: 'AgencyID', name: '/DMO/I_Agency' } } ]
      AgencyId,
      _Agency.Name             as AgencyName,
      @ObjectModel.text.element: [ 'CustomerName' ]
      CustomerId,
      _Customer.LastName       as CustomerName,
      BeginDate,
      EndDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      BookingFee,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      TotalPrice,
      CurrencyCode,
      Description,
      @ObjectModel.text.element: [ 'OverallStatusText' ]
      OverallStatus,
      _TravelStatus._Text.Text as OverallStatusText : localized,
      CreatedBy,
      CreatedAt,
      LastChangedBy,
      LastChangedAt,
      /* Associations */
      _Agency,
      _Booking : redirected to composition child ZC_Booking,
      _Currency,
      _Customer,
      _TravelStatus
}
