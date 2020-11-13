unit uCalibra;

interface

uses
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	StdCtrls, NumIO, ComCtrls, Buttons, ExtCtrls, IniFiles, ISO1940, RzButton,
	RzTabs, RzPanel, AdvTrackBar, ExtDlgs, RzStatus, RzRadChk,
	Geral, RzLabel, Mask, RzEdit, RzSpnEdt, RzRadGrp, RzCmboBx, ShellCtrls,
	frxClass, frxPreview, Spin, Keyboard;

type
	TfrmCalibra = class(TForm)
		RzPanel1: TRzPanel;
		AdvTrackBar: TAdvTrackBar;
		lblStatusRPM: TLabel;
		LabelRPMRef: TLabel;
		SpeedButtonLer: TRzToolButton;
		LabelRotacao: TLabel;
		RzPaneBase: TRzPanel;
		PageCalibra: TRzPageControl;
		TabISO: TRzTabSheet;
		GroupBoxP1: TRzGroupBox;
		RadioButtonIso: TRadioButton;
		RadioButtonGramas: TRadioButton;
		NumIOGramas1: TNumIO;
		ComboBoxISO: TComboBox;
		TabBal2SM: TRzTabSheet;
		grbPlano1SM: TRzGroupBox;
		Label1: TLabel;
		Label2: TLabel;
		NumIOA1SM: TNumIO;
		NumIOF1SM: TNumIO;
		grbPlano2SM: TRzGroupBox;
		Label3: TLabel;
		Label4: TLabel;
		NumIOA2SM: TNumIO;
		NumIOF2SM: TNumIO;
		TabBAl2PM1: TRzTabSheet;
		grbPlano2M1: TRzGroupBox;
		Label7: TLabel;
		Label8: TLabel;
		NumIOA2M1: TNumIO;
		NumIOF2M1: TNumIO;
		GroupBoxMPP1: TRzGroupBox;
		LabelGramaMP1: TLabel;
		Label10: TLabel;
		Label23: TLabel;
		NumIOPesoM1: TNumIO;
		NumIOAnguloM1: TNumIO;
		NumIORaioM1: TNumIO;
		NumIODiv1: TNumIO;
		grbPlano1M1: TRzGroupBox;
		Label5: TLabel;
		Label6: TLabel;
		NumIOA1M1: TNumIO;
		NumIOF1M1: TNumIO;
		TabBAl2PM2: TRzTabSheet;
		SpeedButton2: TToolButton;
		GroupBoxMPP2: TRzGroupBox;
		LabelGramaMP2: TLabel;
		Label13: TLabel;
		LabelRaioM2: TLabel;
		Label24: TLabel;
		NumIOPesoM2: TNumIO;
		NumIOAnguloM2: TNumIO;
		NumIORaioM2: TNumIO;
		NumIODiv2: TNumIO;
		grbPlano2M2: TRzGroupBox;
		Label15: TLabel;
		Label16: TLabel;
		NumIOA2M2: TNumIO;
		NumIOF2M2: TNumIO;
		grbPlano1M2: TRzGroupBox;
		Label17: TLabel;
		Label18: TLabel;
		NumIOA1M2: TNumIO;
		NumIOF1M2: TNumIO;
		StatusBarCalibra: TRzStatusBar;
		StatusPaneCalibra: TRzStatusPane;
		CheckBoxmg: TRzCheckBox;
		ButtonAbreCal: TRzToolButton;
		OpenDialog: TOpenDialog;
		ButtonSalvaCal: TRzToolButton;
		SaveDialog: TSaveDialog;
		RzGroupBox4: TRzGroupBox;
		RadioButtonDoisPlanos: TRadioButton;
		RadioButtonUmPlano: TRadioButton;
		GroupBoxMancal: TRzGroupBox;
		RadioButtonMancal1: TRadioButton;
		RadioButtonMancal2: TRadioButton;
		LabelPesoSugeridoP1: TLabel;
		LabelPesoSugeridoP2: TLabel;
		NumIOGramas2: TNumIO;
		lblPlano1: TRzLabel;
		lblPlano2: TRzLabel;
		GroupBoxRotor: TRzGroupBox;
		lblPesoRotor: TLabel;
		NumIOPesoRotor: TNumIO;
		lblRPMTrabalho: TLabel;
		NumIORPMTrabalho: TNumIO;
		TabRI: TRzTabSheet;
		grbPlano1RI: TRzGroupBox;
		Label27: TLabel;
		Label29: TLabel;
		NumIOA1RI: TNumIO;
		NumIOF1RI: TNumIO;
		grbPlano2RI: TRzGroupBox;
		Label14: TLabel;
		Label19: TLabel;
		NumIOA2RI: TNumIO;
		NumIOF2RI: TNumIO;
		ButtonFim2Planos: TRzToolButton;
		RadioButtonGmm: TRadioButton;
		TabSheetCliente: TRzTabSheet;
		grpbxImage: TGroupBox;
		imgPeca: TImage;
		RzPanel2: TRzPanel;
		LabelNomeFigura: TRzLabel;
		spbtnLimparImagem: TSpeedButton;
		OpenPictureDialog: TOpenPictureDialog;
		GroupBoxCliente: TRzGroupBox;
		lbledtCliente: TLabeledEdit;
		lbledtPeca: TLabeledEdit;
		lbledtOperador: TLabeledEdit;
		GroupBoxObs: TRzGroupBox;
		mmObs: TMemo;
		TabBAl2PM3: TRzTabSheet;
		RzGroupBox1: TRzGroupBox;
		Label9: TLabel;
		Label11: TLabel;
		Label12: TLabel;
		Label20: TLabel;
		Label21: TLabel;
		RzToolButton1: TRzToolButton;
		NumIOPesoM3: TNumIO;
		NumIOAnguloM3: TNumIO;
		NumIORaioM3: TNumIO;
		NumIODiv3: TNumIO;
		RzGroupBox2: TRzGroupBox;
		Label22: TLabel;
		Label25: TLabel;
		NumIOA1M3: TNumIO;
		NumIOF1M3: TNumIO;
		RzGroupBox3: TRzGroupBox;
		Label26: TLabel;
		Label28: TLabel;
		NumIOA2M3: TNumIO;
		NumIOF2M3: TNumIO;
		Label32: TLabel;
		Splitter: TSplitter;
    lblResidualP1: TLabel;
    lblResidualP2: TLabel;
    grpbxPesoPadrao: TRzGroupBox;
    Label30: TLabel;
    NumIOPesoPadrao: TNumIO;
    pnAnguloDefasagem: TPanel;
    pnPecaSimetrica: TPanel;
    tlbtnSimetria: TRzToolButton;
    Label31: TLabel;
    txtAngDefasagem: TNumIO;
		procedure PageCalibraChange(Sender: TObject);
		procedure FormShow(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure FormCreate(Sender: TObject);
		procedure SpeedButtonLerClick(Sender: TObject);
		procedure FormKeyPress(Sender: TObject; var Key: Char);
		procedure FimCalibraClick(Sender: TObject);
		procedure tlbtnSimetriaClick(Sender: TObject);
		procedure AdvTrackBarChange(Sender: TObject);
		procedure CheckBoxmgClick(Sender: TObject);
		procedure ButtonAbreCalClick(Sender: TObject);
		procedure ButtonSalvaCalClick(Sender: TObject);
		procedure RadioButtonUmPlanoClick(Sender: TObject);
		procedure SugerePeso(Sender: TObject);
		procedure OnEditEnter(Sender: TObject);
		procedure NumIOGramas1Change(Sender: TObject);
		procedure NumIOGramas2Change(Sender: TObject);
		procedure imgPecaDblClick(Sender: TObject);
		procedure NumIODiv1Change(Sender: TObject);
		procedure NumIODiv2Change(Sender: TObject);
		procedure NumIODiv2Exit(Sender: TObject);
		procedure NumIODiv1Exit(Sender: TObject);
    procedure TouchKeyBoardEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure NumIOPesoPadraoChange(Sender: TObject);
    procedure txtAngDefasagemExit(Sender: TObject);
    procedure txtAngDefasagemChange(Sender: TObject);
	private
		procedure EditLabelOnDblClick(Sender: TObject);
		procedure Calcula_Ideal;


		{ Private declarations }
	public

		Ref1P, RefP1, RefP2: TVetor;
		FiguraRotor: String;
		NK700Format: TFormatSettings;
		procedure AbreCalClick(S: String);
		function ConfereDadosPlanos(Show: boolean): boolean;
		function FaltaDados(Campo: TNumIO; Fase: boolean; Aba: TRzTabSheet; Mss: AnsiString; Show: boolean): boolean;

	end;

var
	frmCalibra: TfrmCalibra;
	CamposLivresCal: array [1 .. 8] of TLabeledEdit;

implementation

uses Main, Vectormeter, frxVariables, uOpcoes, uRelatorio, USalvar;//, uTeclado;
{$R *.DFM}

procedure TfrmCalibra.SugerePeso(Sender: TObject);
var
	X: single;
	S: String;
begin
	frmMain.Vectormeter[1].Raio := NumIORaioM1.Value;
	frmMain.Vectormeter[2].Raio := NumIORaioM2.Value;
	Calcula_Ideal;
	LabelPesoSugeridoP1.Caption := 'Peso Sugerido: ';
	LabelPesoSugeridoP2.Caption := LabelPesoSugeridoP1.Caption;
	X := (frmMain.Gramas.Ideal[1]);
	if NumIORaioM1.Value > 0 then
		LabelPesoSugeridoP1.Caption := LabelPesoSugeridoP1.Caption + mysetformat(X * 5) + ' a ' + mysetformat(X * 10);

	X := (frmMain.Gramas.Ideal[2]);
	if NumIORaioM2.Value > 0 then
		LabelPesoSugeridoP2.Caption := LabelPesoSugeridoP2.Caption + mysetformat(X * 5) + ' a ' + mysetformat(X * 10);

	S := ' gramas';
	if CheckBoxmg.Checked then
		S := ' mili' + S;
	LabelPesoSugeridoP1.Caption := LabelPesoSugeridoP1.Caption + S;
	LabelPesoSugeridoP2.Caption := LabelPesoSugeridoP2.Caption + S;
end;

{procedure TfrmCalibra.CalculaResidual;
var
S: string;
begin
  frmMain.Vectormeter[1].Raio := NumIORaioM1.Value;
	frmMain.Vectormeter[2].Raio := NumIORaioM2.Value;

  lblResidualP1.Caption := 'Residual: ';
	lblResidualP2.Caption := lblResidualP1.Caption;

  //calculo do residual durante
  if NumIORaioM1.Value > 0 then
  frmMain.ISOG.Inicial[1] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[1], NumIORaioM1.Value);
  // para o primeiro calculo de bal
	frmMain.Gmm.Inicial[1] := frmMain.Gramas.Final[1] * NumIORaioM1.Value;

  frmMain.ISOG.Inicial[2] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[2], NumIORaioM2.Value);
  // para o primeiro calculo de bal
	frmMain.Gmm.Inicial[2] := frmMain.Gramas.Final[2] * NumIORaioM1.Value;

  lblResidualP1.Caption := LabelPesoSugeridoP1.Caption + S;
	lblResidualP2.Caption := LabelPesoSugeridoP2.Caption + S;
