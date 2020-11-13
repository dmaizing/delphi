unit uOpcoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, RzCmboBx, RzRadGrp, RzEdit, Mask, RzSpnEdt, RzLabel,
  AfComPort,
  ExtCtrls, RzPanel, RzButton, RzRadChk, RzCommon, AfPortControls, RzStatus,
  IniFiles,
  RzTabs, NumIO, JvExStdCtrls, JvRichEdit, JvComponentBase, JvHidControllerClass,
  Spin;

type
  TFormOpcoes = class(TForm)
    LabelCirculos: TRzLabel;
    LabelEspessuraLinha: TRzLabel;
    LabelCorLinha: TRzLabel;
    LabelCorFundo: TRzLabel;
    SpinEditCirculos: TRzSpinEdit;
    SpinEditEspessuraLinha: TRzSpinEdit;
    ColorEditLinha: TRzColorEdit;
    ColorEditFundo: TRzColorEdit;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    SpinEditEspLinhaQuali: TRzSpinEdit;
    ColorEditAbaixoQuali: TRzColorEdit;
    lblFlatColorResidual: TRzLabel;
    Label9: TLabel;
    lblGradientColorResidual: TRzLabel;
    edtColorResidual1: TRzColorEdit;
    edtColorResidual2: TRzColorEdit;
    cmbxResidualStyle: TRzComboBox;
    Label11: TLabel;
    lblFlatColorResultado: TRzLabel;
    lblGradientColorResultado: TRzLabel;
    cmbxResultadoStyle: TRzComboBox;
    edtColorResultado1: TRzColorEdit;
    edtColorResultado2: TRzColorEdit;
    Label12: TLabel;
    lblFlatColorDivisor: TRzLabel;
    lblGradientColorDivisor: TRzLabel;
    cmbxDivisorStyle: TRzComboBox;
    edtColorDivisor1: TRzColorEdit;
    edtColorDivisor2: TRzColorEdit;
    cmbxPortaSerial: TAfPortComboBox;
    ButtonBuscaPorta: TRzButton;
    TimerBuscaPorta: TTimer;
    StatusBaropcoes: TRzStatusBar;
    StatusPaneOpcoes: TRzStatusPane;
    RadioGroupResultado: TRzRadioGroup;
    CheckBoxRI: TRzCheckBox;
    chckbx2Planos: TRzCheckBox;
    CheckBoxManual: TRzCheckBox;
    chckbx4casasdecimais: TRzCheckBox;
    ChckbxGost: TRzCheckBox;
    RzLabel3: TRzLabel;
    ColorEditAcimaQuali: TRzColorEdit;
    PortComboBoxSaida: TAfPortComboBox;
    LabelPortaSaida: TRzLabel;
    CheckBoxSaidaAtiva: TRzCheckBox;
    PageControlOpcoes: TRzPageControl;
    TabSheetVectometros: TRzTabSheet;
    TabSheetIndQualidade: TRzTabSheet;
    TabSheetResultado: TRzTabSheet;
    TabSheetPortIn: TRzTabSheet;
    TabSheetResidual: TRzTabSheet;
    TabSheetDivisor: TRzTabSheet;
    TabSheetDiversos: TRzTabSheet;
    TabSheetPortaSaida: TRzTabSheet;
    LabelBaudRate: TRzLabel;
    ComboBoxBRsaida: TRzComboBox;
    RzLabel4: TRzLabel;
    EditSaida: TRzEdit;
    LabelExemplo: TRzLabel;
    EditExemplo: TRzEdit;
    LabelVariaveis: TRzLabel;
    MemoVariaveis: TRzMemo;
    ButtonEnviaTeste: TRzButton;
    RzLabel5: TRzLabel;
    MemoComandos: TRzMemo;
    GroupBoxAjusteCal: TRzGroupBox;
    NumIOCalAmplitude1: TNumIO;
    NumIOCalAmplitude2: TNumIO;
    NumIOCalPhase1: TNumIO;
    NumIOCalPhase2: TNumIO;
    RzLabel6: TRzLabel;
    RzLabel7: TRzLabel;
    RzLabel8: TRzLabel;
    RzLabel9: TRzLabel;
    chckbxPesoProva: TRzCheckBox;
    chckbxValorInicial: TRzCheckBox;
    btnAjuste: TButton;
    rchedtDiagnostico: TJvRichEdit;
    Label1: TLabel;
    btnLog: TButton;
    SaveDialog: TSaveDialog;
    TimerLog: TTimer;
    btnZerar: TButton;
    chckKeyboard: TCheckBox;
    LblBaud: TRzLabel;
    ComboBoxBaudRate: TRzComboBox;
    chckbxFixaPorta: TCheckBox;
    chckbxPesoPadrao: TCheckBox;
    spedtTempo: TSpinEdit;
    lblTempo: TLabel;
    ChckbxAnguloDefasagem: TRzCheckBox;
    Label2: TLabel;
    Bevel1: TBevel;

    procedure cmbxResidualStyleChange(Sender: TObject);
    procedure cmbxResultadoStyleChange(Sender: TObject);
    procedure cmbxDivisorStyleChange(Sender: TObject);
    procedure edtColorResidual1Change(Sender: TObject);
    procedure edtColorResidual2Change(Sender: TObject);
    procedure edtColorResultado1Change(Sender: TObject);
    procedure edtColorResultado2Change(Sender: TObject);
    procedure SpinEditCirculosChange(Sender: TObject);
    procedure ColorEditLinhaChange(Sender: TObject);
    procedure edtColorDivisor1Change(Sender: TObject);
    procedure edtColorDivisor2Change(Sender: TObject);
    procedure SpinEditEspessuraLinhaChange(Sender: TObject);
    procedure SpinEditEspLinhaQualiChange(Sender: TObject);
    procedure ColorEditFundoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure ButtonBuscaPortaClick(Sender: TObject);
    procedure TimerBuscaPortaTimer(Sender: TObject);
    procedure cmbxPortaSerialChange(Sender: TObject);
    procedure CheckBoxRIClick(Sender: TObject);
    procedure RadioGroupResultadoClick(Sender: TObject);
    procedure CheckBoxManualClick(Sender: TObject);
    procedure ChckbxGostClick(Sender: TObject);
    procedure ComboBoxBRsaidaChange(Sender: TObject);
    procedure ButtonEnviaTesteClick(Sender: TObject);
    procedure PortComboBoxSaidaChange(Sender: TObject);
    procedure btnAjusteClick(Sender: TObject);
    procedure btnLogClick(Sender: TObject);
    procedure TimerLogTimer(Sender: TObject);
    procedure btnZerarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure TouchKeyBoardEnter(Sender: TObject);
    procedure ComboBoxBaudRateChange(Sender: TObject);
    procedure chckbxPesoPadraoClick(Sender: TObject);
    procedure ChckbxAnguloDefasagemClick(Sender: TObject);

  private
    { Private declarations }
  public
		TickLog: integer;
		procedure Habilita_Serial(Hab: Boolean);
	end;

