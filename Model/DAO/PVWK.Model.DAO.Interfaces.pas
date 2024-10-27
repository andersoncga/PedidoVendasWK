unit PVWK.Model.DAO.Interfaces;

interface

uses
  Data.DB;

type
  iModelDAOEntity<T> = interface
    function List: iModelDAOEntity<T>; overload;
    function List(Codigo: Integer): iModelDAOEntity<T>; overload;
    function List(SQL: string): iModelDAOEntity<T>; overload;
    function Delete: iModelDAOEntity<T>; overload;
    function Delete(SQL: string): iModelDAOEntity<T>; overload;
    function Update: iModelDAOEntity<T>; overload;
    function Update(SQL: string): iModelDAOEntity<T>; overload;
    function Insert: iModelDAOEntity<T>;
    function DataSet(DataSource: TDataSource): iModelDAOEntity<T>;
    function NextId: Integer;
    function This: T;
  end;
implementation

end.