end;}

procedure TfrmCalibra.PageCalibraChange(Sender: TObject);
begin
	Repaint;
	SpeedButtonLer.Down := False;
	SpeedButtonLerClick(nil);
	AdvTrackBar.Position := 0;

//	SpeedButtonLer.Enabled := False;

	SpeedButtonLer.Enabled :=
		((PageCalibra.ActivePage = TabRI)
		or (PageCalibra.ActivePage = TabBal2SM)
		or (PageCalibra.ActivePage = TabBAl2PM1)
		or (PageCalibra.ActivePage = TabBAl2PM2))
		and (frmMain.ComPort.Active or AchouNK700)
		and not FormOpcoes.CheckBoxManual.Checked;

	if PageCalibra.ActivePage = TabISO then
		StatusPaneCalibra.Caption := 'Dados para balanceamento';
	if PageCalibra.ActivePage = TabBal2SM then
		StatusPaneCalibra.Caption := 'Medir sem peso de prova';
	if PageCalibra.ActivePage = TabBAl2PM1 then
		begin
			StatusPaneCalibra.Caption := 'Colocar peso de prova no plano 1';
			SugerePeso(nil);
		end;
	if PageCalibra.ActivePage = TabBAl2PM2 then
		begin
			StatusPaneCalibra.Caption := 'Retirar o peso de prova do plano 1 e colocar no plano 2';
			SugerePeso(nil);
		end;
end;

procedure TfrmCalibra.FormActivate(Sender: TObject);
begin
  //frmKeyboard.MyTouchKeyboard.HandleOfTheTargetForm := Self.Handle;
end;

procedure TfrmCalibra.FormClose(Sender: TObject; var Action: TCloseAction);
begin
	if ConfereDadosPlanos(False) then
		begin
			if MessageBox(Handle, 'Dados incompletos, sair assim mesmo?', 'Confirmação', MB_YESNO + MB_ICONQUESTION)
				= mrNo then
				begin
					Action := caNone;
					frmMain.tlbtnCalibrar.Down := True;
					exit;
				end
			else
        frmMain.tlbtnCalibrar.Down := False;
		end;
  frmMain.tlbtnCalibrar.Down := False;
end;

procedure TfrmCalibra.FormShow(Sender: TObject);
begin
	PageCalibra.ActivePage := TabISO;
	SpeedButtonLer.Enabled := False;
