object ViewBuscaCliente: TViewBuscaCliente
  Left = 0
  Top = 0
  Caption = 'Busca Cliente'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 628
    Height = 442
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 0
    ExplicitWidth = 624
    ExplicitHeight = 441
    object gbxBusca: TGroupBox
      Left = 10
      Top = 10
      Width = 608
      Height = 55
      Align = alTop
      Caption = 'Digite o crit'#233'rio da Busca'
      TabOrder = 0
      ExplicitWidth = 604
      DesignSize = (
        608
        55)
      object edtBusca: TEdit
        Left = 15
        Top = 23
        Width = 578
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        OnChange = edtBuscaChange
        ExplicitWidth = 574
      end
    end
    object gbxClientes: TGroupBox
      Left = 10
      Top = 65
      Width = 608
      Height = 367
      Align = alClient
      Caption = 'Clientes (D'#234' um  duplo clique para seleiconar)'
      TabOrder = 1
      ExplicitWidth = 604
      ExplicitHeight = 366
      object dbgClientes: TDBGrid
        Left = 2
        Top = 17
        Width = 604
        Height = 348
        Hint = 'D'#234' um duplo clique para selecionar o Cliente'
        Align = alClient
        Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick, dgTitleHotTrack]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = dbgClientesDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'codigo'
            Title.Caption = 'C'#243'digo'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Title.Caption = 'Nome'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cidade'
            Title.Caption = 'Cidade'
            Width = 200
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'uf'
            Title.Caption = 'UF'
            Width = 50
            Visible = True
          end>
      end
    end
  end
end
