unit PVWK.Model.Entities.ProdutosPedidos;

interface

uses
  PVWK.Model.DAO.Interfaces;

type
  TProdutosPedidos = class
    private
      [weak]
      FParent : iModelDAOEntity<TProdutosPedidos>;
      FCodigoItem: Integer;
      FNumeroPedido: Integer;
      FCodigoProduto: Integer;
      FQuantidade: Integer;
      FValorUnitario: Currency;
      FValorTotal: Currency;

    public
      constructor Create(Parent: iModelDAOEntity<TProdutosPedidos>);
      destructor Destroy; override;
      function CodigoItem(Value: Integer): TProdutosPedidos; overload;
      function CodigoItem: Integer; overload;
      function NumeroPedido(Value: Integer): TProdutosPedidos; overload;
      function NumeroPedido: Integer; overload;
      function CodigoProduto(Value: Integer): TProdutosPedidos; overload;
      function CodigoProduto: Integer; overload;
      function Quantidade(Value: Integer): TProdutosPedidos; overload;
      function Quantidade: Integer; overload;
      function ValorUnitario(Value: Currency): TProdutosPedidos; overload;
      function ValorUnitario: Currency; overload;
      function ValorTotal(Value: Currency): TProdutosPedidos; overload;
      function ValorTotal: Currency; overload;
      function &End: iModelDAOEntity<TProdutosPedidos>;
    end;

implementation

{ TPrudutosPedidos }

function TProdutosPedidos.&End: iModelDAOEntity<TProdutosPedidos>;
begin
  Result  :=  FParent;
end;

constructor TProdutosPedidos.Create(Parent: iModelDAOEntity<TProdutosPedidos>);
begin
  FParent :=  Parent;
end;

destructor TProdutosPedidos.Destroy;
begin

  inherited;
end;

function TProdutosPedidos.CodigoProduto(Value: Integer): TProdutosPedidos;
begin
  Result      :=  Self;
  FCodigoProduto :=  Value;
end;

function TProdutosPedidos.CodigoProduto: Integer;
begin
  Result  :=  FCodigoProduto;
end;

function TProdutosPedidos.CodigoItem: Integer;
begin
  Result  :=  FCodigoItem;
end;

function TProdutosPedidos.CodigoItem(Value: Integer): TProdutosPedidos;
begin
  Result        :=  Self;
  FCodigoItem  :=  Value;
end;

function TProdutosPedidos.NumeroPedido(Value: Integer): TProdutosPedidos;
begin
  Result          :=  Self;
  FNumeroPedido  :=  Value;
end;

function TProdutosPedidos.NumeroPedido: Integer;
begin
  Result  :=  FNumeroPedido;
end;

function TProdutosPedidos.ValorTotal: Currency;
begin
  Result := FValorTotal;
end;

function TProdutosPedidos.ValorTotal(Value: Currency): TProdutosPedidos;
begin
  Result := Self;
  FValorTotal := Value;
end;

function TProdutosPedidos.ValorUnitario: Currency;
begin
  Result  :=  FValorUnitario;
end;

function TProdutosPedidos.ValorUnitario(Value: Currency): TProdutosPedidos;
begin
  Result := Self;
  FValorUnitario := Value;
end;

function TProdutosPedidos.Quantidade(Value: Integer): TProdutosPedidos;
begin
  Result := Self;
  FQuantidade := Value;
end;

function TProdutosPedidos.Quantidade: Integer;
begin
  Result := FQuantidade;
end;

end.
