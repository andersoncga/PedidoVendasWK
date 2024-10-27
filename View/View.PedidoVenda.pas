unit View.PedidoVenda;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.StdCtrls,
  Vcl.Buttons,
  Vcl.ComCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,

  PVWK.Model.Connection.Interfaces,
  PVWK.Controller.Interfaces,
  PVWK.Controller,
  PVWK.Helper.MemTable;

type
  TViewPedidoVenda = class(TForm)
    pnlFundo: TPanel;
    gbxPedido: TGroupBox;
    gbxItens: TGroupBox;
    gbxTotais: TGroupBox;
    edtNumeroPedido: TEdit;
    lblNumeroPedido: TLabel;
    dtpDataEmissao: TDateTimePicker;
    lblDataEmissao: TLabel;
    edtNomeCliente: TEdit;
    lblNomeCliente: TLabel;
    btnBucaPedido: TBitBtn;
    btnBuscaCliente: TBitBtn;
    dbgItens: TDBGrid;
    edtCodigoProduto: TEdit;
    lblProduto: TLabel;
    edtDescricaoProduto: TEdit;
    lblDescricaoProduto: TLabel;
    btnBuscaProdutos: TBitBtn;
    edtQuantidade: TEdit;
    lblQuantidade: TLabel;
    edtValorUnitario: TEdit;
    lblValorUnitario: TLabel;
    edtValorTotal: TEdit;
    lblValorTotal: TLabel;
    btnGravarItem: TBitBtn;
    GroupBox1: TGroupBox;
    btnAcaoPedido: TBitBtn;
    edtCodigoCliente: TEdit;
    btnGravaPedido: TBitBtn;
    btnCancelar: TBitBtn;
    lblTotalPedido: TLabel;
    edtTotalPedido: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure btnBucaPedidoClick(Sender: TObject);
    procedure btnBuscaClienteClick(Sender: TObject);
    procedure btnBuscaProdutosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnGravarItemClick(Sender: TObject);
    procedure btnAcaoPedidoClick(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure edtQuantidadeExit(Sender: TObject);
    procedure edtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtValorUnitarioExit(Sender: TObject);
    procedure btnGravaPedidoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure dbgItensKeyPress(Sender: TObject; var Key: Char);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtNumeroPedidoExit(Sender: TObject);
    procedure dbgItensDblClick(Sender: TObject);
  private
    FPedido,
    FItem: Integer;
    FOpPedido: TOpPedido;

    FDSTemp: TDataSource;
    FController: iController;
    FMTItens: THelperMemTable;

    procedure GetProduto(Value: Integer);
    function ValidateItem: Boolean;
    procedure SaveItem;
    procedure ClearFieldsItem;
    procedure NewOrder;
    procedure SetEnableFields;
    procedure GetCliente(Value: Integer);
    procedure CalculateTotalItem;
    procedure ShowTotais;
    function ValidateOrder: Boolean;
    procedure SaveOrder;
    procedure InsertOrder;
    procedure UpdateOrder;
    procedure ClearOrder;
    procedure DeleteItem;
    procedure EditItem;
    procedure ListItens;
    procedure DeleteOrder;
    procedure ClearFieldsPedido;

  public

  end;

var
  ViewPedidoVenda: TViewPedidoVenda;

implementation

uses
  System.UITypes,
  View.BuscaPedido,
  View.BuscaCliente,
  View.BuscaProduto,
  PVWK.Helper.Edit,
  FireDAC.Comp.DataSet;

{$R *.dfm}

procedure TViewPedidoVenda.FormCreate(Sender: TObject);
begin
  FOpPedido := opNil;

  FMTItens := THelperMemTable.New;

  FDSTemp := TDataSource.Create(Self);

  dbgItens.DataSource := FMTItens.FDSMemTable;

  FController := TController.New;

  ShowTotais;
end;

procedure TViewPedidoVenda.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN:  begin
                  Key := 0;
                  Perform(WM_NEXTDLGCTL,0,0);
                end;
  end;
end;

procedure TViewPedidoVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FMTItens.DisposeOf;
end;

procedure TViewPedidoVenda.btnAcaoPedidoClick(Sender: TObject);
begin
  case FOpPedido of
    opEdit: DeleteOrder;
    opNil: NewOrder;
  end;
end;

procedure TViewPedidoVenda.NewOrder;
begin
  FOpPedido := opInsert;

  FPedido := FController.Entity.Pedidos.NextId;
  FItem := FController.Entity.ProdutosPedidos.NextId;

  ClearFieldsPedido;
  edtNumeroPedido.Text := IntToStr(FPedido);

  ClearFieldsItem;
  SetEnableFields;

  dtpDataEmissao.SetFocus;
end;

procedure TViewPedidoVenda.DeleteOrder;
begin
  if MessageDlg('Você tem certeza que deseja excluir o pedido?',
                mtConfirmation, [mbyes, mbno], 0) = mryes then
  begin
    try
      FController
        .Entity
        .ProdutosPedidos
        .Delete('delete from produtospedidos where numeropedido = ' + IntToStr(FPedido));

      FController
        .Entity
        .Pedidos
        .This
          .NumeroPedido(FPedido)
        .&End
        .Delete;

      btnCancelar.Click;
    except on E: Exception do
      raise Exception.Create('Erro ao excluir pedido: ' + E.Message);
    end;
  end;
end;

procedure TViewPedidoVenda.SetEnableFields;
begin
  dtpDataEmissao.Enabled := not dtpDataEmissao.Enabled;
  edtCodigoCliente.Enabled := not edtCodigoCliente.Enabled;

  btnBucaPedido.Enabled := not btnBucaPedido.Enabled;
  btnGravaPedido.Enabled := not btnGravaPedido.Enabled;
  btnCancelar.Enabled := not btnCancelar.Enabled;
  btnBuscaCliente.Enabled := not btnBuscaCliente.Enabled;
  gbxItens.Enabled := not gbxItens.Enabled;

  case FOpPedido of
    opInsert: begin btnAcaoPedido.Caption := 'Novo Pedido'; btnAcaoPedido.Enabled := False; end;
    opEdit: begin btnAcaoPedido.Caption := 'Excluir Pedido'; btnAcaoPedido.Enabled := True; end;
    opNil: begin btnAcaoPedido.Caption := 'Novo Pedido'; btnAcaoPedido.Enabled := True; end;
  end;
end;

procedure TViewPedidoVenda.btnBucaPedidoClick(Sender: TObject);
var
  LBuscaPedido: TViewBuscaPedido;
begin
  LBuscaPedido := TViewBuscaPedido.Create(nil);
  try
    LBuscaPedido.ShowModal;

    edtNumeroPedido.Text := LBuscaPedido.FNumeroPedido;
    if not edtNumeroPedido.IsEmpty then
    begin
      FPedido := edtNumeroPedido.ToInt;
      FOpPedido := opEdit;
      SetEnableFields;
      edtNumeroPedidoExit(nil);
    end;

  finally
    LBuscaPedido.DisposeOf;
  end;
end;

procedure TViewPedidoVenda.btnBuscaClienteClick(Sender: TObject);
var
  LBuscaCliente: TViewBuscaCliente;
begin
  LBuscaCliente := TViewBuscaCliente.Create(nil);
  try
    LBuscaCliente.ShowModal;

    edtCodigoCliente.Text := LBuscaCliente.FCodigo;
    if not edtCodigoCliente.IsEmpty then
      edtCodigoClienteExit(nil);

  finally
    LBuscaCliente.DisposeOf;
  end;
end;

procedure TViewPedidoVenda.btnBuscaProdutosClick(Sender: TObject);
var
  LBuscaProduto: TViewBuscaProduto;
begin
  LBuscaProduto := TViewBuscaProduto.Create(nil);
  try
    LBuscaProduto.ShowModal;

    edtCodigoProduto.Text := LBuscaProduto.FCodigo;
    if not edtCodigoProduto.IsEmpty then
      edtCodigoProdutoExit(nil);

  finally
    LBuscaProduto.DisposeOf;
  end;
end;

procedure TViewPedidoVenda.btnCancelarClick(Sender: TObject);
begin
  ClearOrder;
end;

procedure TViewPedidoVenda.btnGravaPedidoClick(Sender: TObject);
begin
  if not ValidateOrder then
    exit;

  SaveOrder;
end;

function TViewPedidoVenda.ValidateOrder: Boolean;
var
  LMsg: string;
begin
  LMsg := 'Encontrei o(s) seguinte(s) erro(s): ';
  Result := True;
  if edtCodigoCliente.IsEmpty then
  begin
    Result := False;
    LMsg := LMsg + sLineBreak + ' - Código do Cliente não informado.';
  end;

  if dtpDataEmissao.Date = 0 then
  begin
    Result := False;
    LMsg := LMsg + sLineBreak + ' - Data de Emissão não informada.';
  end;

  if FMTItens.FMemTable.IsEmpty then
  begin
    Result := False;
    LMsg := LMsg + sLineBreak + ' - Produto não informado.';
  end;

  if not Result then
    ShowMessage(LMsg);
end;

procedure TViewPedidoVenda.SaveOrder;
begin
  case FOpPedido of
    opInsert: InsertOrder;
    opEdit: UpdateOrder;
  end;

  ClearOrder;

  ShowMessage('Pedido gravado com sucesso!!');
end;

procedure TViewPedidoVenda.ClearOrder;
begin
  FOpPedido := opNil;
  FMTItens.FOpItem := oiInsert;
  FMTItens.FMemTable.EmptyDataSet;
  dbgItens.DataSource.DataSet.Close;
  dbgItens.DataSource.DataSet.Open;

  ClearFieldsPedido;
  ClearFieldsItem;
  SetEnableFields;
  ShowTotais;
end;

procedure TViewPedidoVenda.ClearFieldsPedido;
begin
  edtNumeroPedido.Clear;
  edtCodigoCliente.Clear;
  edtNomeCliente.Clear;
  dtpDataEmissao.Date := Date;
end;

procedure TViewPedidoVenda.dbgItensDblClick(Sender: TObject);
begin
  EditItem;
end;

procedure TViewPedidoVenda.dbgItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if FMTItens.FMemTable.IsEmpty then
    exit;

  if (Key = VK_DELETE) then
    DeleteItem;
end;

procedure TViewPedidoVenda.dbgItensKeyPress(Sender: TObject; var Key: Char);
begin
  if FMTItens.FMemTable.IsEmpty then
    exit;

  if (Key = #13) then
    EditItem;
end;

procedure TViewPedidoVenda.EditItem;
begin
  edtCodigoProduto.Text := FMTItens.FMemTable.FieldByName('codigoproduto').AsString;
  edtDescricaoProduto.Text := FMTItens.FMemTable.FieldByName('descricao').AsString;
  edtQuantidade.Text := FMTItens.FMemTable.FieldByName('quantidade').AsString;
  edtValorUnitario.Text := FormatFloat('0.00', FMTItens.FMemTable.FieldByName('valorunitario').AsFloat);
  edtValorTotal.Text := FormatFloat('0.00', FMTItens.FMemTable.FieldByName('valortotal').AsFloat);
  FItem := FMTItens.FMemTable.FieldByName('codigoitem').AsInteger;
  FMTItens.FOpItem := oiEdit;
  edtQuantidade.SetFocus;
end;

procedure TViewPedidoVenda.DeleteItem;
var
  LTotal: string;
begin
  if MessageDlg('Você tem certeza que deseja excluir o item?',
                mtConfirmation, [mbyes, mbno], 0) = mryes then
  begin
    try
      if (FOpPedido = opEdit) then
      begin
        FController
          .Entity
          .ProdutosPedidos
            .This
              .CodigoItem(FMTItens.FMemTable.FieldByName('codigoitem').AsInteger)
            .&End
          .Delete;

        LTotal := edtTotalPedido.Text;
        LTotal := LTotal.Replace('.', '').Replace(',','.');

        FController
          .Entity
          .Pedidos
          .Update('update pedidos set valortotal = ' + LTotal +
                 ' where numeropedido = ' + IntToStr(FPedido));
      end;

      FMTItens
        .Delete(FMTItens.FMemTable.FieldByName('codigoitem').AsInteger);

      ListItens;
    except on E: Exception do
      raise Exception.Create('Erro ao excluir item do pedido: ' + E.Message);
    end;
  end;
end;

procedure TViewPedidoVenda.InsertOrder;
begin
  try
    FController
      .Entity
      .Pedidos
      .This
        .DataEmissao(dtpDataEmissao.Date)
        .CodigoCliente(edtCodigoCliente.ToInt)
        .ValorTotal(edtTotalPedido.ToCurr)
      .&End
      .Insert;

    FMTItens.FMemTable.First;
    while not FMTItens.FMemTable.Eof do
    begin
      FController
        .Entity
        .ProdutosPedidos
        .This
          .NumeroPedido(FPedido)
          .CodigoProduto(FMTItens.FMemTable.FieldByName('codigoproduto').AsInteger)
          .Quantidade(FMTItens.FMemTable.FieldByName('quantidade').AsInteger)
          .ValorUnitario(FMTItens.FMemTable.FieldByName('valorunitario').AsCurrency)
          .ValorTotal(FMTItens.FMemTable.FieldByName('valortotal').AsCurrency)
        .&End
        .Insert;

      FMTItens.FMemTable.Next;
    end;
  except on E: Exception do
    raise Exception.Create('Erro ao gravar: ' + E.Message);
  end;
end;

procedure TViewPedidoVenda.UpdateOrder;
begin
  try
    FController
      .Entity
      .Pedidos
      .This
        .NumeroPedido(FPedido)
        .DataEmissao(dtpDataEmissao.Date)
        .CodigoCliente(edtCodigoCliente.ToInt)
        .ValorTotal(edtTotalPedido.ToCurr)
      .&End
      .Update;

    FMTItens.FMemTable.First;
    while not FMTItens.FMemTable.Eof do
    begin
      if FMTItens.FMemTable.FieldByName('codigoitem').AsInteger > 0 then
      begin
        FController
          .Entity
          .ProdutosPedidos
          .This
            .CodigoItem(FMTItens.FMemTable.FieldByName('codigoitem').AsInteger)
            .NumeroPedido(FMTItens.FMemTable.FieldByName('numeropedido').AsInteger)
            .CodigoProduto(FMTItens.FMemTable.FieldByName('codigoproduto').AsInteger)
            .Quantidade(FMTItens.FMemTable.FieldByName('quantidade').AsInteger)
            .ValorUnitario(FMTItens.FMemTable.FieldByName('valorunitario').AsCurrency)
            .ValorTotal(FMTItens.FMemTable.FieldByName('valortotal').AsCurrency)
          .&End
          .Update;
      end
      else
      begin
        FController
          .Entity
          .ProdutosPedidos
          .This
            .NumeroPedido(FMTItens.FMemTable.FieldByName('numeropedido').AsInteger)
            .CodigoProduto(FMTItens.FMemTable.FieldByName('codigoproduto').AsInteger)
            .Quantidade(FMTItens.FMemTable.FieldByName('quantidade').AsInteger)
            .ValorUnitario(FMTItens.FMemTable.FieldByName('valorunitario').AsCurrency)
            .ValorTotal(FMTItens.FMemTable.FieldByName('valortotal').AsCurrency)
          .&End
          .Insert;
      end;

      FMTItens.FMemTable.Next;
    end;
  except on E: Exception do
    raise Exception.Create('Erro ao gravar: ' + E.Message);
  end;
end;

procedure TViewPedidoVenda.btnGravarItemClick(Sender: TObject);
begin
  if not ValidateItem then
    exit;

   SaveItem;
end;

function TViewPedidoVenda.ValidateItem: Boolean;
var
  LMsg: string;
begin
  LMsg := 'Encontrei o(s) seguinte(s) erro(s): ';
  Result := True;
  if edtCodigoProduto.IsEmpty then
  begin
    Result := False;
    LMsg := LMsg + sLineBreak + ' - Código do Produto não informado.';
  end;

  if (edtQuantidade.IsEmpty) or (edtQuantidade.Text = '0') then
  begin
    Result := False;
    LMsg := LMsg + sLineBreak + ' - Quantidade do Produto não informada.';
  end;

  if (edtValorUnitario.IsEmpty) or ((edtValorUnitario.Text = '0') or (edtValorUnitario.Text = '0,00')) then
  begin
    Result := False;
    LMsg := LMsg + sLineBreak + ' - Valor Unitário do Produto não informado.';
  end;

  if (edtValorTotal.IsEmpty) or ((edtValorTotal .Text = '0') or (edtValorTotal.Text = '0,00')) then
  begin
    Result := False;
    LMsg := LMsg + sLineBreak + ' - Valor Total do Produto não informado.';
  end;

  if not Result then
    ShowMessage(LMsg);
end;

procedure TViewPedidoVenda.SaveItem;
begin
  FMTItens
    .CodigoItem(FItem)
    .NumeroPedido(FPedido)
    .CodigoProduto(edtCodigoProduto.ToInt)
    .Descricao(edtDescricaoProduto.Text)
    .Quantidade(edtQuantidade.ToInt)
    .ValorUnitario(edtValorUnitario.ToCurr)
    .ValorTotal(edtValorTotal.ToCurr)
    .OpPedido(FOpPedido)
  .Save;

  Inc(FItem);

  ClearFieldsItem;
  edtCodigoProduto.SetFocus;
  ShowTotais;
end;

procedure TViewPedidoVenda.ClearFieldsItem;
begin
  edtCodigoProduto.Clear;
  edtDescricaoProduto.Clear;
  edtQuantidade.Text := '1';
  edtValorUnitario.Text := '0,00';
  edtValorTotal.Text := '0,00';
end;

procedure TViewPedidoVenda.edtCodigoClienteExit(Sender: TObject);
begin
  if not edtCodigoCliente.IsEmpty then
    GetCliente(edtCodigoCliente.ToInt);
end;

procedure TViewPedidoVenda.GetCliente(Value: Integer);
begin
  edtNomeCliente.Clear;

  FController
    .Entity
    .Clientes
    .List(Value)
    .DataSet(FDSTemp);

  if not FDSTemp.DataSet.IsEmpty then
  begin
    edtNomeCliente.Text := FDSTemp.DataSet.FieldByName('nome').AsString;

    edtCodigoProduto.SetFocus;
  end
  else
  begin
    ShowMessage('Cliente não encontrado!');

    edtCodigoCliente.Clear;
    edtCodigoCliente.SetFocus;
  end;
end;

procedure TViewPedidoVenda.edtCodigoProdutoExit(Sender: TObject);
begin
  if not edtCodigoProduto.IsEmpty then
    GetProduto(edtCodigoProduto.ToInt);
end;

procedure TViewPedidoVenda.edtNumeroPedidoExit(Sender: TObject);
begin
  FController
    .Entity
    .Pedidos
    .List(edtNumeroPedido.ToInt)
    .DataSet(FDSTemp);

  dtpDataEmissao.Date := FDSTemp.DataSet.FieldByName('dataemissao').AsDateTime;
  edtCodigoCliente.Text := FDSTemp.DataSet.FieldByName('codigocliente').AsString;
  edtCodigoClienteExit(nil);

  ListItens;
end;

procedure TViewPedidoVenda.ListItens;
begin
  FMTItens.FMemTable.EmptyDataSet;
  FController
    .Entity
    .ProdutosPedidos
    .List('select pp.codigoitem, pp.numeropedido, pp.codigoproduto, p.descricao, '+
          'pp.quantidade, pp.valorunitario, pp.valortotal ' +
          'from produtospedidos pp ' +
          'join produtos p on p.codigo = pp.codigoproduto ' +
          'where pp.numeropedido = ' + Trim(edtNumeroPedido.Text))
    .DataSet(FDSTemp);

  FMTItens.FMemTable.CopyDataSet(FDSTemp.DataSet, [coRestart, coAppend]) ;
  FMTItens.FMemTable.Last;
  FItem := FMTItens.FMemTable.FieldByName('codigoitem').AsInteger + 1;

  ShowTotais;
end;

procedure TViewPedidoVenda.edtQuantidadeExit(Sender: TObject);
begin
  CalculateTotalItem;
end;

procedure TViewPedidoVenda.edtValorUnitarioExit(Sender: TObject);
begin
  CalculateTotalItem;
end;

procedure TViewPedidoVenda.edtValorUnitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (CharInSet(Key,['0'..'9','.',','])) then
    Key := #0;
end;

procedure TViewPedidoVenda.GetProduto(Value: Integer);
begin
  edtDescricaoProduto.Clear;
  edtValorUnitario.Text := '0,00';

  FController
    .Entity
    .Produtos
    .List(Value)
    .DataSet(FDSTemp);

  if not FDSTemp.DataSet.IsEmpty then
  begin
    edtDescricaoProduto.Text := FDSTemp.DataSet.FieldByName('descricao').AsString;
    edtValorUnitario.Text := FDSTemp.DataSet.FieldByName('precovenda').AsString;

    edtQuantidade.SetFocus;
    CalculateTotalItem;
  end
  else
  begin
    ShowMessage('Produto não encontrado!');

    edtCodigoProduto.Clear;
    edtCodigoProduto.SetFocus;
  end;
end;

procedure TViewPedidoVenda.CalculateTotalItem;
begin
  edtValorTotal.Text := FormatCurr('0.00', (edtQuantidade.ToInt * edtValorUnitario.ToCurr));
end;

procedure TViewPedidoVenda.ShowTotais;
begin
    edtTotalPedido.Text := FormatCurr('0.00', FMTItens.TotalItens);
end;

end.
