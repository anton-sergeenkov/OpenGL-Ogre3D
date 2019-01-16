object Setting1Form: TSetting1Form
  Left = 0
  Top = 0
  BorderStyle = bsNone
  Caption = 'Setting1Form'
  ClientHeight = 533
  ClientWidth = 486
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
    Height = 533
    VertScrollBar.Tracking = True
    BevelInner = bvNone
    BevelOuter = bvNone
    DoubleBuffered = True
    Color = clBtnFace
    HeaderFont.Charset = DEFAULT_CHARSET
    HeaderFont.Color = clWindowText
    HeaderFont.Height = -11
    HeaderFont.Name = 'Tahoma'
    HeaderFont.Style = []
    ParentDoubleBuffered = False
    TabOrder = 0
    object CategoryPanel1: TCategoryPanel
      Top = 321
      Height = 207
      Caption = #1055#1088#1080#1083#1086#1078#1077#1085#1080#1103':'
      TabOrder = 0
      Visible = False
      object GroupBox1: TGroupBox
        Left = 1
        Top = 5
        Width = 164
        Height = 26
        Cursor = crHandPoint
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 0
        OnMouseDown = GroupBox1MouseDown
        OnMouseLeave = GroupBox1MouseLeave
        OnMouseMove = GroupBox1MouseMove
        object Label9: TLabel
          Left = 8
          Top = 4
          Width = 145
          Height = 16
          Cursor = crHandPoint
          Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1084#1086#1076#1077#1083#1080' '#1090#1086#1088#1089#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          OnMouseDown = Label9MouseDown
          OnMouseMove = Label9MouseMove
          OnMouseLeave = Label9MouseLeave
        end
      end
      object GroupBox2: TGroupBox
        Left = 1
        Top = 32
        Width = 164
        Height = 26
        Cursor = crHandPoint
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        object Label10: TLabel
          Left = 8
          Top = 4
          Width = 148
          Height = 16
          Cursor = crHandPoint
          Caption = #1054#1087#1088#1077#1076#1077#1083#1077#1085#1080#1077' '#1086#1089#1080' '#1089#1077#1088#1076#1094#1072
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
      end
    end
    object CategoryPanel4: TCategoryPanel
      Top = 234
      Height = 87
      Caption = #1055#1077#1088#1077#1084#1077#1097#1077#1085#1080#1077':'
      TabOrder = 1
      object RadioButton3: TRadioButton
        Left = 5
        Top = 5
        Width = 48
        Height = 17
        Cursor = crHandPoint
        Caption = #1054#1089#1100' X'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object RadioButton4: TRadioButton
        Left = 5
        Top = 28
        Width = 48
        Height = 17
        Cursor = crHandPoint
        Caption = #1054#1089#1100' Y'
        TabOrder = 1
      end
      object Button7: TButton
        Left = 112
        Top = 5
        Width = 20
        Height = 20
        Cursor = crHandPoint
        Caption = '+'
        TabOrder = 2
        OnMouseDown = Button7MouseDown
      end
      object Button8: TButton
        Left = 59
        Top = 5
        Width = 20
        Height = 20
        Cursor = crHandPoint
        Caption = '-'
        TabOrder = 3
        OnMouseDown = Button8MouseDown
      end
      object Button9: TButton
        Left = 112
        Top = 28
        Width = 20
        Height = 20
        Cursor = crHandPoint
        Caption = '+'
        TabOrder = 4
        OnMouseDown = Button9MouseDown
      end
      object Button10: TButton
        Left = 59
        Top = 28
        Width = 20
        Height = 20
        Cursor = crHandPoint
        Caption = '-'
        TabOrder = 5
        OnMouseDown = Button10MouseDown
      end
      object Panel6: TPanel
        Left = 80
        Top = 6
        Width = 31
        Height = 18
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 6
        object Label7: TLabel
          Left = 0
          Top = 0
          Width = 31
          Height = 18
          Align = alClient
          Alignment = taCenter
          Caption = '0'
          Color = clBlue
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 8
          ExplicitHeight = 16
        end
      end
      object Panel7: TPanel
        Left = 80
        Top = 29
        Width = 31
        Height = 18
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 7
        object Label8: TLabel
          Left = 0
          Top = 0
          Width = 31
          Height = 18
          Align = alClient
          Alignment = taCenter
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 8
          ExplicitHeight = 16
        end
      end
    end
    object CategoryPanel3: TCategoryPanel
      Top = 127
      Height = 107
      Caption = #1055#1086#1074#1086#1088#1086#1090':'
      TabOrder = 2
      object Label3: TLabel
        Left = 35
        Top = 56
        Width = 121
        Height = 13
        Caption = #1040#1074#1090#1086#1087#1086#1074#1086#1088#1086#1090' '#1086#1090#1082#1083#1102#1095#1077#1085
      end
      object SpeedButton5: TSpeedButton
        Left = 5
        Top = 51
        Width = 24
        Height = 24
        Cursor = crHandPoint
        Flat = True
        Glyph.Data = {
          46050000424D4605000000000000360000002800000012000000120000000100
          20000000000010050000D60D0000D60D00000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E5E6E600C4C4C400B1ACAC00AEA9
          A900BDBCBC00DDDEDE00FEFEFE00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DDDDDD009C8D8D009E5E6000BA53
          5400C9535400CF595A00CB5C5D00A85D5F00957F7F00CCCDCD00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BAB8B800A05E5E00D34C
          4E00DE484A00E1525300E35C5D00E5646400FF6B6E00FF6F7200FE6A6C00B65B
          5C00A69F9F00FCFCFC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BBB8B800B754
          5400CC434300CB414300DA5B5C00DA919200D6B5B600D5C0C000D0B4B400CC92
          9300DA676900FF707300D35C5E00A69D9D00FFFFFF00FFFFFF00FFFFFF00E5E5
          E500AB5D5E00C13E3F00BC3E3F00DD777800F0DDDD00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00EEE5E500C4898900FB6C6E00D15E6000C7C4C400FFFF
          FF00FFFFFF00A78C8D00C4484900AE353600DC707100F5E9E900FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C7919100FF71
          7200AD717100FAFBFB00E5E5E500B75F6000AA333300C64B4C00DFBFBF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00F8F5F500D26F7000EA646600D0CFCF00C8BCBC00C44C4E00A22E2F00CF63
          6300F8F3F300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00D0AAAB00FE6E7100C5A6A600CAA7A700C047
          4900A32F3000C76B6B00FAF9F900FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E5D6D700F46E6F00BD91
          9200CC9FA000C44849009F2E2E00C35A5C00E4E3E300FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00F3EC
          EC00E2686A00D2969700D2AAAB00C64849009D2B2B00CA494B00B4A2A300FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00E8E4E500DF606100D9A8A800E1C9C900CD4C4D00A72F3000B638
          3900B9595900D5D4D400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00C8C0C000E25B5C00E7D1D100F6F0F000CF64
          6400BC383900AA303100CB424300B0636300C7C6C600FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00AA7A7A00D5727300FDFC
          FC00FFFFFF00D09DA100CB454500B6343500AD323300C53F4000B5515100C8C3
          C300FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C2BEBE00BB52
          5300EED4D400FFFFFF00FFFFFF00F7EFF000C5646400C43D3E00B7353500A82F
          3000BE3D3C00AA777700FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0BD
          BD00B25E5F00EFBCBC00FFFFFF00FFFFFF00FFFFFF00FFFFFF00E8D2D200C352
          5300BD393A00B0303000A42D2D00AF434300DEDBDB00FBFBFB00F0F0F000DAD9
          D900B7A1A100E18B8C00FED3D400FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00F6D9D900E2747600C14D4E00D16D6E00EC949600F4DADA00EEE4
          E500EFDDDE00F6DDDE00FFDFDF00FFFAFA00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFF2F300FEEEEF00FFF5F500FFFF
          FF00FFFFFF00FFFCFD00FFFDFD00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00}
        OnMouseDown = SpeedButton5MouseDown
      end
      object RadioButton1: TRadioButton
        Left = 5
        Top = 5
        Width = 48
        Height = 17
        Cursor = crHandPoint
        Caption = #1054#1089#1100' X'
        Checked = True
        TabOrder = 0
        TabStop = True
      end
      object RadioButton2: TRadioButton
        Left = 5
        Top = 28
        Width = 48
        Height = 17
        Cursor = crHandPoint
        Caption = #1054#1089#1100' Y'
        TabOrder = 1
      end
      object Button3: TButton
        Left = 112
        Top = 5
        Width = 20
        Height = 20
        Cursor = crHandPoint
        Caption = '+'
        TabOrder = 2
        OnMouseDown = Button3MouseDown
      end
      object Button4: TButton
        Left = 59
        Top = 5
        Width = 20
        Height = 20
        Cursor = crHandPoint
        Caption = '-'
        TabOrder = 3
        OnMouseDown = Button4MouseDown
      end
      object Button5: TButton
        Left = 112
        Top = 28
        Width = 20
        Height = 20
        Cursor = crHandPoint
        Caption = '+'
        TabOrder = 4
        OnMouseDown = Button5MouseDown
      end
      object Button6: TButton
        Left = 59
        Top = 28
        Width = 20
        Height = 20
        Cursor = crHandPoint
        Caption = '-'
        TabOrder = 5
        OnMouseDown = Button6MouseDown
      end
      object Panel4: TPanel
        Left = 80
        Top = 6
        Width = 31
        Height = 18
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 6
        object Label1: TLabel
          Left = 0
          Top = 0
          Width = 31
          Height = 18
          Align = alClient
          Alignment = taCenter
          Caption = '0'
          Color = clBlack
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentColor = False
          ParentFont = False
          ExplicitWidth = 8
          ExplicitHeight = 16
        end
      end
      object Panel5: TPanel
        Left = 80
        Top = 29
        Width = 31
        Height = 18
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 7
        object Label2: TLabel
          Left = 0
          Top = 0
          Width = 31
          Height = 18
          Align = alClient
          Alignment = taCenter
          Caption = '0'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
          ExplicitWidth = 8
          ExplicitHeight = 16
        end
      end
    end
    object CategoryPanel2: TCategoryPanel
      Top = 0
      Height = 127
      Caption = #1052#1072#1089#1096#1090#1072#1073#1080#1088#1086#1074#1072#1085#1080#1077':'
      TabOrder = 3
      object Label4: TLabel
        Left = 142
        Top = 7
        Width = 12
        Height = 13
        Caption = 'x1'
      end
      object Label5: TLabel
        Left = 142
        Top = 30
        Width = 12
        Height = 13
        Caption = 'x1'
      end
      object Label6: TLabel
        Left = 142
        Top = 53
        Width = 12
        Height = 13
        Caption = 'x1'
      end
      object CheckBox1: TCheckBox
        Left = 5
        Top = 5
        Width = 54
        Height = 17
        Cursor = crHandPoint
        Caption = #1054#1089#1100' X'
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = CheckBox1Click
      end
      object CheckBox2: TCheckBox
        Left = 5
        Top = 28
        Width = 61
        Height = 17
        Cursor = crHandPoint
        Caption = #1054#1089#1100' Y'
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = CheckBox2Click
      end
      object CheckBox3: TCheckBox
        Left = 5
        Top = 51
        Width = 61
        Height = 17
        Cursor = crHandPoint
        Caption = #1054#1089#1100' Z'
        Checked = True
        State = cbChecked
        TabOrder = 2
        OnClick = CheckBox3Click
      end
      object CheckBox4: TCheckBox
        Left = 5
        Top = 74
        Width = 140
        Height = 17
        Cursor = crHandPoint
        Caption = #1057#1086#1093#1088#1072#1085#1103#1090#1100' '#1087#1088#1086#1087#1086#1088#1094#1080#1080
        Checked = True
        State = cbChecked
        TabOrder = 3
      end
      object TrackBar1: TTrackBar
        Left = 55
        Top = 5
        Width = 90
        Height = 20
        Cursor = crHandPoint
        Position = 1
        ShowSelRange = False
        TabOrder = 4
        OnChange = TrackBar1Change
      end
      object TrackBar2: TTrackBar
        Left = 55
        Top = 28
        Width = 90
        Height = 20
        Cursor = crHandPoint
        Position = 1
        ShowSelRange = False
        TabOrder = 5
        OnChange = TrackBar2Change
      end
      object TrackBar3: TTrackBar
        Left = 55
        Top = 51
        Width = 90
        Height = 20
        Cursor = crHandPoint
        Position = 1
        ShowSelRange = False
        TabOrder = 6
        OnChange = TrackBar3Change
      end
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 100
    OnTimer = Timer1Timer
    Left = 200
    Top = 696
  end
end
