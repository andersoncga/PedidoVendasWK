unit View.BuscaProduto;

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
  Data.DB,
  Vcl.Grids,
  Vcl.DBGrids,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,

  PVWK.Controller.Interfaces,
  PVWK.Controller;

type
  TViewBuscaProduto = class(TForm)
    pnlFundo: TPanel;
    gbxBusca: TGroupBox;
    edtBusca: TEdit;
    gbxProdutos: TGroupBox;
    dbgProduto: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure dbgProdutoDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtBuscaChange(Sender: TObject);
  private
    FDSBuscaProduto: TDataSource;
    FController: iController;

  public
    FCodigo: string;

  end;

var
  ViewBuscaProduto: TViewBuscaProduto;

implementation

{$R *.dfm}

procedure TViewBuscaProduto.FormCreate(Sender: TObject);
begin
  FDSBuscaProduto := TDataSource.Create(Self);

  dbgProduto.DataSource := FDSBuscaProduto;

  FController := TController.New;
  FController
    .Entity
    .Produtos
    .List
    .DataSet(FDSBuscaProduto);
end;

procedure TViewBuscaProduto.edtBuscaChange(Sender: TObject);
var
  LFilter: TStringBuilder;
begin
  LFilter := TStringBuilder.Create;
  try
    LFilter.Append('codigo like ' + QuotedStr('%' + Trim(edtBusca.Text) + '%'));
    LFilter.Append(' or ');
    LFilter.Append('descricao like ' + QuotedStr('%' + Trim(edtBusca.Text) + '%'));
    LFilter.Append(' or ');
    LFilter.Append('precovenda like ' + QuotedStr('%' + Trim(edtBusca.Text) + '%'));

    FDSBuscaProduto.DataSet.FilterOptions  := [foCaseInsensitive];
    FDSBuscaProduto.DataSet.Filter         := LFilter.ToString;
    FDSBuscaProduto.DataSet.Filtered       := True;
  finally
    LFilter.DisposeOf;
  end;
end;

procedure TViewBuscaProduto.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN:  begin
                  Key := 0;
                  Perform(WM_NEXTDLGCTL,0,0);
                end;
  end;
end;

procedure TViewBuscaProduto.dbgProdutoDblClick(Sender: TObject);
begin
  if FDSBuscaProduto.DataSet.RecordCount > 0 then
  begin
    FCodigo := FDSBuscaProduto.DataSet.Fields[0].AsString;

    Close;
  end;
end;

end.
