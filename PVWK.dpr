program PVWK;

uses
  Vcl.Forms,
  View.PedidoVenda in 'View\View.PedidoVenda.pas' {ViewPedidoVenda},
  PVWK.Model.Connection.Interfaces in 'Model\Connection\PVWK.Model.Connection.Interfaces.pas',
  PVWK.Model.Connection.MySQL in 'Model\Connection\PVWK.Model.Connection.MySQL.pas',
  PVWK.Model.DAO.Interfaces in 'Model\DAO\PVWK.Model.DAO.Interfaces.pas',
  PVWk.Model.Entities.Clientes in 'Model\Entities\PVWk.Model.Entities.Clientes.pas',
  PVWK.Model.Entities.Produtos in 'Model\Entities\PVWK.Model.Entities.Produtos.pas',
  PVWK.Model.Entities.Pedidos in 'Model\Entities\PVWK.Model.Entities.Pedidos.pas',
  PVWK.Model.Entities.ProdutosPedidos in 'Model\Entities\PVWK.Model.Entities.ProdutosPedidos.pas',
  PVWk.Model.DAO.Clientes in 'Model\DAO\PVWk.Model.DAO.Clientes.pas',
  PVWK.Model.DAO.Produtos in 'Model\DAO\PVWK.Model.DAO.Produtos.pas',
  PVWK.Controller.Interfaces in 'Controller\PVWK.Controller.Interfaces.pas',
  PVWK.Model.DAO.Pedidos in 'Model\DAO\PVWK.Model.DAO.Pedidos.pas',
  PVWK.Model.DAO.ProdutosPedidos in 'Model\DAO\PVWK.Model.DAO.ProdutosPedidos.pas',
  PVWk.Controller in 'Controller\PVWk.Controller.pas',
  PVWK.Controller.Entities in 'Controller\PVWK.Controller.Entities.pas',
  View.BuscaPedido in 'View\View.BuscaPedido.pas' {ViewBuscaPedido},
  View.BuscaCliente in 'View\View.BuscaCliente.pas' {ViewBuscaCliente},
  View.BuscaProduto in 'View\View.BuscaProduto.pas' {ViewBuscaProduto},
  PVWK.Helper.MemTable in 'Helper\PVWK.Helper.MemTable.pas',
  PVWK.Helper.Edit in 'Helper\PVWK.Helper.Edit.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TViewPedidoVenda, ViewPedidoVenda);
  Application.CreateForm(TViewBuscaCliente, ViewBuscaCliente);
  Application.CreateForm(TViewBuscaProduto, ViewBuscaProduto);
  Application.Run;
end.