var
  FormOpcoes: TFormOpcoes;
  TempoPorta: Boolean;

implementation

uses Main, uCalibra, uRelatorio, Geral;//, uTeclado;
{$R *.dfm}

procedure TFormOpcoes.TouchKeyBoardEnter(Sender: TObject);
begin
  {if FormOpcoes.chckKeyboard.checked then
  begin
    frmkeyboard.show;
    frmkeyboard.MyTouchKeyboard.Layout := 'Standard';
  end; }

end;

procedure TFormOpcoes.cmbxResidualStyleChange(Sender: TObject);
begin
  frmMain.Vectormeter[1].PanelResidual.VisualStyle := TRzVisualStyle
    (cmbxResidualStyle.ItemIndex);
  frmMain.Vectormeter[2].PanelResidual.VisualStyle := TRzVisualStyle
    (cmbxResidualStyle.ItemIndex);
  lblGradientColorResidual.Visible := cmbxResidualStyle.ItemIndex = 2;
  edtColorResidual2.Visible := lblGradientColorResidual.Visible;
  if cmbxResidualStyle.ItemIndex = 2 then
    lblFlatColorResidual.Caption := 'Cor Inicial:'
  else
    lblFlatColorResidual.Caption := 'Cor:';
end;

procedure TFormOpcoes.cmbxResultadoStyleChange(Sender: TObject);
begin
  frmMain.Vectormeter[1].PanelResultado.VisualStyle := TRzVisualStyle
    (cmbxResultadoStyle.ItemIndex);
  frmMain.Vectormeter[2].PanelResultado.VisualStyle := TRzVisualStyle
    (cmbxResultadoStyle.ItemIndex);
  lblGradientColorResultado.Visible := cmbxResultadoStyle.ItemIndex = 2;
  edtColorResultado2.Visible := lblGradientColorResultado.Visible;
  if cmbxResultadoStyle.ItemIndex = 2 then
    lblFlatColorResultado.Caption := 'Cor Inicial:'
  else
    lblFlatColorResultado.Caption := 'Cor:';
