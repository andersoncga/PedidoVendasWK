unit View.BuscaPedido;

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
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,

  PVWK.Controller.Interfaces,
  PVWK.Controller;

type
  TViewBuscaPedido = class(TForm)
    pnlFundo: TPanel;
    gbxPedido: TGroupBox;
    gbxItens: TGroupBox;
    dbgPedidos: TDBGrid;
    edtBusca: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dbgPedidosDblClick(Sender: TObject);
    procedure edtBuscaChange(Sender: TObject);
  private
    FDSBuscaPedido: TDataSource;
    FController: iController;

  public
    FNumeroPedido: string;

  end;

var
  ViewBuscaPedido: TViewBuscaPedido;

implementation

{$R *.dfm}

procedure TViewBuscaPedido.FormCreate(Sender: TObject);
begin
  FDSBuscaPedido := TDataSource.Create(Self);

  dbgPedidos.DataSource := FDSBuscaPedido;

  FController := TController.New;
  FController
    .Entity
    .Pedidos
    .List('select p.numeropedido, p.dataemissao, c.nome cliente, valortotal from pedidos p join clientes c on c.codigo = p.codigocliente')
    .DataSet(FDSBuscaPedido);
end;

procedure TViewBuscaPedido.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN:  begin
                  Key := 0;
                  Perform(WM_NEXTDLGCTL,0,0);
                end;
  end;
end;

procedure TViewBuscaPedido.dbgPedidosDblClick(Sender: TObject);
begin
  if FDSBuscaPedido.DataSet.RecordCount > 0 then
  begin
    FNumeroPedido := FDSBuscaPedido.DataSet.Fields[0].AsString;

    Close;
  end;
end;

procedure TViewBuscaPedido.edtBuscaChange(Sender: TObject);
var
  LFilter: TStringBuilder;
begin
  LFilter := TStringBuilder.Create;
  try
    LFilter.Append('numeropedido like ' + QuotedStr('%' + Trim(edtBusca.Text) + '%'));
    LFilter.Append(' or ');
    LFilter.Append('cliente like ' + QuotedStr('%' + Trim(edtBusca.Text) + '%'));
    LFilter.Append(' or ');
    LFilter.Append('dataemissao like ' + QuotedStr('%' + Trim(edtBusca.Text) + '%'));
    LFilter.Append(' or ');
    LFilter.Append('valortotal like ' + QuotedStr('%' + Trim(edtBusca.Text) + '%'));

    FDSBuscaPedido.DataSet.FilterOptions  := [foCaseInsensitive];
    FDSBuscaPedido.DataSet.Filter         := LFilter.ToString;
    FDSBuscaPedido.DataSet.Filtered       := True;
  finally
    LFilter.DisposeOf;
  end;
end;

end.
