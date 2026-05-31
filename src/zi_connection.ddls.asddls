@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface View - Connection'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI.headerInfo: {
    typeName: 'Connection',
    typeNamePlural: 'Connections'
//    typeImageUrl: '',
//    imageUrl: '',
//    title: {
//        type: #STANDARD,
//        label: '',
//        iconUrl: '',
//        criticality: '',
//        criticalityRepresentation: #WITHOUT_ICON,
//        value: '',
//        valueQualifier: '',
//        targetElement: '',
//        url: '',
//        urlTarget:
//    },

}
define view entity ZI_Connection
  as select from /dmo/connection as Connection
{
      @UI.facet: [{ purpose: #STANDARD,
                    type: #IDENTIFICATION_REFERENCE,
                    position: 10,
                    label: 'Connection Facet' }]

      @UI.lineItem: [{ position: 10, label: 'Airline' }]
      @UI.identification: [{ position: 10 }]
  key carrier_id      as CarrierId,

      @UI.lineItem: [{ position: 20 }]
      @UI.identification: [{ position: 20 }]
  key connection_id   as ConnectionId,

      @UI.lineItem: [{ position: 30 }]
      @UI.identification: [{ position: 30 }]
      airport_from_id as AirportFromId,

      @UI.lineItem: [{ position: 40 }]
      @UI.identification: [{ position: 40 }]
      airport_to_id   as AirportToId,
      @UI.lineItem: [{ position: 50 }]
      departure_time  as DepartureTime,
      @UI.lineItem: [{ position: 60 }]
      arrival_time    as ArrivalTime,
      @UI.lineItem: [{ position: 70, label: 'Arrival Time'}]
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      distance        as Distance,
      //      @UI.lineItem: [{ position: 80 }]
      distance_unit   as DistanceUnit
}
