object Setting2Form: TSetting2Form
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Setting2Form'
  ClientHeight = 524
  ClientWidth = 327
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  PixelsPerInch = 96
  TextHeight = 13
  object CategoryPanelGroup1: TCategoryPanelGroup
    Left = 0
    Top = 0
    Width = 169
    Height = 524
    VertScrollBar.Tracking = True
    DoubleBuffered = True
    Color = clBtnFace
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'Tahoma'
    HeaderFont.Style = []
    ParentDoubleBuffered = False
    TabOrder = 0
    object CategoryPanel3: TCategoryPanel
      Top = 353
      Height = 164
      Caption = #1055#1083#1086#1089#1082#1086#1089#1090#1080' '#1086#1090#1089#1077#1095#1077#1085#1080#1103':'
      TabOrder = 0
      Visible = False
      ExplicitTop = 393
      object Edit1: TEdit
        Left = 7
        Top = 9
        Width = 49
        Height = 21
        Cursor = crHandPoint
        Alignment = taCenter
        BevelInner = bvLowered
        ParentColor = True
        TabOrder = 0
        Text = '0'
        OnClick = Edit1Click
      end
      object Edit2: TEdit
        Left = 57
        Top = 9
        Width = 49
        Height = 21
        Cursor = crHandPoint
        Alignment = taCenter
        ParentColor = True
        TabOrder = 1
        Text = '0'
        OnClick = Edit2Click
      end
      object Edit3: TEdit
        Left = 107
        Top = 9
        Width = 49
        Height = 21
        Cursor = crHandPoint
        Alignment = taCenter
        ParentColor = True
        TabOrder = 2
        Text = '1'
        OnClick = Edit3Click
      end
      object GroupBox5: TGroupBox
        Left = 7
        Top = 36
        Width = 153
        Height = 26
        Cursor = crHandPoint
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 3
        OnMouseDown = GroupBox5MouseDown
        OnMouseLeave = GroupBox5MouseLeave
        OnMouseMove = GroupBox5MouseMove
        object Label6: TLabel
          Left = 45
          Top = 4
          Width = 64
          Height = 16
          Cursor = crHandPoint
          Caption = #1055#1088#1080#1084#1077#1085#1080#1090#1100
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnMouseDown = Label6MouseDown
          OnMouseMove = Label6MouseMove
          OnMouseLeave = Label6MouseLeave
        end
      end
    end
    object CategoryPanel2: TCategoryPanel
      Top = 153
      Caption = #1054#1090#1086#1073#1088#1072#1078#1077#1085#1080#1077' '#1084#1086#1076#1077#1083#1080':'
      TabOrder = 1
      object Label5: TLabel
        Left = 38
        Top = 112
        Width = 91
        Height = 13
        Caption = #1055#1088#1086#1079#1088#1072#1095#1085#1086#1089#1090#1100' 0%'
      end
      object RadioButton1: TRadioButton
        Left = 7
        Top = 11
        Width = 113
        Height = 17
        Caption = #1042#1077#1088#1096#1080#1085#1099
        TabOrder = 0
        OnMouseDown = RadioButton1MouseDown
      end
      object RadioButton2: TRadioButton
        Left = 7
        Top = 34
        Width = 113
        Height = 17
        Caption = #1055#1086#1083#1080#1075#1086#1085#1099
        TabOrder = 1
        OnMouseDown = RadioButton2MouseDown
      end
      object RadioButton3: TRadioButton
        Left = 7
        Top = 57
        Width = 113
        Height = 17
        Caption = #1047#1072#1083#1080#1074#1082#1072
        TabOrder = 2
        OnMouseDown = RadioButton3MouseDown
      end
      object RadioButton4: TRadioButton
        Left = 7
        Top = 80
        Width = 113
        Height = 17
        Caption = #1058#1077#1082#1089#1090#1091#1088#1072
        TabOrder = 3
        OnMouseDown = RadioButton4MouseDown
      end
      object TrackBar1: TTrackBar
        Left = 7
        Top = 131
        Width = 150
        Height = 25
        Cursor = crHandPoint
        ShowSelRange = False
        TabOrder = 4
        OnChange = TrackBar1Change
      end
    end
    object CategoryPanel1: TCategoryPanel
      Top = 0
      Height = 153
      Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1084#1086#1076#1077#1083#1100':'
      TabOrder = 2
      object GroupBox1: TGroupBox
        Left = 7
        Top = 8
        Width = 153
        Height = 25
        Cursor = crHandPoint
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        OnMouseDown = GroupBox1MouseDown
        OnMouseLeave = GroupBox1MouseLeave
        OnMouseMove = GroupBox1MouseMove
        object Label1: TLabel
          Left = 37
          Top = 4
          Width = 76
          Height = 16
          Cursor = crHandPoint
          Caption = #1055#1091#1089#1090#1086#1081' '#1093#1086#1083#1089#1090
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnMouseDown = Label1MouseDown
          OnMouseMove = Label1MouseMove
          OnMouseLeave = Label1MouseLeave
        end
      end
      object GroupBox2: TGroupBox
        Left = 7
        Top = 35
        Width = 153
        Height = 26
        Cursor = crHandPoint
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        OnMouseDown = GroupBox2MouseDown
        OnMouseLeave = GroupBox2MouseLeave
        OnMouseMove = GroupBox2MouseMove
        object Label2: TLabel
          Left = 31
          Top = 4
          Width = 84
          Height = 16
          Cursor = crHandPoint
          Caption = #1058#1086#1088#1089' '#1080' '#1089#1077#1088#1076#1094#1077
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnMouseDown = Label2MouseDown
          OnMouseMove = Label2MouseMove
          OnMouseLeave = Label2MouseLeave
        end
      end
      object GroupBox3: TGroupBox
        Left = 7
        Top = 63
        Width = 153
        Height = 26
        Cursor = crHandPoint
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 2
        OnMouseDown = GroupBox3MouseDown
        OnMouseLeave = GroupBox3MouseLeave
        OnMouseMove = GroupBox3MouseMove
        object Label3: TLabel
          Left = 52
          Top = 4
          Width = 43
          Height = 16
          Cursor = crHandPoint
          Caption = #1057#1077#1088#1076#1094#1077
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnMouseDown = Label3MouseDown
          OnMouseMove = Label3MouseMove
          OnMouseLeave = Label3MouseLeave
        end
      end
      object GroupBox4: TGroupBox
        Left = 7
        Top = 91
        Width = 153
        Height = 26
        Cursor = crHandPoint
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 3
        OnMouseDown = GroupBox4MouseDown
        OnMouseLeave = GroupBox4MouseLeave
        OnMouseMove = GroupBox4MouseMove
        object Label4: TLabel
          Left = 18
          Top = 4
          Width = 118
          Height = 16
          Cursor = crHandPoint
          Caption = #1057#1077#1088#1076#1094#1077' ('#1086#1090#1089#1077#1095#1077#1085#1080#1077')'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnMouseDown = Label4MouseDown
          OnMouseMove = Label4MouseMove
          OnMouseLeave = Label4MouseLeave
        end
      end
    end
  end
end
