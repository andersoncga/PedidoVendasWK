unit PVWK.Helper.Edit;

interface

uses
  System.Classes,
  Vcl.StdCtrls,
  System.SysUtils;

type
  THelperEdit = class helper for TEdit
    private

    public
      function ToCurr: Currency;
      function IsEmpty: Boolean;
      function ToInt: Integer;

  end;

implementation

{ THelperEdit }

function THelperEdit.ToInt: Integer;
begin
  Result := StrToIntDef(Self.Text, 0);
end;

function THelperEdit.IsEmpty: Boolean;
begin
  Result := False;
  if (Trim(Self.Text) = '') then
    Result := True;
end;

function THelperEdit.ToCurr: Currency;
begin
  if (Self.Text = '') then
    Self.Text := '0';
  Result := StrToCurr(StringReplace(Self.Text, '.', '', [rfReplaceAll]));
end;

end.