end;

procedure TFormOpcoes.ButtonEnviaTesteClick(Sender: TObject);
begin
  if CheckBoxSaidaAtiva.checked then
  begin
    if frmMain.ComPortSaida.Active then
    begin
      frmMain.ComPortSaida.WriteString(FormataSaida(EditSaida.Text));
    end;
  end;
end;

procedure TFormOpcoes.ChckbxAnguloDefasagemClick(Sender: TObject);
begin
  frmcalibra.pnAnguloDefasagem.Enabled := chckbxAnguloDefasagem.Checked;
end;

procedure TFormOpcoes.ChckbxGostClick(Sender: TObject);
begin
  frmMain.Vectormeter[1].Ghost := ChckbxGost.checked;
  frmMain.Vectormeter[2].Ghost := ChckbxGost.checked;
end;

procedure TFormOpcoes.chckbxPesoPadraoClick(Sender: TObject);
begin
  frmMain.Vectormeter[1].ButtonDown.Visible := chckbxPesoPadrao.Checked;
  frmMain.Vectormeter[2].ButtonDown.Visible := chckbxPesoPadrao.Checked;
  frmcalibra.grpbxPesoPadrao.Visible := chckbxPesoPadrao.Checked;
end;

procedure TFormOpcoes.CheckBoxManualClick(Sender: TObject);
begin
  frmCalibra.NumIOA1SM.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOF1SM.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOA2SM.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOF2SM.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOA1M1.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOF1M1.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOA2M1.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOF2M1.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOA1M2.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOF1M2.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOA2M2.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOF2M2.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOA1RI.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOA2RI.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOF1RI.Enabled := FormOpcoes.CheckBoxManual.checked;
  frmCalibra.NumIOF2RI.Enabled := FormOpcoes.CheckBoxManual.checked;

  frmCalibra.SpeedButtonLer.Visible := not FormOpcoes.CheckBoxManual.checked;
  frmMain.Vectormeter[1].PanelInfo2.Visible :=
    FormOpcoes.CheckBoxManual.checked;
  frmMain.Vectormeter[2].PanelInfo2.Visible :=
    FormOpcoes.CheckBoxManual.checked;
end;

procedure TFormOpcoes.CheckBoxRIClick(Sender: TObject);
begin
  if not Assigned(frmCalibra) then exit;

  frmCalibra.TabRI.TabVisible := CheckBoxRI.checked;
  if frmCalibra.RadioButtonDoisPlanos.checked then
  begin
    frmCalibra.grbPlano1RI.Visible := CheckBoxRI.checked;
    frmCalibra.grbPlano2RI.Visible := CheckBoxRI.checked;
  end
  else
  begin
    frmCalibra.grbPlano1RI.Visible :=
      frmCalibra.RadioButtonMancal1.checked and CheckBoxRI.checked;
    frmCalibra.grbPlano2RI.Visible :=
      frmCalibra.RadioButtonMancal2.checked and CheckBoxRI.checked;
  end;
end;

procedure TFormOpcoes.cmbxDivisorStyleChange(Sender: TObject);
begin
  frmMain.Vectormeter[1].PanelDivisor.VisualStyle := TRzVisualStyle
    (cmbxDivisorStyle.ItemIndex);
  frmMain.Vectormeter[2].PanelDivisor.VisualStyle := TRzVisualStyle
    (cmbxDivisorStyle.ItemIndex);
  lblGradientColorDivisor.Visible := cmbxDivisorStyle.ItemIndex = 2;
  edtColorDivisor2.Visible := lblGradientColorDivisor.Visible;
  if cmbxDivisorStyle.ItemIndex = 2 then
    lblFlatColorDivisor.Caption := 'Cor Inicial:'
  else
    lblFlatColorDivisor.Caption := 'Cor:';
