unit PVWK.Model.DAO.Produtos;

interface
uses
  Data.DB,
  PVWK.Model.Entities.Produtos,
  PVWK.Model.DAO.Interfaces,
  PVWK.Model.Connection.Interfaces,
  PVWK.Model.Connection.MySQL;
type
  TModelDAOProduto = class(TInterfacedObject, iModelDAOEntity<TProdutos>)
    private
      FProdutos: TProdutos;
      FConnection: iConnection;
      FDataSet: TDataSet;
    public
      constructor Create;
      destructor  Destroy; override;
      class function New: iModelDAOEntity<TProdutos>;
      function List: iModelDAOEntity<TProdutos>; overload;
      function List(Id: Integer): iModelDAOEntity<TProdutos>; overload;
      function List(SQL: string): iModelDAOEntity<TProdutos>; overload;
      function Delete: iModelDAOEntity<TProdutos>; overload;
      function Delete(SQL: string): iModelDAOEntity<TProdutos>; overload;
      function Update: iModelDAOEntity<TProdutos>; overload;
      function Update(SQL: string): iModelDAOEntity<TProdutos>; overload;
      function Insert: iModelDAOEntity<TProdutos>;
      function DataSet(DataSource: TDataSource):  iModelDAOEntity<TProdutos>;
      function NextId: Integer;
      function This: TProdutos;
  end;

implementation

uses
  System.SysUtils;

{ TModelDAOProduto }

function TModelDAOProduto.Update: iModelDAOEntity<TProdutos>;
begin
  Result := Self;
  try
    FConnection
      .SQL('update produtos set descricao=:descricao, preco_venda=:preco where codigo=:id')
      .Params('descricao', FProdutos.Descricao)
      .Params('preco', FProdutos.PrecoVenda)
      .Params('id', FProdutos.Codigo)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar atualizar o registro: ' + e.ToString);
  end;
end;

constructor TModelDAOProduto.Create;
begin
  FConnection  :=  TModelConnectionMySQL.New;
  FProdutos :=  TProdutos.Create(Self)
end;

function TModelDAOProduto.DataSet(DataSource: TDataSource): iModelDAOEntity<TProdutos>;
begin
  Result  :=  Self;
  if not Assigned(FDataSet) then
    DataSource.DataSet  :=  FConnection.DataSet
  else
    DataSource.DataSet  :=  FDataSet;
end;

function TModelDAOProduto.Delete(SQL: string): iModelDAOEntity<TProdutos>;
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

destructor TModelDAOProduto.Destroy;
begin
  FProdutos.DisposeOf;
  inherited;
end;

function TModelDAOProduto.Delete: iModelDAOEntity<TProdutos>;
begin
  Result := Self;
  try
    FConnection
      .SQL('delete from produtos where codigo=:id')
      .Params('id', FProdutos.Codigo)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar excluir o registro: ' + e.ToString);
  end;
end;

function TModelDAOProduto.Insert: iModelDAOEntity<TProdutos>;
begin
  Result := Self;
  try
    FConnection
      .SQL('insert into produtos (descricao, precovenda) values (:descricao, :precovenda)')
      .Params('descricao', FProdutos.Descricao)
      .Params('precovenda', FProdutos.PrecoVenda)
      .ExecSQl;
  except on e: Exception do
    raise Exception.Create('Erro ao tentar inserir o registro: ' + e.ToString);
  end;
end;

function TModelDAOProduto.List(SQL: string): iModelDAOEntity<TProdutos>;
begin
  Result := Self;
  FDataSet :=
    FConnection
      .SQL(SQL)
      .Open
      .DataSet;
end;

function TModelDAOProduto.List: iModelDAOEntity<TProdutos>;
begin
  Result  :=  Self;
  FDataSet  :=
    FConnection
      .SQL('select * from produtos')
      .Open
      .DataSet;
end;

function TModelDAOProduto.List(Id: Integer): iModelDAOEntity<TProdutos>;
begin
  Result  :=  Self;
  FDataSet  :=
    FConnection
      .SQL('select * from produtos where codigo=:id')
      .Params('id', Id)
      .Open
      .DataSet;
end;

class function TModelDAOProduto.New: iModelDAOEntity<TProdutos>;
begin
  Result  :=  Self.Create;
end;

function TModelDAOProduto.NextId: Integer;
begin
  FDataSet := FConnection
    .SQL('select max(codigo) as codigo from produtos')
    .Open
    .DataSet;

  Result := FDataSet.Fields[0].AsInteger + 1;
end;

function TModelDAOProduto.This: TProdutos;
begin
  Result  :=  FProdutos;
end;

function TModelDAOProduto.Update(SQL: string): iModelDAOEntity<TProdutos>;
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
