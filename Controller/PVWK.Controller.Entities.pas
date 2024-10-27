unit PVWK.Controller.Entities;

interface

uses
  PVWK.Controller.Interfaces,
  PVWK.Model.DAO.Interfaces,
  PVWk.Model.Entities.Clientes,
  PVWK.Model.Entities.Produtos,
  PVWK.Model.Entities.Pedidos,
  PVWK.Model.Entities.ProdutosPedidos,
  PVWk.Model.DAO.Clientes,
  PVWK.Model.DAO.Produtos,
  PVWK.Model.DAO.Pedidos,
  PVWK.Model.DAO.ProdutosPedidos;

type
  TControllerEntities = class(TInterfacedObject, iControllerEntities)
    private
      FClientes: iModelDAOEntity<TClientes>;
      FProdutos: iModelDAOEntity<TProdutos>;
      FPedidos: iModelDAOEntity<TPedidos>;
      FProdutosPedidos: iModelDAOEntity<TProdutosPedidos>;

    public
      constructor Create;
      destructor Destroy; override;
      class function New: iControllerEntities;
      function Clientes: iModelDAOEntity<TClientes>;
      function Produtos: iModelDAOEntity<TProdutos>;
      function Pedidos: iModelDAOEntity<TPedidos>;
      function ProdutosPedidos: iModelDAOEntity<TProdutosPedidos>;
  end;

implementation

{ TControllerEntities }

function TControllerEntities.Clientes: iModelDAOEntity<TClientes>;
begin
  if not Assigned(FClientes) then
    FClientes := TModelDAOCliente.New;
  Result := FClientes;
end;

constructor TControllerEntities.Create;
begin

end;

destructor TControllerEntities.Destroy;
begin

  inherited;
end;

class function TControllerEntities.New: iControllerEntities;
begin
  Result := Self.Create;
end;

function TControllerEntities.Pedidos: iModelDAOEntity<TPedidos>;
begin
  if not Assigned(FPedidos) then
    FPedidos := TModelDAOPedido.New;

  Result := FPedidos;
end;

function TControllerEntities.Produtos: iModelDAOEntity<TProdutos>;
begin
  if not Assigned(FProdutos) then
    FProdutos := TModelDAOProduto.New;

  Result := FProdutos;
end;

function TControllerEntities.ProdutosPedidos: iModelDAOEntity<TProdutosPedidos>;
begin
  if not Assigned(FProdutosPedidos) then
    FProdutosPedidos := TModelDAOProdutosPedidos.New;

  Result := FProdutosPedidos;
end;

end.