end;

procedure TfrmCalibra.NumIODiv1Change(Sender: TObject);
begin
	frmMain.Vectormeter[1].Divisions := Round(NumIODiv1.Value);
end;

procedure TfrmCalibra.NumIODiv1Exit(Sender: TObject);
begin
	if NumIODiv1.Value < 3 then
		NumIODiv1.Text := '3';
end;

procedure TfrmCalibra.NumIODiv2Change(Sender: TObject);
begin
	frmMain.Vectormeter[2].Divisions := Round(NumIODiv2.Value);
end;

procedure TfrmCalibra.txtAngDefasagemChange(Sender: TObject);
begin
  //
  frmMain.Vectormeter[2].Divisions := Round(NumIODiv2.Value);
end;

procedure TfrmCalibra.NumIODiv2Exit(Sender: TObject);
begin
	if NumIODiv2.Value < 3 then
		NumIODiv2.Text := '3';
end;

procedure TfrmCalibra.NumIOGramas1Change(Sender: TObject);
begin
	frmMain.Gramas.Ideal[1] := NumIOGramas1.Value;
end;

procedure TfrmCalibra.NumIOGramas2Change(Sender: TObject);
begin
	frmMain.Gramas.Ideal[2] := NumIOGramas2.Value;
end;

procedure TfrmCalibra.NumIOPesoPadraoChange(Sender: TObject);
begin
  frmMain.Vectormeter[1].PesoPadrao := NumIOPesoPadrao.Value;
  frmMain.Vectormeter[2].PesoPadrao := NumIOPesoPadrao.Value;
end;

procedure TfrmCalibra.OnEditEnter(Sender: TObject);
begin
 (Sender as TNumIO).SelectAll;
end;

procedure TfrmCalibra.EditLabelOnDblClick(Sender: TObject);
begin
	CamposLivresCal[TControl(Sender).Tag].EditLabel.Caption := InputBox('Nome do Campo', 'Nome do Campo',
		CamposLivresCal[TControl(Sender).Tag].EditLabel.Caption);
end;

procedure TfrmCalibra.TouchKeyBoardEnter(Sender: TObject);
begin
  //if FormOpcoes.chckKeyboard.checked then
    //begin
    //frmkeyboard.show;
    //frmkeyboard.MyTouchKeyboard.Layout := 'NumPad';
    //end;

end;



procedure TfrmCalibra.txtAngDefasagemExit(Sender: TObject);
begin
  frmMain.Vectormeter[2].AngleDefasagem := StrToInt(txtAngDefasagem.Text);
  // forçar a mudança por causa do modo como a função verifica
  // if FDivisions <> Value then
  //frmMain.Vectormeter[2].Divisions := 3;
  frmMain.Vectormeter[2].Divisions := Round(NumIODiv2.Value);

end;

procedure TfrmCalibra.FormCreate(Sender: TObject);
var
	S: String;
	i: integer;
	IniCalibra: TIniFile;
begin
  for i := 0 to ComponentCount - 1 do
    begin
    if (Components[i].ClassName = 'TNumIO') then
      TNumIO(Components[i]).OnEnter := TouchKeyBoardEnter;
    end;


	GetLocaleFormatSettings(LOCALE_SYSTEM_DEFAULT, NK700Format);
	if NK700Format.DecimalSeparator = ',' then
		begin
			ComboBoxISO.Clear;
			ComboBoxISO.Items.Add('4000');
			ComboBoxISO.Items.Add('250');
			ComboBoxISO.Items.Add('40');
			ComboBoxISO.Items.Add('6,3');
			ComboBoxISO.Items.Add('2,5');
			ComboBoxISO.Items.Add('1,0');
			ComboBoxISO.Items.Add('0,4');
		end
	else
		begin
			ComboBoxISO.Clear;
			ComboBoxISO.Items.Add('4000');
			ComboBoxISO.Items.Add('250');
			ComboBoxISO.Items.Add('40');
			ComboBoxISO.Items.Add('6.3');
			ComboBoxISO.Items.Add('2.5');
			ComboBoxISO.Items.Add('1.0');
			ComboBoxISO.Items.Add('0.4');
		end;

	OpenDialog.DefaultExt := 'CalBal';
	OpenDialog.FileName := '*.CalBal';
	OpenDialog.Filter := 'Arquivo Calibração NK700|*.CalBal';
	SaveDialog.DefaultExt := 'CalBal';
	SaveDialog.FileName := '*.CalBal';
	SaveDialog.Filter := 'Arquivo Calibração NK700|*.CalBal';
	FormOpcoes.CheckBoxManualClick(nil);
	RadioButtonUmPlanoClick(nil);
	PageCalibra.TabIndex := 1;

	for i := 1 to 8 do
		begin
			CamposLivresCal[i] := TLabeledEdit.Create(Self);
			CamposLivresCal[i].Parent := GroupBoxCliente;
			CamposLivresCal[i].Top := (lbledtOperador.Top + ((i) * 30));
			CamposLivresCal[i].Left := lbledtOperador.Left;
			CamposLivresCal[i].Width := lbledtOperador.Width;
			CamposLivresCal[i].EditLabel.Hint := 'Dois cliques para mudar o nome do campo.' + #13 +
				'Deixar vazio para não aparecer no relatório';
			CamposLivresCal[i].Hint := CamposLivresCal[i].EditLabel.Hint;
			CamposLivresCal[i].EditLabel.ShowHint := True;
			CamposLivresCal[i].Tag := i;
			CamposLivresCal[i].EditLabel.Tag := i;
			CamposLivresCal[i].EditLabel.Caption := 'Campo ' + IntToStr(i);
			CamposLivresCal[i].EditLabel.OnDblClick := EditLabelOnDblClick;
			CamposLivresCal[i].OnDblClick := EditLabelOnDblClick;
			CamposLivresCal[i].LabelPosition := lpLeft;
		end;

	S := IncludeTrailingBackslash(frmMain.GetSpecialFolderPath);
	S := IncludeTrailingBackslash(S) + 'Teknikao\NK700\';
	if ForceDirectories(S) then
		S := S + 'NK700.ini';
	IniCalibra := TIniFile.Create(S); // IncludeTrailingBackslash(ExtractFilePath(Application.ExeName)) + 'NK700.ini');
	with IniCalibra do
		begin
      S := 'Configuração';
			frmCalibra.ComboBoxISO.Text := ReadString(S, 'ISO', '6,3');
			FormOpcoes.cmbxPortaSerial.ComNumber := ReadInteger(S, 'COM Port', 0);
