object ViewPedidoVenda: TViewPedidoVenda
  Left = 0
  Top = 0
  Caption = 'Pedido de Venda'
  ClientHeight = 499
  ClientWidth = 743
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 755
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  TextHeight = 15
  object pnlFundo: TPanel
    Left = 0
    Top = 0
    Width = 743
    Height = 499
    Align = alClient
    BevelOuter = bvNone
    Padding.Left = 10
    Padding.Top = 10
    Padding.Right = 10
    Padding.Bottom = 10
    TabOrder = 0
    ExplicitWidth = 739
    ExplicitHeight = 498
    object gbxPedido: TGroupBox
      Left = 10
      Top = 53
      Width = 723
      Height = 89
      Align = alTop
      Caption = 'Pedido'
      TabOrder = 0
      ExplicitWidth = 719
      DesignSize = (
        723
        89)
      object lblNumeroPedido: TLabel
        Left = 11
        Top = 19
        Width = 44
        Height = 15
        Caption = 'N'#250'mero'
      end
      object lblDataEmissao: TLabel
        Left = 167
        Top = 19
        Width = 70
        Height = 15
        Caption = 'Data Emiss'#227'o'
      end
      object lblNomeCliente: TLabel
        Left = 263
        Top = 19
        Width = 37
        Height = 15
        Caption = 'Cliente'
      end
      object edtNumeroPedido: TEdit
        Left = 11
        Top = 40
        Width = 62
        Height = 23
        Enabled = False
        NumbersOnly = True
        TabOrder = 0
        OnExit = edtNumeroPedidoExit
      end
      object dtpDataEmissao: TDateTimePicker
        Left = 167
        Top = 40
        Width = 90
        Height = 23
        Date = 45590.000000000000000000
        Time = 0.524650451392517400
        Enabled = False
        TabOrder = 2
      end
      object edtNomeCliente: TEdit
        Left = 331
        Top = 40
        Width = 290
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        Enabled = False
        NumbersOnly = True
        TabOrder = 4
        ExplicitWidth = 286
      end
      object btnBucaPedido: TBitBtn
        Left = 79
        Top = 40
        Width = 82
        Height = 25
        Hint = 'Abre tela de busca de pedidos'
        Caption = 'Busca Pedido'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnBucaPedidoClick
      end
      object btnBuscaCliente: TBitBtn
        Left = 627
        Top = 39
        Width = 82
        Height = 25
        Hint = 'Abre tela de busca de clientes'
        Anchors = [akTop, akRight]
        Caption = 'Busca Cliente'
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        OnClick = btnBuscaClienteClick
        ExplicitLeft = 623
      end
      object edtCodigoCliente: TEdit
        Left = 263
        Top = 40
        Width = 62
        Height = 23
        Enabled = False
        NumbersOnly = True
        TabOrder = 3
        OnExit = edtCodigoClienteExit
      end
    end
    object gbxItens: TGroupBox
      Left = 10
      Top = 142
      Width = 723
      Height = 273
      Align = alClient
      Caption = 'Itens'
      Enabled = False
      TabOrder = 1
      ExplicitTop = 136
      DesignSize = (
        723
        273)
      object lblProduto: TLabel
        Left = 11
        Top = 24
        Width = 39
        Height = 15
        Caption = 'C'#243'digo'
      end
      object lblDescricaoProduto: TLabel
        Left = 79
        Top = 24
        Width = 51
        Height = 15
        Caption = 'Descri'#231#227'o'
      end
      object lblQuantidade: TLabel
        Left = 413
        Top = 24
        Width = 62
        Height = 15
        Anchors = [akTop, akRight]
        Caption = 'Quantidade'
      end
      object lblValorUnitario: TLabel
        Left = 481
        Top = 24
        Width = 71
        Height = 15
        Anchors = [akTop, akRight]
        Caption = 'Valor Unit'#225'rio'
      end
      object lblValorTotal: TLabel
        Left = 558
        Top = 24
        Width = 54
        Height = 15
        Anchors = [akTop, akRight]
        Caption = 'Valor Total'
      end
      object dbgItens: TDBGrid
        Left = 11
        Top = 77
        Width = 698
        Height = 175
        Hint = 'ENTER - Editar Item; DELETE - Excluir Item '
        Anchors = [akLeft, akTop, akRight, akBottom]
        Options = [dgTitles, dgColumnResize, dgColLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgTitleClick, dgTitleHotTrack]
        ParentShowHint = False
        ShowHint = True
        TabOrder = 7
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Segoe UI'
        TitleFont.Style = []
        OnDblClick = dbgItensDblClick
        OnKeyDown = dbgItensKeyDown
        OnKeyPress = dbgItensKeyPress
        Columns = <
          item
            Expanded = False
            FieldName = 'codigoproduto'
            Title.Caption = 'C'#243'digo'
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Title.Caption = 'Descri'#231#227'o'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'quantidade'
            Title.Caption = 'Quantidade'
            Width = 70
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'valorunitario'
            Title.Alignment = taRightJustify
            Title.Caption = 'Valor Unit'#225'rio'
            Width = 80
            Visible = True
          end
          item
            Alignment = taRightJustify
            Expanded = False
            FieldName = 'valortotal'
            Title.Alignment = taRightJustify
            Title.Caption = 'Valor Total'
            Width = 90
            Visible = True
          end>
      end
      object edtCodigoProduto: TEdit
        Left = 11
        Top = 45
        Width = 62
        Height = 23
        NumbersOnly = True
        TabOrder = 0
        OnExit = edtCodigoProdutoExit
      end
      object edtDescricaoProduto: TEdit
        Left = 79
        Top = 45
        Width = 234
        Height = 23
        Anchors = [akLeft, akTop, akRight]
        Enabled = False
        NumbersOnly = True
        TabOrder = 1
        ExplicitWidth = 230
      end
      object btnBuscaProdutos: TBitBtn
        Left = 319
        Top = 44
        Width = 88
        Height = 25
        Hint = 'Abre tela de busca de produtos'
        Anchors = [akTop, akRight]
        Caption = 'Busca Produto'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = btnBuscaProdutosClick
        ExplicitLeft = 315
      end
      object edtQuantidade: TEdit
        Left = 413
        Top = 45
        Width = 52
        Height = 23
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        NumbersOnly = True
        TabOrder = 3
        Text = '1'
        OnExit = edtQuantidadeExit
        ExplicitLeft = 409
      end
      object edtValorUnitario: TEdit
        Left = 481
        Top = 45
        Width = 52
        Height = 23
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        TabOrder = 4
        Text = '0,00'
        OnExit = edtValorUnitarioExit
        OnKeyPress = edtValorUnitarioKeyPress
        ExplicitLeft = 477
      end
      object edtValorTotal: TEdit
        Left = 558
        Top = 45
        Width = 63
        Height = 23
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Enabled = False
        TabOrder = 5
        Text = '0,00'
        ExplicitLeft = 554
      end
      object btnGravarItem: TBitBtn
        Left = 627
        Top = 44
        Width = 82
        Height = 25
        Hint = 'Gravar item no pedido'
        Anchors = [akTop, akRight]
        Caption = 'Gravar Item'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = btnGravarItemClick
        ExplicitLeft = 623
      end
    end
    object gbxTotais: TGroupBox
      Left = 10
      Top = 415
      Width = 723
      Height = 74
      Align = alBottom
      Caption = 'Totais'
      TabOrder = 2
      ExplicitTop = 414
      ExplicitWidth = 719
      DesignSize = (
        723
        74)
      object lblTotalPedido: TLabel
        Left = 229
        Top = 31
        Width = 137
        Height = 21
        Alignment = taCenter
        Anchors = []
        Caption = 'Total do Pedido R$'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtTotalPedido: TEdit
        Left = 376
        Top = 31
        Width = 114
        Height = 23
        Alignment = taRightJustify
        Anchors = []
        BevelInner = bvNone
        BevelOuter = bvNone
        BorderStyle = bsNone
        Enabled = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Text = '0,00'
        ExplicitLeft = 374
      end
    end
    object GroupBox1: TGroupBox
      Left = 10
      Top = 10
      Width = 723
      Height = 43
      Align = alTop
      TabOrder = 3
      ExplicitWidth = 719
      object btnAcaoPedido: TBitBtn
        Left = 451
        Top = 12
        Width = 82
        Height = 25
        Hint = 'Inicia novo pedido'
        Caption = 'Novo Pedido'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnClick = btnAcaoPedidoClick
      end
      object btnGravaPedido: TBitBtn
        Left = 539
        Top = 12
        Width = 82
        Height = 25
        Hint = 'Grava dados do pedido'
        Caption = 'Gravar Pedido'
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = btnGravaPedidoClick
      end
      object btnCancelar: TBitBtn
        Left = 627
        Top = 12
        Width = 82
        Height = 25
        Hint = 'Cancelar a'#231#227'o'
        Caption = 'Cancelar'
        Enabled = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 2
        OnClick = btnCancelarClick
      end
    end
  end
end
