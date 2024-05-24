codeunit 50121 "HelloWorld Test"
{
    Subtype = Test;
    SingleInstance = true;
    EventSubscriberInstance = Manual;

    [HandlerFunctions('SalesShipmentRequestPageHandler')]
    [Test]
    procedure FunctionNameTest()
    var
        SalesShipmentHeader: Record "Sales Shipment Header";
        ThisCodeunit: Codeunit "HelloWorld Test";
    begin
        if UnbindSubscription(ThisCodeunit) then; //Avoid error if subscription is not bound
        BindSubscription(ThisCodeunit);
        SalesShipmentHeader.FindFirst();
        SalesShipmentHeader.SetRecFilter();
        Report.Run(Report::"Sales - Shipment", true, false, SalesShipmentHeader);
    end;

    [RequestPageHandler]
    procedure SalesShipmentRequestPageHandler(var RequestPage: TestRequestPage "Sales - Shipment")
    begin
        RequestPage.Print().Invoke();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Reporting Triggers", 'OnDocumentPrintReady', '', true, true)]
    local procedure OnDocumentPrintReady(ObjectType: Option "Report","Page"; ObjectId: Integer; ObjectPayload: JsonObject; DocumentStream: InStream; var Success: Boolean);
    begin
        // This code is not expected to be executed
        Error('OnDocumentPrintReady should not be called');
    end;
}