//			FormOpcoes.cmbxPortaSerialChange(nil);
      S := 'Opcoes';
			FormOpcoes.SpinEditCirculos.Value := ReadInteger(S, 'Circulos', 5);
			FormOpcoes.SpinEditEspessuraLinha.Value := ReadInteger(S, 'EspLinha', 2);
			FormOpcoes.ColorEditLinha.SelectedColor := ReadInteger(S, 'CorLinha', clGray);
			FormOpcoes.ColorEditFundo.SelectedColor := ReadInteger(S, 'CorFundo', clBtnFace);

			FormOpcoes.ColorEditAbaixoQuali.SelectedColor := ReadInteger(S, 'CorAbaixo', clRed);
			FormOpcoes.ColorEditAcimaQuali.SelectedColor := ReadInteger(S, 'CorAcima', clLime);
			FormOpcoes.SpinEditEspLinhaQuali.Value := ReadInteger(S, 'EspessTarget', 2);

			FormOpcoes.cmbxResidualStyle.ItemIndex := ReadInteger(S, 'PanelResidual Style', 0);
			FormOpcoes.cmbxResultadoStyle.ItemIndex := ReadInteger(S, 'PanelResultado Style', 0);
			FormOpcoes.cmbxDivisorStyle.ItemIndex := ReadInteger(S, 'PanelDivisor Style', 0);

			FormOpcoes.edtColorResidual1.SelectedColor := ReadInteger(S, 'PanelResidual CorInicial', clGray);
			FormOpcoes.edtColorResidual2.SelectedColor := ReadInteger(S, 'PanelResidual CorFinal', clGray);

			FormOpcoes.edtColorResultado1.SelectedColor := ReadInteger(S, 'PanelResultado CorInicial', clGray);
			FormOpcoes.edtColorResultado2.SelectedColor := ReadInteger(S, 'PanelResultado CorFinal', clGray);

			FormOpcoes.edtColorDivisor1.SelectedColor := ReadInteger(S, 'PanelDivisor CorInicial', clGray);
			FormOpcoes.edtColorDivisor2.SelectedColor := ReadInteger(S, 'PanelDivisor CorFinal', clGray);

			FormOpcoes.chckbx2Planos.Checked := ReadBool(S, 'CheckBox Alterações', False);

			FormOpcoes.chckbx2Planos.Checked := ReadBool(S, 'CheckBox Gost', False);
      FormOpcoes.chckbxPesoProva.Checked := ReadBool(S, 'CheckBox Peso Prova', True);
      FormOpcoes.chckbxValorInicial.Checked := ReadBool(S, 'CheckBox Valor Inicial', True);
      FormOpcoes.chckbxFixaPorta.Checked := ReadBool(S, 'Fixar Porta', False);

      S := 'Calibração';
      FormOpcoes.NumIOCalAmplitude1.Text := ReadString(S, 'Massa1', '0');
      FormOpcoes.NumIOCalAmplitude2.Text := ReadString(S, 'Massa2', '0');
      FormOpcoes.NumIOCalPhase1.Text := ReadString(S, 'Angulo1', '0');
      FormOpcoes.NumIOCalPhase2.Text := ReadString(S, 'Angulo2', '0');

      S := 'Saida';
			FormOpcoes.CheckBoxSaidaAtiva.Checked := ReadBool(S, 'Ativo', False);
			FormOpcoes.PortComboBoxSaida.ComNumber := ReadInteger(S, 'COM Port', 0);
			if FormOpcoes.PortComboBoxSaida.ComNumber <> 0 then
				try
				frmMain.ComPortSaida.ComNumber :=FormOpcoes.PortComboBoxSaida.ComNumber;
				frmMain.ComPortSaida.Open;
				except;
				end;

			FormOpcoes.ComboBoxBRsaida.Text := ReadString(S, 'Baud Rate', '9600');
			FormOpcoes.ComboBoxBaudRate.Text := ReadString(S, 'Baud Rate Main', '9600');

      FormOpcoes.ComboBoxBaudRateChange(nil);
			FormOpcoes.EditSaida.Text := ReadString(S, 'TextoSaida', '');

			with FormOpcoes do
				begin
					SpinEditEspessuraLinhaChange(nil);
					ColorEditLinhaChange(nil);
					ColorEditFundoChange(nil);
					cmbxResidualStyleChange(nil);
					EdtColorResidual1Change(nil);
					edtColorResidual2Change(nil);
					cmbxResultadoStyleChange(nil);
					edtColorResultado1Change(nil);
					edtColorResultado2Change(nil);
					cmbxDivisorStyleChange(nil);
					edtColorDivisor1Change(nil);
					edtColorDivisor2Change(nil);
					CheckBoxRIClick(nil);
				end;
		end;
	IniCalibra.Free;
end;

procedure TfrmCalibra.SpeedButtonLerClick(Sender: TObject);
begin
	if SpeedButtonLer.Down then
		begin
			SpeedButtonLer.Caption := 'Parar';
			ZeraMedia;
			// if (Sender <> nil) and (frmMain.VersaoHardware = 'USB') then
			// FormOpcoes.ButtonBuscaPortaClick(nil);
		end
	else
		SpeedButtonLer.Caption := 'Ler Vetores';
	SpeedButtonLer.Hint := SpeedButtonLer.Caption;
end;

