unit PVWK.Model.Connection.Interfaces;

interface

uses
  Data.DB;

type
  iConnection = interface
    function Params(Param: string; Value: Variant): iConnection;
    function DataSet(DataSource: TDataSource): iConnection; overload;
    function DataSet: TDataSet; overload;
    function ExecSQL: iConnection;
    function Open: iConnection;
    function SQL(Value: string): iConnection;
    function StartTransaction: iConnection;
    function RollBack: iConnection;
    function Commit: iConnection;
  end;

implementation

end.