end;

procedure TFormOpcoes.cmbxPortaSerialChange(Sender: TObject);
begin
  try
    AchouNK700 := False;
    frmMain.ComPort.ComNumber := cmbxPortaSerial.ComNumber;
    if frmMain.ComPort.ComNumber > 0 then
      frmMain.ComPort.Open;
  except
    ;
    frmMain.ComPort.Close;
  end;
  if frmMain.ComPort.Active then
  begin
    frmMain.pnSerialPort.Caption := 'Porta ' + IntToStr
      (cmbxPortaSerial.ComNumber) + ' aberta';
    frmMain.ComPort.WriteString('ATT' + #13);
  end;

  StatusPaneOpcoes.Caption := 'Procurando porta ' + IntToStr
		(cmbxPortaSerial.ComNumber);

//	TimerBuscaPorta.Enabled := true;

	while (not TempoPorta) and (not frmMain.Respondeu) do
    Application.ProcessMessages;
  if frmMain.Respondeu then
    StatusPaneOpcoes.Caption := 'NK700 encontrado'
  else
    StatusPaneOpcoes.Caption := 'NK700 não encontrado';
end;

procedure TFormOpcoes.btnAjusteClick(Sender: TObject);
begin

  if frmCalibra.RadioButtonDoisPlanos.checked then
  begin
    if frmMain.VetorMedioP1.Vin.Amp <> 0 then
    begin
      NumIOCalAmplitude1.Text := Format('%2.2f',
        [frmMain.VetorMedioP1.Media.Amp]);
      NumIOCalPhase1.Text := FloatToStr(frmMain.VetorMedioP1.Media.Fase);
    end
    else
    begin
      NumIOCalAmplitude1.Text := frmCalibra.NumIOA1SM.Text;
      NumIOCalPhase1.Text := frmCalibra.NumIOF1SM.Text;
    end;

    if frmMain.VetorMedioP2.Vin.Amp <> 0 then
    begin
      NumIOCalAmplitude2.Text := Format('%2.2f',
        [frmMain.VetorMedioP1.Media.Amp]);
      NumIOCalPhase2.Text := FloatToStr(frmMain.VetorMedioP1.Media.Fase);
    end
    else
    begin
      NumIOCalAmplitude2.Text := frmCalibra.NumIOA2SM.Text;
      NumIOCalPhase2.Text := frmCalibra.NumIOF2SM.Text;
    end;
  end
  else
  begin
    if frmCalibra.RadioButtonMancal1.checked then
    begin
      if frmMain.VetorMedioP1.Vin.Amp <> 0 then
      begin
        NumIOCalAmplitude1.Text := Format('%2.2f',
          [frmMain.VetorMedioP1.Media.Amp]);
        NumIOCalPhase1.Text := FloatToStr(frmMain.VetorMedioP1.Media.Fase);
      end
      else
      begin
        NumIOCalAmplitude1.Text := frmCalibra.NumIOA1SM.Text;
        NumIOCalPhase1.Text := frmCalibra.NumIOF1SM.Text;
      end;
    end
    else
    begin
      if frmMain.VetorMedioP2.Vin.Amp <> 0 then
      begin
        NumIOCalAmplitude2.Text := Format('%2.2f',
          [frmMain.VetorMedioP2.Media.Amp]);
        NumIOCalPhase2.Text := FloatToStr(frmMain.VetorMedioP2.Media.Fase);
      end
      else
      begin
        NumIOCalAmplitude2.Text := frmCalibra.NumIOA2SM.Text;
        NumIOCalPhase2.Text := frmCalibra.NumIOF2SM.Text;
      end;
    end;
  end;
end;

procedure TFormOpcoes.btnLogClick(Sender: TObject);
begin
  if not SaveDialog.Execute then
    exit;
  rchedtDiagnostico.Lines.SaveToFile(SaveDialog.FileName);
end;

procedure TFormOpcoes.btnZerarClick(Sender: TObject);
begin
  NumIOCalAmplitude1.Text := '0';
  NumIOCalPhase1.Text := '0';

  NumIOCalAmplitude2.Text := '0';
  NumIOCalPhase2.Text := '0';
end;

procedure TFormOpcoes.ButtonBuscaPortaClick(Sender: TObject);
var
  i: byte;
  Aux: string;
label log;
begin
  frmMain.Respondeu := False;
  frmMain.ComPort.Close;
  cmbxPortaSerial.UpdatePortList;
  cmbxPortaSerial.ItemIndex := 0;
  if (cmbxPortaSerial.Items.Count < 1) and not (CheckBoxManual.Checked) then
    begin
    MessageBox(formOpcoes.Handle,'Você não possui portas de comunicação, verifique se o cabo USB está conectado ou se os drivers estão instalados corretamente!','Informação', MB_ICONWARNING + MB_OK);
    exit;
    end;

  for i := 0 to cmbxPortaSerial.Items.Count - 1 do
  begin
    try
      TempoPorta := False;
      frmMain.ComPort.Close;
      cmbxPortaSerial.ItemIndex := i;
      cmbxPortaSerial.ChangeIndexNumber;
      frmMain.ComPort.ComNumber := cmbxPortaSerial.ComNumber;
      frmMain.ComPort.Open;
      frmMain.ComPort.WriteString('ATT' + #13);
    except
      // on E: Exception do
      // begin
      frmMain.ComPort.Close;
      { cmbxPortaSerial.ItemIndex := i + 1;
        frmMain.ComPort.Open;
        frmMain.ComPort.WriteString('ATT' + #13); }
      // continue;
      // end;
    end;

    StatusPaneOpcoes.Caption := 'Procurando porta ' + IntToStr
      (cmbxPortaSerial.ComNumber);
    TimerBuscaPorta.Enabled := true;
    while ((not TempoPorta) and (not frmMain.Respondeu)) do
      Application.ProcessMessages;
    if frmMain.Respondeu then
    begin
      StatusPaneOpcoes.Caption := 'NK700 encontrado';
      frmMain.VersaoHardware := 'USB';
      AchouNK700 := true;
      FormOpcoes.rchedtDiagnostico.SelAttributes.Color := clPurple;
      Aux := '(NK700 encontrado)';
      // TfrmCalibra.PageCalibraChange(nil);
      goto log;
    end
    else
    begin
      FormOpcoes.rchedtDiagnostico.SelAttributes.Color := clPurple;
      StatusPaneOpcoes.Caption := 'NK700 não encontrado';
      Aux := '(NK700 não encontrado)';
      frmMain.VersaoHardware := 'Serial';
      AchouNK700 := False;
    end;
  log :
    FormOpcoes.TimerLog.Enabled := true;
    FormOpcoes.rchedtDiagnostico.Lines.Add(Aux + ' - ' + DateTimeToStr(Now));
    FormOpcoes.rchedtDiagnostico.Perform(EM_SCROLL, SB_LINEDOWN, 0);
  end;
end;

procedure TFormOpcoes.Habilita_Serial(Hab: Boolean);
begin
	cmbxPortaSerial.Visible := Hab;
	ButtonBuscaPorta.Visible := Hab;
	chckbxFixaPorta.Visible := Hab;
	LblBaud.Visible := Hab;
	ComboBoxBaudRate.Visible := Hab;
	TimerBuscaPorta.Enabled := Hab;
end;

procedure TFormOpcoes.edtColorResidual1Change(Sender: TObject);
begin
  frmMain.Vectormeter[1].PanelResidual.Color := edtColorResidual1.SelectedColor;
  frmMain.Vectormeter[2].PanelResidual.Color := edtColorResidual1.SelectedColor;
  frmMain.Vectormeter[1].PanelResidual.GradientColorStart :=
    edtColorResidual1.SelectedColor;
  frmMain.Vectormeter[2].PanelResidual.GradientColorStart :=
    edtColorResidual1.SelectedColor;
end;

procedure TFormOpcoes.edtColorResidual2Change(Sender: TObject);
begin
  frmMain.Vectormeter[1].PanelResidual.GradientColorStop :=
    edtColorResidual2.SelectedColor;
  frmMain.Vectormeter[2].PanelResidual.GradientColorStop :=
    edtColorResidual2.SelectedColor;
end;

procedure TFormOpcoes.edtColorDivisor1Change(Sender: TObject);
begin
  frmMain.Vectormeter[1].PanelDivisor.Color := edtColorDivisor1.SelectedColor;
  frmMain.Vectormeter[2].PanelDivisor.Color := edtColorDivisor1.SelectedColor;
  frmMain.Vectormeter[1].PanelDivisor.GradientColorStart :=
    edtColorDivisor1.SelectedColor;
  frmMain.Vectormeter[2].PanelDivisor.GradientColorStart :=
    edtColorDivisor1.SelectedColor;
end;

procedure TFormOpcoes.edtColorDivisor2Change(Sender: TObject);
begin
  frmMain.Vectormeter[1].PanelDivisor.GradientColorStop :=
    edtColorDivisor2.SelectedColor;
  frmMain.Vectormeter[2].PanelDivisor.GradientColorStop :=
    edtColorDivisor2.SelectedColor;
end;

procedure TFormOpcoes.edtColorResultado1Change(Sender: TObject);
begin
  frmMain.Vectormeter[1].PanelResultado.Color :=
    edtColorResultado1.SelectedColor;
  frmMain.Vectormeter[2].PanelResultado.Color :=
    edtColorResultado1.SelectedColor;
  frmMain.Vectormeter[1].PanelResultado.GradientColorStart :=
    edtColorResultado1.SelectedColor;
  frmMain.Vectormeter[2].PanelResultado.GradientColorStart :=
    edtColorResultado1.SelectedColor;
end;

procedure TFormOpcoes.edtColorResultado2Change(Sender: TObject);
begin
  frmMain.Vectormeter[1].PanelResultado.GradientColorStop :=
    edtColorResultado2.SelectedColor;
  frmMain.Vectormeter[2].PanelResultado.GradientColorStop :=
    edtColorResultado2.SelectedColor;
end;

procedure TFormOpcoes.FormActivate(Sender: TObject);
begin
  //frmkeyboard.MyTouchKeyboard.HandleOfTheTargetForm := Self.Handle;
  ComboBoxBaudRateChange(nil);
end;

procedure TFormOpcoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caNone;
  frmMain.ToolButtonOpcoes.Down := False;
  frmMain.ToolButtonOpcoesClick(nil);
end;

procedure TFormOpcoes.FormCreate(Sender: TObject);
var
  Ini700: TIniFile;
  S: string;
  i: byte;
begin
  S := IncludeTrailingBackslash(frmMain.GetSpecialFolderPath);
  S := IncludeTrailingBackslash(S) + 'Teknikao\NK700\';
  if not DirectoryExists(S) then
    ForceDirectories(S);
  S := S + 'NK700.ini';
  try
    Ini700 := TIniFile.Create(S);
    with Ini700 do
    begin
      try
        FormOpcoes.cmbxPortaSerial.ComNumber := ReadInteger('Configuração', 'COM Port', 0);
        FormOpcoes.spedtTempo.Value := ReadInteger('Configuração', 'Tempo Rearme', 10);
        FormOpcoes.CheckBoxRI.Checked := ReadBool('Opcoes', 'Residual Inicial', False);
        FormOpcoes.CheckBoxRIClick(nil);

        frmMain.ComPort.ComNumber := cmbxPortaSerial.ComNumber;
        if frmMain.ComPort.ComNumber > 0 then
      frmMain.ComPort.Open;
      except
      frmMain.ComPort.Close;
      end;
    end;
  finally
    Ini700.Free;
  end;

  FormOpcoes.Top := frmMain.Top + frmMain.pnlClient.Top + 50;
  FormOpcoes.Left := frmMain.ToolButtonOpcoes.Left - FormOpcoes.Width div 2;
  TickLog := 0;
end;

procedure TFormOpcoes.PortComboBoxSaidaChange(Sender: TObject);
begin
  frmMain.ComPortSaida.Close;
  PortComboBoxSaida.UpdatePortList;
  frmMain.ComPortSaida.ComNumber := PortComboBoxSaida.ComNumber;
  frmMain.ComPortSaida.Open;
end;

procedure TFormOpcoes.RadioGroupResultadoClick(Sender: TObject);
begin
  if frmCalibra.RadioButtonMancal1.checked or frmCalibra.RadioButtonDoisPlanos.
    checked then
    frmMain.CompareNorma(1);
  if frmCalibra.RadioButtonMancal2.checked or frmCalibra.RadioButtonDoisPlanos.
    checked then
    frmMain.CompareNorma(2);
end;

procedure TFormOpcoes.SpinEditEspessuraLinhaChange(Sender: TObject);
begin
  frmMain.Vectormeter[1].LineWidth := trunc(SpinEditEspessuraLinha.value);
  frmMain.Vectormeter[2].LineWidth := trunc(SpinEditEspessuraLinha.value);
end;

procedure TFormOpcoes.SpinEditEspLinhaQualiChange(Sender: TObject);
begin
  frmMain.Vectormeter[1].TargetLineWidth := trunc(SpinEditEspLinhaQuali.value);
  frmMain.Vectormeter[2].TargetLineWidth := trunc(SpinEditEspLinhaQuali.value);
end;

procedure TFormOpcoes.TimerBuscaPortaTimer(Sender: TObject);
begin
  TempoPorta := true;
end;

procedure TFormOpcoes.TimerLogTimer(Sender: TObject);
begin
  Inc(TickLog);
  if (TickLog >= (60 { 1 minuto } * 60 { 1 hora } )) then
  begin
    TickLog := 0;
    rchedtDiagnostico.Clear;
    TimerLog.Enabled := False;
  end;
end;

procedure TFormOpcoes.SpinEditCirculosChange(Sender: TObject);
begin
  frmMain.Vectormeter[1].CircleDivisions := trunc(SpinEditCirculos.value);
  frmMain.Vectormeter[2].CircleDivisions := trunc(SpinEditCirculos.value);
end;

procedure TFormOpcoes.ColorEditFundoChange(Sender: TObject);
var
  i: byte;
begin
  for i := 1 to 2 do
  begin
    frmMain.Vectormeter[i].Color := ColorEditFundo.SelectedColor;
    frmMain.Vectormeter[i].PanelInfo1.Color := ColorEditFundo.SelectedColor;
    frmMain.Vectormeter[i].PanelInfo2.Color := ColorEditFundo.SelectedColor;
    frmMain.Vectormeter[i].PanelPlano.Color := ColorEditFundo.SelectedColor;
  end;
end;

procedure TFormOpcoes.ColorEditLinhaChange(Sender: TObject);
begin
  frmMain.Vectormeter[1].LineColor := ColorEditLinha.SelectedColor;
  frmMain.Vectormeter[2].LineColor := ColorEditLinha.SelectedColor;
end;

procedure TFormOpcoes.ComboBoxBaudRateChange(Sender: TObject);
begin
	case ComboBoxBaudRate.ItemIndex of
		0:
			frmMain.ComPort.BaudRate := br1200;
		1:
			frmMain.ComPort.BaudRate := br2400;
		2:
			frmMain.ComPort.BaudRate := br4800;
		3:
			frmMain.ComPort.BaudRate := br9600;
		4:
			frmMain.ComPort.BaudRate := br14400;
		5:
			frmMain.ComPort.BaudRate := br19200;
		6:
			frmMain.ComPort.BaudRate := br38400;
		7:
			frmMain.ComPort.BaudRate := br56000;
		8:
			frmMain.ComPort.BaudRate := br57600;
		9:
			frmMain.ComPort.BaudRate := br115200;
	end;

end;

procedure TFormOpcoes.ComboBoxBRsaidaChange(Sender: TObject);
begin
	case ComboBoxBRsaida.ItemIndex of
		0:
			frmMain.ComPortSaida.BaudRate := br1200;
		1:
			frmMain.ComPortSaida.BaudRate := br2400;
		2:
			frmMain.ComPortSaida.BaudRate := br4800;
		3:
			frmMain.ComPortSaida.BaudRate := br9600;
		4:
			frmMain.ComPortSaida.BaudRate := br14400;
		5:
			frmMain.ComPortSaida.BaudRate := br19200;
		6:
			frmMain.ComPortSaida.BaudRate := br38400;
		7:
			frmMain.ComPortSaida.BaudRate := br56000;
		8:
			frmMain.ComPortSaida.BaudRate := br57600;
		9:
			frmMain.ComPortSaida.BaudRate := br115200;
	end;
end;

end.
