unit PVWK.Model.Entities.Produtos;

interface
uses
  PVWK.Model.DAO.Interfaces;
type
  TProdutos = class
    private
      [weak]
      FParent : iModelDAOEntity<TProdutos>;
      FCodigo : Integer;
      FDescricao: string;
      FPrecoVenda: Double;
    public
      constructor Create(Parent: iModelDAOEntity<TProdutos>);
      destructor Destroy; override;
      function Codigo(Value: Integer): TProdutos; overload;
      function Codigo: Integer; overload;
      function Descricao(Value: string): TProdutos; overload;
      function Descricao: string; overload;
      function PrecoVenda(Value: Double): TProdutos; overload;
      function PrecoVenda: Double; overload;
      function &End : iModelDAOEntity<TProdutos>;
  end;
implementation
{ TProdutos }
function TProdutos.&End: iModelDAOEntity<TProdutos>;
begin
  Result  :=  FParent;
end;
function TProdutos.Codigo: Integer;
begin
  Result  :=  FCodigo;
end;
function TProdutos.Codigo(Value: Integer): TProdutos;
begin
  Result  := Self;
  FCodigo := Value;
end;
constructor TProdutos.Create(Parent: iModelDAOEntity<TProdutos>);
begin
  FParent :=  Parent;
end;
function TProdutos.Descricao(Value: string): TProdutos;
begin
  Result      := Self;
  FDescricao  := Value;
end;
function TProdutos.Descricao: string;
begin
  Result  :=  FDescricao;
end;
destructor TProdutos.Destroy;
begin
  inherited;
end;
function TProdutos.PrecoVenda: Double;
begin
  Result  :=  FPrecoVenda;
end;
function TProdutos.PrecoVenda(Value: Double): TProdutos;
begin
  Result        :=  Self;
  FPrecoVenda  :=  Value;
end;
end.
