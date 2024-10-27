unit PVWK.Controller;

interface

uses
  PVWK.Controller.Interfaces,
  PVWK.Controller.Entities;

type
  TController = class(TInterfacedObject, iController)
    private
       FEntity: iControllerEntities;
    public
      constructor Create;
      destructor Destroy; override;
      class function New: iController;
      function Entity: iControllerEntities;
  end;


implementation

{ TController }

constructor TController.Create;
begin

end;

destructor TController.Destroy;
begin

  inherited;
end;

function TController.Entity: iControllerEntities;
begin
  if not Assigned(FEntity) then
    FEntity := TControllerEntities.New;

  Result := FEntity;
end;

class function TController.New: iController;
begin
  Result := Self.Create;
end;

end.
