unit View.BuscaCliente;

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
  TViewBuscaCliente = class(TForm)
    pnlFundo: TPanel;
    gbxBusca: TGroupBox;
    edtBusca: TEdit;
    gbxClientes: TGroupBox;
    dbgClientes: TDBGrid;
    procedure FormCreate(Sender: TObject);
    procedure dbgClientesDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtBuscaChange(Sender: TObject);
  private
    FDSBuscaCliente: TDataSource;
    FController: iController;

  public
    FCodigo: string;

  end;

var
  ViewBuscaCliente: TViewBuscaCliente;

implementation

{$R *.dfm}

procedure TViewBuscaCliente.FormCreate(Sender: TObject);
begin
  FDSBuscaCliente := TDataSource.Create(Self);

  dbgClientes.DataSource := FDSBuscaCliente;

  FController := TController.New;
  FController
    .Entity
    .Clientes
    .List
    .DataSet(FDSBuscaCliente);
end;

procedure TViewBuscaCliente.edtBuscaChange(Sender: TObject);
var
  LFilter: TStringBuilder;
begin
  LFilter := TStringBuilder.Create;
  try
    LFilter.Append('codigo like ' + QuotedStr('%' + Trim(edtBusca.Text) + '%'));
    LFilter.Append(' or ');
    LFilter.Append('nome like ' + QuotedStr('%' + Trim(edtBusca.Text) + '%'));
    LFilter.Append(' or ');
    LFilter.Append('cidade like ' + QuotedStr('%' + Trim(edtBusca.Text) + '%'));
    LFilter.Append(' or ');
    LFilter.Append('uf like ' + QuotedStr('%' + Trim(edtBusca.Text) + '%'));

    FDSBuscaCliente.DataSet.FilterOptions  := [foCaseInsensitive];
    FDSBuscaCliente.DataSet.Filter         := LFilter.ToString;
    FDSBuscaCliente.DataSet.Filtered       := True;
  finally
    LFilter.DisposeOf;
  end;
end;

procedure TViewBuscaCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN:  begin
                  Key := 0;
                  Perform(WM_NEXTDLGCTL,0,0);
                end;
  end;
end;

procedure TViewBuscaCliente.dbgClientesDblClick(Sender: TObject);
begin
  if FDSBuscaCliente.DataSet.RecordCount > 0 then
  begin
    FCodigo := FDSBuscaCliente.DataSet.Fields[0].AsString;

    Close;
  end;
end;

end.
