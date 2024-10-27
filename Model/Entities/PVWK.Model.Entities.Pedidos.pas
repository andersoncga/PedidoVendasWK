unit PVWK.Model.Entities.Pedidos;

interface

uses
  PVWK.Model.DAO.Interfaces;

type
  TPedidos  = class
    private
      [weak]
      FParent : iModelDAOEntity<TPedidos>;
      FNumeroPedido: Integer;
      FDataEmissao: TDate;
      FCodigoCliente: Integer;
      FValorTotal: Double;
    public
      constructor Create(Parent: iModelDAOEntity<TPedidos>);
      destructor Destroy; override;
      function NumeroPedido(Value: Integer): TPedidos; overload;
      function NumeroPedido: Integer; overload;
      function DataEmissao(Value: TDate): TPedidos; overload;
      function DataEmissao: TDate; overload;
      function CodigoCliente(Value: Integer): TPedidos; overload;
      function CodigoCliente: Integer; overload;
      function ValorTotal(Value: Double): TPedidos; overload;
      function ValorTotal: Double; overload;
      function &End: iModelDAOEntity<TPedidos>;
end;

implementation

{ TPedidos }

function TPedidos.&End: iModelDAOEntity<TPedidos>;
begin
  Result  :=  FParent;
end;

constructor TPedidos.Create(Parent: iModelDAOEntity<TPedidos>);
begin
  FParent :=  Parent;
end;

function TPedidos.DataEmissao: TDate;
begin
  Result  :=  FDataEmissao;
end;

function TPedidos.DataEmissao(Value: TDate): TPedidos;
begin
  Result        :=  Self;
  FDataEmissao  :=  Value;
end;

destructor TPedidos.Destroy;
begin
  inherited;
end;

function TPedidos.CodigoCliente: Integer;
begin
  Result  :=  FCodigoCliente;
end;

function TPedidos.CodigoCliente(Value: Integer): TPedidos;
begin
  Result := Self;
  FCodigoCliente := Value;
end;

function TPedidos.NumeroPedido: Integer;
begin
  Result  :=  FNumeroPedido;
end;

function TPedidos.NumeroPedido(Value: Integer): TPedidos;
begin
  Result        :=  Self;
  FNumeroPedido:=  Value;
end;

function TPedidos.ValorTotal: Double;
begin
  Result  :=  FValorTotal;
end;

function TPedidos.ValorTotal(Value: Double): TPedidos;
begin
  Result        :=  Self;
  FValorTotal :=  Value;
end;

end.
