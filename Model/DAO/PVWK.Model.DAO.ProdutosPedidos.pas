unit PVWK.Model.DAO.ProdutosPedidos;

interface

uses
  PVWK.Model.DAO.Interfaces,
  PVWK.Model.Entities.ProdutosPedidos,
  Data.DB,
  PVWK.Model.Connection.Interfaces,
  PVWK.Model.Connection.MySQL;

type
  TModelDAOProdutosPedidos = class(TInterfacedObject, iModelDAOEntity<TProdutosPedidos>)
    private
      FProdutosPedidos: TProdutosPedidos;
      FConnection: iConnection;
      FDataSet: TDataSet;

    public
      constructor Create;
      destructor  Destroy; override;
      class function New: iModelDAOEntity<TProdutosPedidos>;
      function List : iModelDAOEntity<TProdutosPedidos>; overload;
      function List(Id: Integer): iModelDAOEntity<TProdutosPedidos>; overload;
      function List(SQL: string): iModelDAOEntity<TProdutosPedidos>; overload;
      function Delete: iModelDAOEntity<TProdutosPedidos>; overload;
      function Delete(SQL: string): iModelDAOEntity<TProdutosPedidos>; overload;
      function Update: iModelDAOEntity<TProdutosPedidos>; overload;
      function Update(SQL: string): iModelDAOEntity<TProdutosPedidos>; overload;
      function Insert: iModelDAOEntity<TProdutosPedidos>;
      function DataSet(DataSource: TDataSource):  iModelDAOEntity<TProdutosPedidos>;
      function NextId: Integer;
      function This: TProdutosPedidos;

end;

implementation

uses
  System.SysUtils;

{ TModelDAOProdutosPedidos }

function TModelDAOProdutosPedidos.Update: iModelDAOEntity<TProdutosPedidos>;
begin
  Result := Self;
  try
    FConnection
      .StartTransaction
      .SQL('update produtospedidos set quantidade=:qtd, valorunitario=:preco, ' +
           'valortotal=:total where codigoitem=:iditem')
      .Params('qtd', FProdutosPedidos.Quantidade)
      .Params('preco', FProdutosPedidos.ValorUnitario)
      .Params('total', FProdutosPedidos.ValorTotal)
      .Params('iditem', FProdutosPedidos.CodigoItem)
      .ExecSQl
      .Commit;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar atualizar o registro: ' + e.ToString);
  end;
end;

constructor TModelDAOProdutosPedidos.Create;
begin
  FConnection := TModelConnectionMySQL.New;
  FProdutosPedidos  :=  TProdutosPedidos.Create(Self)
end;

function TModelDAOProdutosPedidos.DataSet(
  DataSource: TDataSource): iModelDAOEntity<TProdutosPedidos>;
begin
  Result  :=  Self;
  if not Assigned(FDataSet) then
    DataSource.DataSet  :=  FConnection.DataSet
  else
    DataSource.DataSet  :=  FDataSet;
end;

function TModelDAOProdutosPedidos.Delete(
  SQL: string): iModelDAOEntity<TProdutosPedidos>;
begin
  Result := Self;
  try
    FConnection
      .StartTransaction
      .SQL(SQL)
      .ExecSQl
      .Commit;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar excluir o registro: ' + e.ToString);
  end;
end;

destructor TModelDAOProdutosPedidos.Destroy;
begin
  FProdutosPedidos.DisposeOf;
  inherited;
end;

function TModelDAOProdutosPedidos.Delete: iModelDAOEntity<TProdutosPedidos>;
begin
  Result := Self;
  try
    FConnection
      .StartTransaction
      .SQL('delete from produtospedidos where codigoitem=:id')
      .Params('id', FProdutosPedidos.CodigoItem)
      .ExecSQl
      .Commit;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar excluir o registro: ' + e.ToString);
  end;
end;

function TModelDAOProdutosPedidos.Insert: iModelDAOEntity<TProdutosPedidos>;
begin
  Result := Self;
  try
    FConnection
      .StartTransaction
      .SQL('insert into produtospedidos (numeropedido, codigoproduto, ' +
           'quantidade, valorunitario, valortotal) ' +
           'values (:id, :idproduto, :qtd, :preco, :total)')
      .Params('id', FProdutosPedidos.NumeroPedido)
      .Params('idproduto', FProdutosPedidos.CodigoProduto)
      .Params('qtd', FProdutosPedidos.Quantidade)
      .Params('preco', FProdutosPedidos.ValorUnitario)
      .Params('total', FProdutosPedidos.ValorTotal)
      .ExecSQL
      .Commit;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar inserir o registro: ' + e.ToString);
  end;
end;

function TModelDAOProdutosPedidos.List(SQL: string): iModelDAOEntity<TProdutosPedidos>;
begin
  Result := Self;
  FDataSet :=
    FConnection
      .SQL(SQL)
      .Open
      .DataSet;
end;

function TModelDAOProdutosPedidos.List: iModelDAOEntity<TProdutosPedidos>;
begin
  Result  :=  Self;
  FDataSet  :=
    FConnection
      .SQL('select * from produtospedidos')
      .Open
      .DataSet;
end;

function TModelDAOProdutosPedidos.List(Id: Integer): iModelDAOEntity<TProdutosPedidos>;
begin
  Result  :=  Self;
  FDataSet  :=
    FConnection
      .SQL('select * from produtospedidos where numeropedido=:id')
      .Params('id', Id)
      .Open
      .DataSet;
end;

class function TModelDAOProdutosPedidos.New: iModelDAOEntity<TProdutosPedidos>;
begin
  Result  :=  Self.Create;
end;

function TModelDAOProdutosPedidos.NextId: Integer;
begin
  FDataSet := FConnection
    .SQL('select max(codigoitem) as codigoitem from produtospedidos')
    .Open
    .DataSet;

  Result := FDataSet.Fields[0].AsInteger + 1;
end;

function TModelDAOProdutosPedidos.This: TProdutosPedidos;
begin
  Result  :=  FProdutosPedidos;
end;

function TModelDAOProdutosPedidos.Update(
  SQL: string): iModelDAOEntity<TProdutosPedidos>;
begin
  Result := Self;
  try
    FConnection
      .StartTransaction
      .SQL(SQL)
      .ExecSQl
      .Commit;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar atualizar o registro: ' + e.ToString);
  end;
end;

end.
