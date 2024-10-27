unit PVWK.Model.Connection.MySQL;

interface

uses
  FireDAC.Comp.UI,
  Firedac.Stan.Intf,
  Firedac.Stan.Option,
  Firedac.Stan.Error,
  Firedac.UI.Intf,
  Firedac.Phys.Intf,
  Firedac.Stan.Def,
  Firedac.Stan.Pool,
  Firedac.Stan.Async,
  Firedac.Phys,
  Firedac.Phys.MySQL,
  Firedac.Phys.MySQLDef,
  Firedac.Stan.ExprFuncs,
  Firedac.VCLUI.Wait,
  Firedac.Comp.Client,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Comp.DataSet,
  PVWK.Model.Connection.Interfaces,
  Data.DB,
  System.SysUtils,
  Vcl.Forms,
  System.IniFiles;
type
  TModelConnectionMySQL = class(TInterfacedObject, iConnection)
    private
      FWaitCursor: TFDGUIxWaitCursor;
      FDriver: TFDPhysMySQLDriverLink;
      FConnection: TFDConnection;
      FQuery: TFDQuery;

    public
      constructor Create;
      destructor Destroy; override;
      class function New: iConnection;
      function Params(Param: string; Value: Variant): iConnection;
      function DataSet(DataSource: TDataSource): iConnection; overload;
      function DataSet: TDataSet; overload;
      function ExecSQL: iConnection;
      function Open: iConnection;
      function SQL(Value: string): iConnection;
      function StartTransaction: iConnection;
      function RollBack: iConnection;
      function Commit: iConnection;

      procedure LoadConnection;
  end;
implementation

uses
  Vcl.Dialogs;

{ TModelConnectionMySQL }

function TModelConnectionMySQL.Commit: iConnection;
begin
  Result := Self;
  FConnection.Commit;
end;

constructor TModelConnectionMySQL.Create;
begin
  FWaitCursor := TFDGUIxWaitCursor.Create(nil);
  FDriver := TFDPhysMySQLDriverLink.Create(nil);
  FConnection := TFDConnection.Create(nil);
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection :=  FConnection;

  LoadConnection;
end;

procedure TModelConnectionMySQL.LoadConnection;
var
  LIni: TIniFile;
begin
  if FileExists(ExtractFilePath(ParamStr(0))+'PVWK.ini') then
  begin
    FConnection.Connected := False;

    LIni := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'PVWk.ini');
    try
      try
        FConnection.Params.Clear;
        FConnection.Params.Values['DriverID'] := 'MySQL';
        FConnection.Params.Values['Server'] := LIni.ReadString('Database','Server','');
        FConnection.Params.Values['Port'] := LIni.ReadString('Database','Port','3306');
        FConnection.Params.Values['Database'] := LIni.ReadString('Database','Database','pvwk');
        FConnection.Params.Values['User_Name'] := LIni.ReadString('Database','Username','root');
        FConnection.Params.Values['Password'] := LIni.ReadString('Database','Password','toor');
        FDriver.VendorLib := LIni.ReadString('Database','LibraryPath','');
        FConnection.Connected := True;
      except on E: Exception do
        raise Exception.Create('Erro ao conectar-se Banco! Verifique se os dados de conexão no PVWK.ini estão corretos.');
      end;
    finally
      LIni.DisposeOf;
    end;
  end
  else
    ShowMessage('Arquivo PVWK.ini não encontrado. Verifique!');
end;

function TModelConnectionMySQL.DataSet(DataSource: TDataSource): iConnection;
begin
  Result              :=  Self;
  DataSource.DataSet  :=  FQuery;
end;

function TModelConnectionMySQL.DataSet: TDataSet;
begin
  Result  :=  FQuery;
end;

destructor TModelConnectionMySQL.Destroy;
begin
  FWaitCursor.DisposeOf;
  FDriver.DisposeOf;
  FQuery.DisposeOf;
  FConnection.DisposeOf;
  inherited;
end;

function TModelConnectionMySQL.ExecSQL: iConnection;
begin
  Result  :=  Self;
  FQuery.ExecSQL;
end;

class function TModelConnectionMySQL.New: iConnection;
begin
  Result  :=  Self.Create;
end;

function TModelConnectionMySQL.Open: iConnection;
begin
  Result  :=  Self;
  FQuery.Open;
end;

function TModelConnectionMySQL.Params(Param: string; Value: Variant): iConnection;
begin
  Result                           :=  Self;
  FQuery.ParamByName(Param).Value  :=  Value;
end;

function TModelConnectionMySQL.RollBack: iConnection;
begin
  Result := Self;
  FConnection.Rollback;
end;

function TModelConnectionMySQL.SQL(Value: string): iConnection;
begin
  Result  :=  Self;
  FQuery.SQL.Clear;
  FQuery.SQl.Add(Value)
end;

function TModelConnectionMySQL.StartTransaction: iConnection;
begin
  Result := Self;
  FConnection.StartTransaction;
end;

end.
