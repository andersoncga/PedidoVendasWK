unit PVWK.Controller.Interfaces;

interface

uses
  PVWK.Model.DAO.Interfaces,
  PVWk.Model.Entities.Clientes,
  PVWK.Model.Entities.Produtos,
  PVWK.Model.Entities.Pedidos,
  PVWK.Model.Entities.ProdutosPedidos;

type
  iControllerEntities = interface;

  iController = interface
    function Entity: iControllerEntities;
  end;

  iControllerEntities = interface
    function Clientes: iModelDAOEntity<TClientes>;
    function Produtos: iModelDAOEntity<TProdutos>;
    function Pedidos: iModelDAOEntity<TPedidos>;
    function ProdutosPedidos: iModelDAOEntity<TProdutosPedidos>;
  end;

implementation

end.