procedure TfrmCalibra.FormKeyPress(Sender: TObject; var Key: Char);
begin
	if (Key = #13) and (SpeedButtonLer.Down = False) then
		SpeedButtonLer.Down := True
	else
		begin
			SpeedButtonLer.Down := False;
			SpeedButtonLer.Caption := 'Ler Vetores';
			exit;
		end;

	if (Key <> #13) and (SpeedButtonLer.Down = True) then
		exit;
	if (Key <> #13) and (SpeedButtonLer.Down = False) then
		begin
			SpeedButtonLer.Down := False;
			SpeedButtonLer.Caption := 'Ler Vetores';
			exit;
		end;
end;

procedure TfrmCalibra.RadioButtonUmPlanoClick(Sender: TObject);
begin
	GroupBoxMancal.Visible := RadioButtonUmPlano.Checked;
	tlbtnSimetria.Visible := RadioButtonDoisPlanos.Checked;
	FormOpcoes.chckbx2Planos.Visible := RadioButtonDoisPlanos.Checked;
	// CheckBoxmg.Visible := RadioButtonGramas.Checked or RadioButtonGmm.Checked;

	if RadioButtonDoisPlanos.Checked then
		begin
			TabBal2SM.TabVisible := True;
			TabBAl2PM1.TabVisible := True;
			TabBAl2PM2.TabVisible := True;
			grbPlano1SM.Visible := True;
			grbPlano2SM.Visible := True;
			grbPlano1M1.Visible := True;
			grbPlano2M1.Visible := True;
			grbPlano1M2.Visible := True;
			grbPlano2M2.Visible := True;
			grbPlano2RI.Visible := True;
		end
	else
		begin
			grbPlano1SM.Visible := RadioButtonMancal1.Checked;
			grbPlano2SM.Visible := RadioButtonMancal2.Checked;
			grbPlano1SM.Visible := RadioButtonMancal1.Checked;
			grbPlano2SM.Visible := RadioButtonMancal2.Checked;
			grbPlano1M1.Visible := RadioButtonMancal1.Checked;
			grbPlano2M1.Visible := RadioButtonMancal2.Checked;
			grbPlano1M2.Visible := RadioButtonMancal1.Checked;
			grbPlano2M2.Visible := RadioButtonMancal2.Checked;
			TabBAl2PM1.TabVisible := RadioButtonMancal1.Checked;
			TabBAl2PM2.TabVisible := RadioButtonMancal2.Checked;
			grbPlano2RI.Visible := RadioButtonMancal2.Checked;
		end;

	// CheckBoxRIClick(nil);
	if RadioButtonDoisPlanos.Checked then
		begin
			NumIOGramas1.Visible := RadioButtonGramas.Checked or RadioButtonGmm.Checked;
			NumIOGramas2.Visible := RadioButtonGramas.Checked or RadioButtonGmm.Checked;
			frmMain.Vectormeter[1].Visible := True;
			frmMain.Vectormeter[2].Visible := True;
		end
	else
		begin
			frmMain.Vectormeter[1].Visible := RadioButtonMancal1.Checked;
			frmMain.Vectormeter[2].Visible := RadioButtonMancal2.Checked;
			if not RadioButtonIso.Checked then
				begin
					NumIOGramas1.Visible := RadioButtonMancal1.Checked;
					NumIOGramas2.Visible := RadioButtonMancal2.Checked;
				end;
		end;

	lblPlano1.Visible := NumIOGramas1.Visible;
	lblPlano2.Visible := NumIOGramas2.Visible;
	ComboBoxISO.Visible := RadioButtonIso.Checked;
end;

function TfrmCalibra.FaltaDados(Campo: TNumIO; Fase: boolean; Aba: TRzTabSheet; Mss: AnsiString;
	Show: boolean): boolean;
begin
	if Fase then
		result := (Campo.Value < -360) or (Campo.Value > 360) or (Campo.Text = '')
	else
		result := (Campo.Value <= 0) or (Campo.Text = '');
	if result then
		begin
			PageCalibra.ActivePage := Aba;
			if Campo.Enabled then
				try
					Campo.SetFocus;
				except
					MessageBox(Handle, 'Você ainda não preencheu os dados de calibração!', 'Atenção', MB_ICONEXCLAMATION + MB_OK);
				end;
			Mss := 'Informe ' + Mss;
			if Fase then
				Mss := Mss + ' (-360º até 360º)';
			if Show then
				ShowMessage(Mss);
		end;
end;

function TfrmCalibra.ConfereDadosPlanos(Show: boolean): boolean;
Var
	Mess: string;
begin
	result := False;
	if RadioButtonIso.Checked or (FormOpcoes.RadioGroupResultado.ItemIndex = 1) then
		begin
			if ComboBoxISO.Text = '' then
				begin
					try
						PageCalibra.ActivePage := TabISO;
						ComboBoxISO.SetFocus;
						ShowMessage('Informe a Qualidade de' + #13 + 'Balanceamento');
					finally
					end;
					result := True;
					exit;
				end;
			if FaltaDados(NumIOPesoRotor, False, TabISO, 'o Peso do Rotor', Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIORPMTrabalho, False, TabISO, 'a Rotação de' + #13 + 'Trabalho do Rotor', Show) then
				begin
					result := True;
					exit;
				end;
		end; // button ISO

	if RadioButtonMancal1.Checked or RadioButtonDoisPlanos.Checked then
		begin
			if RadioButtonGramas.Checked then
				if FaltaDados(NumIOGramas1, False, TabISO, 'a Qualidade de' + #13 + 'Balanceamento em Gramas', Show) then
					begin
						result := True;
						exit;
					end;
			Mess := #13 + 'sem peso de prova';
			if FaltaDados(NumIOA1SM, False, TabBal2SM, 'a Amplitude' + Mess, Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIOF1SM, True, TabBal2SM, 'a Fase' + Mess, Show) then
				begin
					result := True;
					exit;
				end;
			Mess := #13 + 'com peso de prova';
			if FaltaDados(NumIOA1M1, False, TabBAl2PM1, 'a Amplitude' + Mess, Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIOF1M1, True, TabBAl2PM1, 'a Fase' + Mess, Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIOPesoM1, False, TabBAl2PM1, 'o Peso de Prova', Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIOAnguloM1, True, TabBAl2PM1, 'o ângulo do Peso de Prova', Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIODiv1, False, TabBAl2PM1, 'quantas divisões tem o Plano', Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIORaioM1, False, TabBAl2PM1, 'o Raio do Peso de Prova', Show) then
				begin
					result := True;
					exit;
				end;
		end;

	if RadioButtonMancal2.Checked or RadioButtonDoisPlanos.Checked then
		begin
			if RadioButtonGramas.Checked then
				if FaltaDados(NumIOGramas2, False, TabISO, 'a Qualidade de' + #13 + 'Balanceamento em Gramas', Show) then
					begin
						result := True;
						exit;
					end;
			Mess := #13 + 'sem peso de prova';
			if FaltaDados(NumIOA2SM, False, TabBal2SM, 'a Amplitude' + Mess, Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIOF2SM, True, TabBal2SM, 'a Fase' + Mess, Show) then
				begin
					result := True;
					exit;
				end;
			Mess := #13 + 'com peso de prova';
			if FaltaDados(NumIOA2M2, False, TabBAl2PM2, 'a Amplitude' + Mess, Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIOF2M2, True, TabBAl2PM2, 'a Fase' + Mess, Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIOPesoM2, False, TabBAl2PM2, 'o Peso de Prova', Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIOAnguloM2, True, TabBAl2PM2, 'o ângulo do Peso de Prova', Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIODiv2, False, TabBAl2PM2, 'quantas divisões tem o Plano', Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIORaioM2, False, TabBAl2PM2, 'o Raio do Peso de Prova', Show) then
				begin
					result := True;
					exit;
				end;
		end;

	if RadioButtonDoisPlanos.Checked then
		begin
			if FaltaDados(NumIOA1M2, False, TabBAl2PM2, 'a Amplitude do' + #13 + 'Plano 1', Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIOF1M2, True, TabBAl2PM2, 'a Fase do' + #13 + 'Plano 1', Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIOA2M1, False, TabBAl2PM1, 'a Amplitude do' + #13 + 'Plano 2', Show) then
				begin
					result := True;
					exit;
				end;
			if FaltaDados(NumIOF2M1, True, TabBAl2PM1, 'a Fase do' + #13 + 'Plano 1', Show) then
				begin
					result := True;
					exit;
				end;
		end; // dois planos
end;

procedure TfrmCalibra.Calcula_Ideal;
var
	t: single;
begin
	frmMain.ISO1940.UmPlano := not RadioButtonDoisPlanos.Checked;
	frmMain.ISO1940.RPM := NumIORPMTrabalho.Value;
	frmMain.ISO1940.Peso := NumIOPesoRotor.Value;
	frmMain.ISO1940.Raio1 := NumIORaioM1.Value;
	frmMain.ISO1940.Raio2 := NumIORaioM2.Value;

	if frmMain.Vectormeter[1].Raio = 0 then
		frmMain.Vectormeter[1].Raio := NumIORaioM1.Value;

	if frmMain.Vectormeter[2].Raio = 0 then
		frmMain.Vectormeter[2].Raio := NumIORaioM2.Value;

	if RadioButtonUmPlano.Checked Then
		begin
			if RadioButtonMancal1.Checked then
				frmMain.ISO1940.Raio2 := frmMain.ISO1940.Raio1
			else
				frmMain.ISO1940.Raio1 := frmMain.ISO1940.Raio2
		end;

	if RadioButtonIso.Checked then
		begin
			TryStrToFloat(trim(ComboBoxISO.Text), t);
			frmMain.ISO1940.ISOG := t;
			frmMain.ISO1940.CalcularQualidade;
			// gramas
			frmMain.Gramas.Ideal[1] := frmMain.ISO1940.ResidualPlano1;
			frmMain.Gramas.Ideal[2] := frmMain.ISO1940.ResidualPlano2;
			// gmm
			frmMain.Gmm.Ideal[1] := frmMain.ISO1940.ResidualPlanoPorPlanoGmm;
			frmMain.Gmm.Ideal[2] := frmMain.ISO1940.ResidualPlanoPorPlanoGmm;
			// ISOG
			frmMain.ISOG.Ideal[1] := frmMain.ISO1940.ISOG;
			frmMain.ISOG.Ideal[2] := frmMain.ISO1940.ISOG;
		end;

	if RadioButtonGramas.Checked then
		begin
			frmMain.Gramas.Ideal[1] := NumIOGramas1.Value;
			frmMain.Gramas.Ideal[2] := NumIOGramas2.Value;
			frmMain.Gmm.Ideal[1] := NumIOGramas1.Value * NumIORaioM1.Value;
			frmMain.ISOG.Ideal[1] := frmMain.ISO1940.CalcularISO(NumIOGramas1.Value, NumIORaioM1.Value);
			// para qual mancal???
			frmMain.Gmm.Ideal[2] := NumIOGramas2.Value * NumIORaioM2.Value;
			frmMain.ISOG.Ideal[2] := frmMain.ISO1940.CalcularISO(NumIOGramas2.Value, NumIORaioM2.Value);
		end;

	if RadioButtonGmm.Checked then
		begin
			frmMain.Gmm.Ideal[1] := NumIOGramas1.Value;
			frmMain.Gmm.Ideal[2] := NumIOGramas2.Value;

			if NumIORaioM1.Value > 0 then
				begin
					frmMain.Gramas.Ideal[1] := NumIOGramas1.Value / NumIORaioM1.Value;
					frmMain.ISOG.Ideal[1] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Ideal[1], NumIORaioM1.Value);
					// para qual mancal???
				end;

			if NumIORaioM2.Value > 0 then
				begin
					frmMain.Gramas.Ideal[2] := NumIOGramas2.Value / NumIORaioM2.Value;
					frmMain.ISOG.Ideal[2] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Ideal[2], NumIORaioM2.Value);
				end;
		end;
end;

procedure TfrmCalibra.FimCalibraClick(Sender: TObject);
// var
// t: single;
// Fator1, Fator2: single;
var
i: byte;
begin

  for i := 1 to High(frmMain.Vectormeter) do
    begin
    frmMain.Vectormeter[i].GhostAmplitude := 0;
    frmMain.Vectormeter[i].GhostPhase := 0;
    end;

	MediaPronta := True;
	frmMain.PrimeiraMedida := False;
	ContaMedia := StrToInt(frmMain.cmbxMedia.Text) + 1;
	SpeedButtonLer.Down := False;

	if ConfereDadosPlanos(True) then
		exit;

	Calcula_Ideal;

  if RadioButtonDoisPlanos.Checked then
		DoTwoPlaneBalance
	else
		DoSinglePlaneBalance;

	frmMain.Vectormeter[1].AutoScale := frmMain.tlbtnEscala.Down;
	frmMain.Vectormeter[2].AutoScale := frmMain.tlbtnEscala.Down;

	if RadioButtonMancal1.Checked or RadioButtonDoisPlanos.Checked then
		begin
			frmMain.ISOG.Inicial[1] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[1], NumIORaioM1.Value);
			// para o primeiro calculo de bal
			frmMain.Gmm.Inicial[1] := frmMain.Gramas.Final[1] * NumIORaioM1.Value;
			frmMain.CompareNorma(1);
			frmMain.MostraResultado(1);
		end;

	if RadioButtonMancal2.Checked or RadioButtonDoisPlanos.Checked then
		begin
			frmMain.ISOG.Inicial[2] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[2], NumIORaioM2.Value);
			frmMain.Gmm.Inicial[2] := frmMain.Gramas.Final[2] * NumIORaioM2.Value;
			frmMain.CompareNorma(2);
			frmMain.MostraResultado(2);
		end;

	SpeedButtonLer.Down := False;
	frmMain.AdvTrackBar.Max := AdvTrackBar.Max;
	frmCalibra.Close;

	frmMain.Medias := StrToInt(frmMain.cmbxMedia.Text);
  if FormOpcoes.chckbxPesoProva.Checked then
	  MessageBox(frmMain.Handle, 'Retirar peso de prova!', 'Informação', MB_OK);
  if FormOpcoes.chckbxValorInicial.Checked then
    frmMain.tlbtnValorInicialClick(nil);
	frmMain.tlbtnCalibrar.Down := False;


end;

procedure TfrmCalibra.CheckBoxmgClick(Sender: TObject);
begin
	frmMain.ISO1940.Miligramas := CheckBoxmg.Checked;
	if CheckBoxmg.Checked then
		begin
			RadioButtonGramas.Caption := 'mili Gramas';
			FormOpcoes.RadioGroupResultado.Items[0] := 'mili gramas';
			FormOpcoes.RadioGroupResultado.Items[2] := 'mili g.mm';
			LabelGramaMP1.Caption := 'Peso (mg)';
			if NumIOGramas1.Value > 0 then
				NumIOGramas1.Text := mysetformat(NumIOGramas1.Value * 1000);
			if NumIOGramas2.Value > 0 then
				NumIOGramas2.Text := mysetformat(NumIOGramas2.Value * 1000);
			if NumIOPesoM1.Value > 0 then
				NumIOPesoM1.Text := mysetformat(NumIOPesoM1.Value * 1000);
			if NumIOPesoM2.Value > 0 then
				NumIOPesoM2.Text := mysetformat(NumIOPesoM2.Value * 1000);
		end
	else
		begin
			RadioButtonGramas.Caption := 'Gramas';
			FormOpcoes.RadioGroupResultado.Items[0] := 'gramas';
			FormOpcoes.RadioGroupResultado.Items[2] := 'g.mm';
			LabelGramaMP1.Caption := 'Peso (g)';
			if NumIOGramas1.Value > 0 then
				NumIOGramas1.Text := mysetformat(NumIOGramas1.Value / 1000);
			if NumIOGramas2.Value > 0 then
				NumIOGramas2.Text := mysetformat(NumIOGramas2.Value / 1000);
			if NumIOPesoM1.Value > 0 then
				NumIOPesoM1.Text := mysetformat(NumIOPesoM1.Value / 1000);
			if NumIOPesoM2.Value > 0 then
				NumIOPesoM2.Text := mysetformat(NumIOPesoM2.Value / 1000);
		end;

	LabelGramaMP2.Caption := LabelGramaMP1.Caption;
end;

procedure TfrmCalibra.AbreCalClick(S: String);
var
	IniCalBal: TIniFile;
	i: byte;
begin
	IniCalBal := TIniFile.Create(S);
	with IniCalBal do
		begin
			S := 'Qualidade';
			RadioButtonIso.Checked := ReadBool(S, 'Iso', True);
			RadioButtonGramas.Checked := ReadBool(S, 'Gramas', False);
			RadioButtonGmm.Checked := ReadBool(S, 'Gmm', False);
			CheckBoxmg.Checked := ReadBool(S, 'mg', False);
			NumIOPesoRotor.Text := ReadString(S, 'PesoRotor', '');
			NumIORPMTrabalho.Text := ReadString(S, 'RPMRotor', '');
			ComboBoxISO.Text := ReadString(S, 'IsoG', '6,3');
			NumIOGramas1.Text := ReadString(S, 'PesoGramaP1', '');
			NumIOGramas2.Text := ReadString(S, 'PesoGramaP2', '');

			S := 'Balanceamento';
      NumIOPesoPadrao.Text := ReadString('Balanceamento', 'PesoPadrao', '0');
			frmMain.cmbxMedia.ItemIndex := ReadInteger(S, 'Medias', 1);
			RadioButtonDoisPlanos.Checked := ReadBool(S, 'Planos', True);
			RadioButtonUmPlano.Checked := not RadioButtonDoisPlanos.Checked;
			RadioButtonMancal1.Checked := ReadBool(S, 'Mancal1', True);
			TryStrToFloat(ReadString(S, 'RPMRef', '0'), RPMReferencia);
			LabelRPMRef.Caption := mysetformat(RPMReferencia) + ' RPM';

			S := 'Cliente';
			lbledtCliente.Text := ReadString(S, 'Nome', '');
			lbledtPeca.Text := ReadString(S, 'Peça', '');
			lbledtOperador.Text := ReadString(S, 'Operador', '');
			mmObs.Text := ReadString(S, 'Obs', '');
			FiguraRotor := ReadString(S, 'Figura', '');
			if FileExists(FiguraRotor) then
				begin
					imgPeca.Picture.LoadFromFile(FiguraRotor);
					LabelNomeFigura.Caption := ExtractFileName(FiguraRotor);
					LabelNomeFigura.Caption := StringReplace(LabelNomeFigura.Caption, ExtractFileExt(FiguraRotor), '',
						[rfReplaceAll]);
				end
			else
				LabelNomeFigura.Caption := 'Figura não encontrada!';

			for i := Low(CamposLivresCal) to High(CamposLivresCal) do
				begin
					CamposLivresCal[i].Text := ReadString('Campo' + IntToStr(i), 'Texto', ''); // so se exitir
					CamposLivresCal[i].EditLabel.Caption := ReadString('Campo' + IntToStr(i), 'Titulo', '');
				end;

			S := 'Residual';
			FormOpcoes.CheckBoxRI.Checked := ReadBool(S, 'Usar', False);
			NumIOA1RI.Text := ReadString(S, 'A1RI', '0');
			NumIOF1RI.Text := ReadString(S, 'F1RI', '0');
			NumIOA2RI.Text := ReadString(S, 'A2RI', '0');
			NumIOF2RI.Text := ReadString(S, 'F2RI', '0');

			// vetores 2 planos
			S := 'Vetores';
			NumIOA1SM.Text := ReadString(S, 'Plano1SM Amp', '');
			NumIOF1SM.Text := ReadString(S, 'Plano1SM Fase', '');
			NumIOA2SM.Text := ReadString(S, 'Plano2SM Amp', '');
			NumIOF2SM.Text := ReadString(S, 'Plano2SM Fase', '');
			NumIOA1M1.Text := ReadString(S, 'Plano1M1 Amp', '');
			NumIOF1M1.Text := ReadString(S, 'Plano1M1 Fase', '');
			NumIOA2M1.Text := ReadString(S, 'Plano2M1 Amp', '');
			NumIOF2M1.Text := ReadString(S, 'Plano2M1 Fase', '');
			NumIOA1M2.Text := ReadString(S, 'Plano1M2 Amp', '');
			NumIOF1M2.Text := ReadString(S, 'Plano1M2 Fase', '');
			NumIOA2M2.Text := ReadString(S, 'Plano2M2 Amp', '');
			NumIOF2M2.Text := ReadString(S, 'Plano2M2 Fase', '');
			// peso 2 planos
			// plano1
			S := 'Massa';
			NumIOPesoM1.Text := ReadString(S, 'PesoP1', '');
			NumIOAnguloM1.Text := ReadString(S, 'AnguloP1', '');
			NumIORaioM1.Text := ReadString(S, 'RaioP1', '');
			NumIODiv1.Text := ReadString(S, 'DivP1', '');
			// plano2
			NumIOPesoM2.Text := ReadString(S, 'PesoP2', '');
			NumIOAnguloM2.Text := ReadString(S, 'AnguloP2', '');
			NumIORaioM2.Text := ReadString(S, 'RaioP2', '');
			NumIODiv2.Text := ReadString(S, 'DivP2', '');

			if RPMReferencia > 0 then
				begin
					AdvTrackBar.Min := Round(RPMReferencia * 0.75);
					AdvTrackBar.Max := Round(RPMReferencia) + Round(RPMReferencia * 0.25);
					frmMain.AdvTrackBar.Max := AdvTrackBar.Max;
					frmMain.AdvTrackBar.Min := AdvTrackBar.Min;
					AdvTrackBar.Position := Round(frmMain.Rotacao);
				end;

			S := ReadString('Relatorio', 'Nome', '');
			if S <> '' then
				begin
					S := IncludeTrailingBackslash(ExtractFileDir(S));
					if DirectoryExists(S) then
						frmRelatorio.DirectoryModeloRelatorio.Text := S;
					S := ReadString('Relatorio', 'Nome', '');
					S := ExtractFileName(S);
					// lstvwRelatorio.SetFocus;
					frmRelatorio.lstvwRelatorio.Selected := frmRelatorio.lstvwRelatorio.FindCaption(0, S, False, True, True);
					frmRelatorio.lstvwRelatorioClick(nil);
					frmRelatorio.lstvwRelatorio.Selected.Focused := True;
				end;
		end;
	IniCalBal.Free;
	frmMain.pnFilePath.Caption := ExtractFileName(OpenDialog.FileName);
	frmMain.pnFilePath.Caption := StringReplace(frmMain.pnFilePath.Caption, ExtractFileExt(OpenDialog.FileName), '',
		[rfReplaceAll]);
	// RadioButtonIsoClick(nil);
end;

procedure TfrmCalibra.ButtonAbreCalClick(Sender: TObject);
begin
	if not OpenDialog.Execute then
		exit;
	AbreCalClick(OpenDialog.FileName);
end;

procedure TfrmCalibra.imgPecaDblClick(Sender: TObject);
begin
	if not OpenPictureDialog.Execute then
		exit;
	FiguraRotor := OpenPictureDialog.FileName;
	imgPeca.Picture.LoadFromFile(OpenPictureDialog.FileName);
	LabelNomeFigura.Caption := ExtractFileName(FiguraRotor);
	LabelNomeFigura.Caption := StringReplace(LabelNomeFigura.Caption, ExtractFileExt(FiguraRotor), '', [rfReplaceAll]);
end;

procedure TfrmCalibra.ButtonSalvaCalClick(Sender: TObject);
var
	IniCalBal: TIniFile;
	i: byte;
begin
	if RadioButtonDoisPlanos.Checked then
		if ConfereDadosPlanos(True) then
			exit;
	// fazer para um plano
	if not SaveDialog.Execute then
		exit;
	IniCalBal := TIniFile.Create(SaveDialog.FileName);
	with IniCalBal do
		begin
			WriteBool('Qualidade', 'Iso', RadioButtonIso.Checked);
			WriteBool('Qualidade', 'Gramas', RadioButtonGramas.Checked);
			WriteBool('Qualidade', 'Gmm', RadioButtonGmm.Checked);
			WriteBool('Qualidade', 'mg', CheckBoxmg.Checked);
			WriteString('Qualidade', 'PesoRotor', NumIOPesoRotor.Text);
			WriteString('Qualidade', 'RPMRotor', NumIORPMTrabalho.Text);
			WriteString('Qualidade', 'IsoG', ComboBoxISO.Text);
			WriteString('Qualidade', 'PesoGramaP1', NumIOGramas1.Text);
			WriteString('Qualidade', 'PesoGramaP2', NumIOGramas2.Text);

			WriteInteger('Balanceamento', 'Medias', frmMain.cmbxMedia.ItemIndex);
			WriteBool('Balanceamento', 'Planos', RadioButtonDoisPlanos.Checked);
			WriteBool('Balanceamento', 'Mancal1', RadioButtonMancal1.Checked);
      WriteString('Balanceamento', 'PesoPadrao', NumIOPesoPadrao.Text);

			WriteString('Balanceamento', 'RPMRef', mysetformat(RPMReferencia));
			WriteString('Cliente', 'Nome', lbledtCliente.Text);
			WriteString('Cliente', 'Peça', lbledtPeca.Text);
			WriteString('Cliente', 'Operador', lbledtOperador.Text);
			WriteString('Cliente', 'Obs', mmObs.Text);
			WriteString('Cliente', 'Figura', FiguraRotor);

			for i := Low(CamposLivresCal) to High(CamposLivresCal) do
				begin
					WriteString('Campo' + IntToStr(i), 'Texto', CamposLivresCal[i].Text); // so se exitir
					WriteString('Campo' + IntToStr(i), 'Titulo', CamposLivresCal[i].EditLabel.Caption);
				end;

			writeBool('Residual', 'Usar', FormOpcoes.CheckBoxRI.Checked);
			WriteString('Residual', 'A1RI', NumIOA1RI.Text);
			WriteString('Residual', 'F1RI', NumIOF1RI.Text);
			WriteString('Residual', 'A2RI', NumIOA2RI.Text);
			WriteString('Residual', 'F2RI', NumIOF2RI.Text);

			// vetores 2 planos
			WriteString('Vetores', 'Plano1SM Amp', NumIOA1SM.Text);
			WriteString('Vetores', 'Plano1SM Fase', NumIOF1SM.Text);
			WriteString('Vetores', 'Plano2SM Amp', NumIOA2SM.Text);
			WriteString('Vetores', 'Plano2SM Fase', NumIOF2SM.Text);
			WriteString('Vetores', 'Plano1M1 Amp', NumIOA1M1.Text);
			WriteString('Vetores', 'Plano1M1 Fase', NumIOF1M1.Text);
			WriteString('Vetores', 'Plano2M1 Amp', NumIOA2M1.Text);
			WriteString('Vetores', 'Plano2M1 Fase', NumIOF2M1.Text);
			WriteString('Vetores', 'Plano1M2 Amp', NumIOA1M2.Text);
			WriteString('Vetores', 'Plano1M2 Fase', NumIOF1M2.Text);
			WriteString('Vetores', 'Plano2M2 Amp', NumIOA2M2.Text);
			WriteString('Vetores', 'Plano2M2 Fase', NumIOF2M2.Text);
			// peso 2 planos
			// plano1
			WriteString('Massa', 'PesoP1', NumIOPesoM1.Text);
			WriteString('Massa', 'AnguloP1', NumIOAnguloM1.Text);
			WriteString('Massa', 'RaioP1', NumIORaioM1.Text);
			WriteString('Massa', 'DivP1', NumIODiv1.Text);
			// plano2
			WriteString('Massa', 'PesoP2', NumIOPesoM2.Text);
			WriteString('Massa', 'AnguloP2', NumIOAnguloM2.Text);
			WriteString('Massa', 'RaioP2', NumIORaioM2.Text);
			WriteString('Massa', 'DivP2', NumIODiv2.Text);
		end;
	IniCalBal.Free;
end;

procedure TfrmCalibra.tlbtnSimetriaClick(Sender: TObject);
begin
	NumIOPesoM2.Text := NumIOPesoM1.Text;
	NumIOAnguloM2.Text := NumIOAnguloM1.Text;
	NumIORaioM2.Text := NumIORaioM1.Text;
	// NumIORaioPP2.Text := NumIORaioPP1.Text;
	NumIODiv2.Text := NumIODiv1.Text;
end;

procedure TfrmCalibra.AdvTrackBarChange(Sender: TObject);
begin
	AdvTrackBar.Repaint;
end;

end.
