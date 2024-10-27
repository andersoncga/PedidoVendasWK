unit PVWk.Model.DAO.Clientes;

interface
uses
  Data.DB,
  PVWK.Model.Entities.Clientes,
  PVWk.Model.DAO.Interfaces,
  PVWk.Model.Connection.Interfaces,
  PVWk.Model.Connection.MySQL;
type
  TModelDAOCliente = class(TInterfacedObject, iModelDAOEntity<TClientes>)
    private
      FClientes: TClientes;
      FConnection: iConnection;
      FDataSet: TDataSet;
    public
      constructor Create;
      destructor  Destroy; override;
      class function New: iModelDAOEntity<TClientes>;
      function List : iModelDAOEntity<TClientes>; overload;
      function List(Codigo: Integer): iModelDAOEntity<TClientes>; overload;
      function List(SQL: string): iModelDAOEntity<TClientes>; overload;
      function Delete: iModelDAOEntity<TClientes>; overload;
      function Delete(SQL: string): iModelDAOEntity<TClientes>; overload;
      function Update: iModelDAOEntity<TClientes>; overload;
      function Update(SQL: string): iModelDAOEntity<TClientes>; overload;
      function Insert: iModelDAOEntity<TClientes>;
      function DataSet(DataSource: TDataSource):  iModelDAOEntity<TClientes>;
      function NextId: Integer;
      function This: TClientes;
  end;

implementation

uses
  System.SysUtils;

  { TModelDAOCliente }

function TModelDAOCliente.Update: iModelDAOEntity<TClientes>;
begin
  Result := Self;
  try
    FConnection
      .SQL('update clientes set nome=:nome, cidade=:cidade, uf=:uf where codigo=:codigo')
      .Params('nome', FClientes.Nome)
      .Params('cidade', FClientes.Cidade)
      .Params('uf', FClientes.Uf)
      .Params('codigo', FClientes.Codigo)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar atualizar o registro: ' + e.ToString);
  end;
end;

constructor TModelDAOCliente.Create;
begin
  FConnection  :=  TModelConnectionMySQL.New;
  FClientes :=  TClientes.Create(Self)
end;

function TModelDAOCliente.DataSet(DataSource: TDataSource): iModelDAOEntity<TClientes>;
begin
  Result  :=  Self;
  if not Assigned(FDataSet) then
    DataSource.DataSet  :=  FConnection.DataSet
  else
    DataSource.DataSet  :=  FDataSet;
end;

function TModelDAOCliente.Delete(SQL: string): iModelDAOEntity<TClientes>;
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

destructor TModelDAOCliente.Destroy;
begin
  FClientes.DisposeOf;
  inherited;
end;

function TModelDAOCliente.Delete: iModelDAOEntity<TClientes>;
begin
  Result := Self;
  try
    FConnection
      .SQL('delete from clientes where codigo=:codigo')
      .Params('codigo', FClientes.Codigo)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar excluir o registro: ' + e.ToString);
  end;
end;

function TModelDAOCliente.Insert: iModelDAOEntity<TClientes>;
begin
  Result := Self;
  try
    FConnection
      .SQL('insert into clientes (nome, cidade, uf) values (:nome, :cidade, :uf)')
      .Params('nome', FClientes.Nome)
      .Params('cidade', FClientes.Cidade)
      .Params('uf', FClientes.Uf)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar inserir o registro: ' + e.ToString);
  end;
end;

function TModelDAOCliente.List(SQL: string): iModelDAOEntity<TClientes>;
begin
  Result := Self;
  FDataSet :=
    FConnection
      .SQL(SQL)
      .Open
      .DataSet;
end;

function TModelDAOCliente.List: iModelDAOEntity<TClientes>;
begin
  Result  :=  Self;
  FDataSet  :=
    FConnection
      .SQL('select * from clientes')
      .Open
      .DataSet;
end;
function TModelDAOCliente.List(Codigo: Integer): iModelDAOEntity<TClientes>;
begin
  Result  :=  Self;
  FDataSet  :=
    FConnection
      .SQL('select * from clientes where codigo=:codigo')
      .Params('codigo', Codigo)
      .Open
      .DataSet;
end;

class function TModelDAOCliente.New: iModelDAOEntity<TClientes>;
begin
  Result  :=  Self.Create;
end;

function TModelDAOCliente.NextId: Integer;
begin
  FDataSet := FConnection
    .SQL('select max(codigo) as codigo from clientes')
    .Open
    .DataSet;

  Result := FDataSet.Fields[0].AsInteger + 1;
end;

function TModelDAOCliente.This: TClientes;
begin
  Result  :=  FClientes;
end;

function TModelDAOCliente.Update(SQL: string): iModelDAOEntity<TClientes>;
begin
  Result := Self;
  try
    FConnection
      .SQL(SQL)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar atualizar o registro: ' + e.ToString);
  end;
end;

end.
