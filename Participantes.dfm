object FPart: TFPart
  Left = 181
  Top = 114
  Width = 1034
  Height = 526
  Caption = 'Participantes'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 451
    Width = 1026
    Height = 41
    Align = alBottom
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 944
      Top = 8
      Width = 75
      Height = 25
      Caption = '&Cerrar'
      TabOrder = 0
      Kind = bkClose
    end
    object BBtnBorrar: TBitBtn
      Left = 8
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Borrar'
      TabOrder = 1
      OnClick = BBtnBorrarClick
    end
  end
  object DBCtrlGrid2: TDBCtrlGrid
    Left = 0
    Top = 48
    Width = 1017
    Height = 399
    Align = alCustom
    DataSource = DSPart
    PanelBorder = gbNone
    PanelHeight = 19
    PanelWidth = 1000
    TabOrder = 1
    RowCount = 21
    object DBEdApellidos: TDBEdit
      Left = 200
      Top = 0
      Width = 401
      Height = 19
      Ctl3D = False
      DataField = 'Apellidos'
      DataSource = DSPart
      ParentCtl3D = False
      TabOrder = 1
    end
    object DBedFenac: TDBEdit
      Left = 600
      Top = 0
      Width = 105
      Height = 19
      Ctl3D = False
      DataField = 'Fenac'
      DataSource = DSPart
      ParentCtl3D = False
      TabOrder = 2
    end
    object DBEdit8: TDBEdit
      Left = 704
      Top = 0
      Width = 65
      Height = 19
      Ctl3D = False
      DataField = 'Sexo'
      DataSource = DSPart
      ParentCtl3D = False
      TabOrder = 3
    end
    object DBEdNombre: TDBEdit
      Left = 80
      Top = 0
      Width = 121
      Height = 19
      Ctl3D = False
      DataField = 'Nombre'
      DataSource = DSPart
      ParentCtl3D = False
      TabOrder = 0
    end
    object DBEdCodigo: TDBEdit
      Left = 0
      Top = 0
      Width = 81
      Height = 19
      TabStop = False
      Color = clSkyBlue
      Ctl3D = False
      DataField = 'Atleta'
      DataSource = DSPart
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      ReadOnly = True
      TabOrder = 5
    end
    object DBEdit1: TDBEdit
      Left = 768
      Top = 0
      Width = 225
      Height = 19
      Ctl3D = False
      DataField = 'Email'
      DataSource = DSPart
      ParentCtl3D = False
      TabOrder = 4
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1026
    Height = 41
    Align = alTop
    Color = clSkyBlue
    TabOrder = 2
    object Label1: TLabel
      Left = 8
      Top = 13
      Width = 45
      Height = 16
      Caption = 'C'#243'digo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Helvetica'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 88
      Top = 13
      Width = 53
      Height = 16
      Caption = 'Nombre '
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Helvetica'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 208
      Top = 13
      Width = 59
      Height = 16
      Caption = 'Apellidos'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Helvetica'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 608
      Top = 13
      Width = 82
      Height = 16
      Caption = 'F.Nacimiento'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Helvetica'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label16: TLabel
      Left = 712
      Top = 13
      Width = 31
      Height = 16
      Caption = 'Sexo'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Helvetica'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 768
      Top = 13
      Width = 33
      Height = 16
      Caption = 'eMail'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Helvetica'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object DSPart: TDataSource
    DataSet = DM1.TPart
    Left = 428
    Top = 292
  end
end
