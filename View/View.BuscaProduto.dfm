object ViewBuscaProduto: TViewBuscaProduto
  Left = 0
  Top = 0
  Caption = 'ViewBuscaProduto'
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
    object gbxProdutos: TGroupBox
      Left = 10
      Top = 65
      Width = 608
      Height = 367
      Align = alClient
      Caption = 'Produtos (D'#234' um  duplo clique para seleiconar'
      TabOrder = 1
      ExplicitWidth = 604
      ExplicitHeight = 366
      object dbgProduto: TDBGrid
        Left = 2
        Top = 17
        Width = 604
        Height = 348
        Hint = 'D'#234' um duplo clique para selecionar o Produto'
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
        OnDblClick = dbgProdutoDblClick
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
            FieldName = 'descricao'
            Title.Caption = 'Descri'#231#227'o'
            Width = 250
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'precovenda'
            Title.Alignment = taRightJustify
            Title.Caption = 'Pre'#231'o Venda'
            Width = 100
            Visible = True
          end>
      end
    end
  end
end
