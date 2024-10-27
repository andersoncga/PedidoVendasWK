unit PVWK.Helper.MemTable;

interface

uses
  FireDAC.Comp.Client,
  Data.DB;

type
  TOpPedido = (opInsert, opEdit, opNil);
  TOpItem = (oiInsert, oiEdit, oiNil);

  THelperMemTable = class
    private
      FCodigoItem,
      FNumeroPedido,
      FCodigoProduto: Integer;
      FDescricao: string;
      FQuantidade: Integer;
      FValorUnitario,
      FValorTotal: Currency;
      FOpPedido: TOpPedido;

    public
      FMemTable: TFDMemTable;
      FDSMemTable: TDataSource;
      FOpItem: TOpItem;

      constructor Create;
      destructor Destroy; override;
      class function New: THelperMemTable;
      procedure CreateFields;
      function CodigoItem(Value: Integer): THelperMemTable; overload;
      function CodigoItem: Integer; overload;
      function NumeroPedido(Value: Integer): THelperMemTable; overload;
      function NumeroPedido: Integer; overload;
      function CodigoProduto(Value: Integer): THelperMemTable; overload;
      function CodigoProduto: Integer; overload;
      function Descricao(Value: string): THelperMemTable; overload;
      function Descricao: string; overload;
      function Quantidade(Value: Integer): THelperMemTable; overload;
      function Quantidade: Integer; overload;
      function ValorUnitario(Value: Currency): THelperMemTable; overload;
      function ValorUnitario: Currency; overload;
      function ValorTotal(Value: Currency): THelperMemTable; overload;
      function ValorTotal: Currency; overload;
      procedure Save;
      procedure Delete(Value: Integer);
      function TotalItens: Currency;
      function OpPedido(Value: TOpPedido): THelperMemTable;

  end;
implementation

{ THelperMemTable }

constructor THelperMemTable.Create;
begin
  FMemTable := TFDMemTable.Create(nil);
  FDSMemTable  := TDataSource.Create(nil);
  FDSMemTable.DataSet := FMemTable;
  FOpItem := oiInsert;
  CreateFields;
end;

destructor THelperMemTable.Destroy;
begin
  FDSMemTable.DisposeOf;
  FMemTable.DisposeOf;

  inherited;
end;

class function THelperMemTable.New: THelperMemTable;
begin
  Result := Self.Create;
end;

function THelperMemTable.CodigoItem: Integer;
begin
  Result :=  FCodigoItem;
end;

function THelperMemTable.CodigoItem(Value: Integer): THelperMemTable;
begin
  Result :=  Self;
  FCodigoItem := Value;
end;

function THelperMemTable.CodigoProduto(Value: Integer): THelperMemTable;
begin
  Result := Self;
  FCodigoProduto := Value;
end;

function THelperMemTable.CodigoProduto: Integer;
begin
  Result := FCodigoProduto;
end;

procedure THelperMemTable.Delete(Value: Integer);
begin
  if FMemTable.Locate('codigoitem', Value) then
    FMemTable.Delete;
end;

function THelperMemTable.Descricao: string;
begin
  Result := FDescricao;
end;

function THelperMemTable.Descricao(Value: string): THelperMemTable;
begin
  Result := Self;
  FDescricao := Value;
end;

function THelperMemTable.NumeroPedido: Integer;
begin
  Result := FNumeroPedido;
end;

function THelperMemTable.OpPedido(Value: TOpPedido): THelperMemTable;
begin
  Result := Self;
  FOpPedido := Value;
end;

function THelperMemTable.NumeroPedido(Value: Integer): THelperMemTable;
begin
  Result := Self;
  FNumeroPedido := Value;
end;

function THelperMemTable.Quantidade(Value: Integer): THelperMemTable;
begin
  Result := Self;
  FQuantidade := Value;
end;

function THelperMemTable.Quantidade: Integer;
begin
  Result := FQuantidade;
end;

function THelperMemTable.ValorTotal(Value: Currency): THelperMemTable;
begin
  Result := Self;
  FValorTotal := Value;
end;

function THelperMemTable.ValorTotal: Currency;
begin
  Result := FValorTotal;
end;

function THelperMemTable.ValorUnitario(Value: Currency): THelperMemTable;
begin
  Result := Self;
  FValorUnitario := Value;
end;

function THelperMemTable.ValorUnitario: Currency;
begin
  Result := FValorUnitario;
end;

procedure THelperMemTable.CreateFields;
begin
  FMemTable.FieldDefs.Add('codigoitem', ftInteger);
  FMemTable.FieldDefs.Add('numeropedido', ftInteger);
  FMemTable.FieldDefs.Add('codigoproduto', ftInteger);
  FMemTable.FieldDefs.Add('descricao', ftString, 50);
  FMemTable.FieldDefs.Add('quantidade', ftInteger);
  FMemTable.FieldDefs.Add('valorunitario', ftBCD);
  FMemTable.FieldDefs.Add('valortotal', ftBCD);

//  with TAggregateField.Create(nil) do
//  begin
//    FieldName := 'totalitem';
//    Expression := 'sum(valortotal)';
//    IndexName := 'by_total';
//    GroupingLevel := 0;
//    Active := True;
//    Visible := True;
//    Name := 'totalitem';
//    DataSet := FMemTable;
//  end;

  FMemTable.CreateDataSet;
end;

procedure THelperMemTable.Save;
begin
  if ((FOpPedido = opInsert) or (FOpPedido = opEdit)) and (FOpItem = oiInsert) then
  begin
     FMemTable.Append;
     FCodigoItem := FCodigoItem  * (-1);
  end
  else
  begin
    FMemTable.Locate('codigoitem', FCodigoItem);
    FMemTable.Edit;
  end;

  FMemTable.FieldByName('codigoitem').AsInteger := FCodigoItem;
  FMemTable.FieldByName('numeropedido').AsInteger := FNumeroPedido;
  FMemTable.FieldByName('codigoproduto').AsInteger:= FCodigoProduto;
  FMemTable.FieldByName('descricao').AsString := FDescricao;
  FMemTable.FieldByName('quantidade').AsInteger := FQuantidade;
  FMemTable.FieldByName('valorunitario').AsCurrency := FValorUnitario;
  FMemTable.FieldByName('valortotal').AsCurrency := FValorTotal;

  FMemTable.Post;
end;

function THelperMemTable.TotalItens: Currency;
begin
  Result := 0;
  FMemTable.First;
  while not FMemTable.Eof do
  begin
    Result := Result + FMemTable.FieldByName('valortotal').AsCurrency;

    FMemTable.Next;
  end;
end;

end.
