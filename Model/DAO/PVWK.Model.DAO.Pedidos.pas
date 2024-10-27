unit PVWK.Model.DAO.Pedidos;

interface

uses
  PVWK.Model.Entities.Pedidos,
  Data.DB,
  PVWK.Model.DAO.Interfaces,
  PVWK.Model.Connection.Interfaces,
  PVWK.Model.Connection.MySQL;

type
  TModelDAOPedido = class(TInterfacedObject, iModelDAOEntity<TPedidos>)
    private
      FPedidos: TPedidos;
      FConnection: iConnection;
      FDataSet: TDataSet;

    public
      constructor Create;
      destructor  Destroy; override;
      class function New: iModelDAOEntity<TPedidos>;
      function List : iModelDAOEntity<TPedidos>; overload;
      function List(Id: Integer): iModelDAOEntity<TPedidos>; overload;
      function List(SQL: string): iModelDAOEntity<TPedidos>; overload;
      function Delete: iModelDAOEntity<TPedidos>; overload;
      function Delete(SQL: string): iModelDAOEntity<TPedidos>; overload;
      function Update: iModelDAOEntity<TPedidos>; overload;
      function Update(SQL: string): iModelDAOEntity<TPedidos>; overload;
      function Insert: iModelDAOEntity<TPedidos>;
      function DataSet(DataSource: TDataSource): iModelDAOEntity<TPedidos>;
      function NextId: Integer;
      function This: TPedidos;

  end;

implementation

uses
  System.SysUtils;

  { TModelDAOPedido }

function TModelDAOPedido.Update: iModelDAOEntity<TPedidos>;
begin
  Result := Self;
  try
    FConnection
      .StartTransaction
      .SQL('update pedidos set dataemissao=:data, codigocliente=:idcliente, valortotal=:total where numeropedido=:id')
      .Params('data', FormatDateTime('yyyy-mm-dd', FPedidos.DataEmissao))
      .Params('idcliente', FPedidos.CodigoCliente)
      .Params('total', FPedidos.ValorTotal)
      .Params('id', FPedidos.NumeroPedido)
      .ExecSQl
      .Commit;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar atualizar o registro: ' + e.ToString);
  end;
end;

constructor TModelDAOPedido.Create;
begin
  FConnection  :=  TModelConnectionMySQL.New;
  FPedidos  :=  TPedidos.Create(Self)
end;

function TModelDAOPedido.DataSet(DataSource: TDataSource): iModelDAOEntity<TPedidos>;
begin
  Result  :=  Self;
  if not Assigned(FDataSet) then
    DataSource.DataSet  :=  FConnection.DataSet
  else
    DataSource.DataSet  :=  FDataSet;
end;

function TModelDAOPedido.Delete(SQL: string): iModelDAOEntity<TPedidos>;
begin
  Result := Self;
  try
    FConnection
      .SQL(SQL)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar excluir o registro: ' + e.ToString);
  end;
end;

destructor TModelDAOPedido.Destroy;
begin
  FPedidos.DisposeOf;
  inherited;
end;

function TModelDAOPedido.Delete: iModelDAOEntity<TPedidos>;
begin
  Result := Self;
  try
    FConnection
      .StartTransaction
      .SQL('delete from pedidos where numeropedido=:id')
      .Params('id', FPedidos.NumeroPedido)
      .ExecSQl
      .Commit;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar excluir o registro: ' + e.ToString);
  end;
end;

function TModelDAOPedido.Insert: iModelDAOEntity<TPedidos>;
begin
  Result := Self;
  try
    FConnection
      .StartTransaction
      .SQL('insert into pedidos (dataemissao, codigocliente, valortotal) values (:data, :idcliente, :total)')
      .Params('data', FormatDateTime('yyyy-mm-dd', FPedidos.DataEmissao))
      .Params('idcliente', FPedidos.CodigoCliente)
      .Params('total', FPedidos.ValorTotal)
      .ExecSQL
      .Commit;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar inserir o registro: ' + e.ToString);
  end;
end;

function TModelDAOPedido.NextId: Integer;
begin
  FDataSet := FConnection
    .SQL('select max(numeropedido) as numeropedido from pedidos')
    .Open
    .DataSet;

  Result := FDataSet.Fields[0].AsInteger + 1;
end;

function TModelDAOPedido.List(SQL: string): iModelDAOEntity<TPedidos>;
begin
  Result := Self;
  FDataSet :=
    FConnection
      .SQL(SQL)
      .Open
      .DataSet;
end;

function TModelDAOPedido.List: iModelDAOEntity<TPedidos>;
begin
  Result  :=  Self;
  FDataSet  :=
    FConnection
      .SQL('select * from pedidos')
      .Open
      .DataSet;
end;

function TModelDAOPedido.List(Id: Integer): iModelDAOEntity<TPedidos>;
begin
  Result  :=  Self;
  FDataSet  :=
    FConnection
      .SQL('select * from pedidos where numeropedido=:id')
      .Params('id', Id)
      .Open
      .DataSet;
end;

class function TModelDAOPedido.New: iModelDAOEntity<TPedidos>;
begin
  Result  :=  Self.Create;
end;

function TModelDAOPedido.This: TPedidos;
begin
  Result  :=  FPedidos;
end;

function TModelDAOPedido.Update(SQL: string): iModelDAOEntity<TPedidos>;
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
