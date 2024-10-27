object ViewBuscaPedido: TViewBuscaPedido
  Left = 0
  Top = 0
  Caption = 'Busca Pedido'
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 640
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
    object gbxPedido: TGroupBox
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
    object gbxItens: TGroupBox
      Left = 10
      Top = 65
      Width = 608
      Height = 367
      Align = alClient
      Caption = 'Pedidos (D'#234' um  duplo clique para seleiconar'
      TabOrder = 1
      ExplicitWidth = 604
      ExplicitHeight = 366
      object dbgPedidos: TDBGrid
        Left = 2
        Top = 17
        Width = 604
        Height = 348
        Hint = 'D'#234' um duplo clique para selecionar o Pedido'
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
        OnDblClick = dbgPedidosDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'numeropedido'
            Title.Caption = 'N'#250'mero Pedido'
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dataemissao'
            Title.Caption = 'Data Emiss'#227'o'
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cliente'
            Title.Caption = 'Cliente'
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'valortotal'
            Title.Caption = 'Valor Total'
            Width = 80
            Visible = True
          end>
      end
    end
  end
end
