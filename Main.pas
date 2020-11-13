unit Main;

interface

uses
	// FastMM4,
	Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
	ExtCtrls, AfDataDispatcher, AfComPort, ComCtrls, StdCtrls, Buttons, RzEdit,
	AfPortControls, IniFiles, ImgList, RzPanel, RzButton, RzFilSys,
	PngImageList, RzCommon, Mask, RzTrkBar, StrUtils,
	RzLabel, Geral, RzStatus, RzTabs, Menus, RzPopups, ISO1940, AdvTrackBar, Math,
	RzCmboBx, ShellAPI, RzRadChk, SHFolder, Fourier, Vectormeter, USBID, NumIO,
	JvComponentBase, JvHidControllerClass, JvExControls, JvComCtrls, Spin;

type
	TCopyDataType = (cdtString = 0, cdtImage = 1, cdtRecord = 2);

type
	TValores = record
		Inicial: array [1 .. 2] of single;
		Final: array [1 .. 2] of single;
		Ideal: array [1 .. 2] of single;
	end;

type
	THIDBytes = array [0 .. 64] of Byte;

type
	TfrmMain = class(TForm)
		ComPort: TAfComPort;
		TimerTempoporta: TTimer;
		rztlbrMain: TRzToolbar;
		tlbtnEscala: TRzToolButton;
		tlbtnCalibrar: TRzToolButton;
		tlbtnValorInicial: TRzToolButton;
		tlbtnSobre: TRzToolButton;
		tlbtnAjuda: TRzToolButton;
		tlbtnValorFinal: TRzToolButton;
		PngImageList32: TPngImageList;
		PngImageList48: TPngImageList;
		RzSpacer1: TRzSpacer;
		RzSpacer5: TRzSpacer;
		RzSpacer6: TRzSpacer;
		RzSpacer7: TRzSpacer;
		RzSpacer9: TRzSpacer;
		RzSpacer10: TRzSpacer;
		RzSpacer11: TRzSpacer;
		stsbrMain: TRzStatusBar;
		pnSerialPort: TRzStatusPane;
		pnFilePath: TRzStatusPane;
		ISO1940: TISO1940;
		PanelRPM: TRzPanel;
		LabelRotacaoMain: TRzLabel;
		AdvTrackBar: TAdvTrackBar;
		pnlClient: TRzPanel;
		PanelMedia: TRzPanel;
		lblMedia: TRzLabel;
		cmbxMedia: TComboBox;
		StatusPaneMess: TRzStatusPane;
		pnlPlano1: TRzPanel;
		pnlPlano2: TRzPanel;
		ToolButtonRefazMedia: TRzToolButton;
		RzSpacer2: TRzSpacer;
		RzSpacer3: TRzSpacer;
		ToolButtonOpcoes: TRzToolButton;
		ToolButtonRelatorio: TRzToolButton;
		RzSpacer4: TRzSpacer;
		SaveDialogDados: TSaveDialog;
		RzStatusCalibra: TRzStatusPane;
		ComPortSaida: TAfComPort;
		PopupMenuReport: TPopupMenu;
		NovoRelatrio1: TMenuItem;
		novoModelo1: TMenuItem;
		PngImageList16: TPngImageList;
		RzSpacer8: TRzSpacer;
		lblEstab: TRzLabel;
		btnTurnOff: TRzToolButton;
		RzSpacer12: TRzSpacer;
		HidDeviceController: TJvHidDeviceController;
    SpinEditTime: TSpinEdit;
    TimerIgnoraMedidas: TTimer;

		procedure FormCreate(Sender: TObject);
		procedure ComPortDataRecived(Sender: TObject; Count: Integer);
		procedure TimerTempoportaTimer(Sender: TObject);
		procedure FormClose(Sender: TObject; var Action: TCloseAction);
		procedure cmbxMediaChange(Sender: TObject);
		procedure tlbtnEscalaClick(Sender: TObject);
		procedure tlbtnCalibrarClick(Sender: TObject);
		procedure tlbtnValorInicialClick(Sender: TObject);
		procedure tlbtnSobreClick(Sender: TObject);
		procedure tlbtnValorFinalClick(Sender: TObject);
		procedure FormResize(Sender: TObject);
		procedure Vectormeter1ArcClick(Sender: TObject);
		procedure Vectormeter2ArcClick(Sender: TObject);
		procedure Vectormeter2InvertAngleClick(Sender: TObject);
		procedure Vectormeter1InvertAngleClick(Sender: TObject);
		procedure Vectormeter1MassDividerClick(Sender: TObject);
		procedure Vectormeter2MassDividerClick(Sender: TObject);
		procedure Vectormeter1RightClick(Sender: TObject);
		procedure Vectormeter2RightClick(Sender: TObject);
		procedure FormPaint(Sender: TObject);
		procedure MostraResultado(Plano: Byte);
		procedure Vectormeter1TrackScaleChange(Sender: TObject);

		procedure FormActivate(Sender: TObject);
		procedure tlbtnAjudaClick(Sender: TObject);
		procedure ToolButtonRefazMediaClick(Sender: TObject);
		procedure ToolButtonOpcoesClick(Sender: TObject);
		procedure ToolButtonRelatorioClick(Sender: TObject);
		procedure VectorKeyPress(Sender: TObject; var Key: Char);
		procedure ComPortSaidaDataRecived(Sender: TObject; Count: Integer);
		procedure novoModelo1Click(Sender: TObject);
		procedure NovoRelatrio1Click(Sender: TObject);
		procedure TouchKeyBoardEnter(Sender: TObject);
		procedure btnTurnOffClick(Sender: TObject);
		function HidDeviceControllerEnumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
    procedure HidDeviceControllerArrival(HidDev: TJvHidDevice);
    procedure HidDeviceControllerDeviceUnplug(HidDev: TJvHidDevice);
    procedure TimerIgnoraMedidasTimer(Sender: TObject);
	private
		function VerifyRPM: Boolean;
		procedure Get_Vetor(S: String);
		procedure DefineRPM;
		// procedure RefinaRaio;
		procedure Seta_Rele;
		procedure TrataSaida;
		procedure StringToBytes(const S: string; var Bytes: THIDBytes);
    procedure Vectormeter1DownClick(Sender: TObject);
    procedure Vectormeter2DownClick(Sender: TObject);

	public
		CurrentDevice: TJvHidDevice;
		ListaHID: TStringList;
		Vectormeter: array [1 .. 2] of TVectormeter;
		VetorMedioP1, VetorMedioP2: TVetorMedio;
		VetorRI1, VetorRi2: Tvetor;
		VetorAjuste1, VetorAjuste2: Tvetor;
		LastV1, LastV2: Tvetor;
		Rotacao: single;
		Medias: Byte;
		VersaoHardware: String;
		Logotipo: String;
		Respondeu: Boolean;
		HasParams: Boolean;
		gmm, ISOG, Gramas, Fase: TValores;
		UsbDevice: TUsbClass;
		GhostFilled, EstabOk: Boolean;
		EnviouRele, PrimeiraMedida: Boolean;
		procedure RefinaManual(A1, F1, A2, F2: single);
		procedure CompareNorma(Plano: Byte);
		function ProfundidadeFuro(Diametro, Massa, Densidade: single): single;
		function GetSpecialFolderPath: string;
		procedure USBConectou(AObject: TObject; const ADevType, ADriverName, AFriendlyName: string);
		procedure USBDesconectou(AObject: TObject; const ADevType, ADriverName, AFriendlyName: string);

	published
		procedure ShowRead(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
	end;

function IsPwrShutdownAllowed: Boolean; stdcall; external 'powrprof.dll' name 'IsPwrShutdownAllowed';

const
	SE_CREATE_TOKEN_NAME = 'SeCreateTokenPrivilege';
	SE_ASSIGNPRIMARYTOKEN_NAME = 'SeAssignPrimaryTokenPrivilege';
	SE_LOCK_MEMORY_NAME = 'SeLockMemoryPrivilege';
	SE_INCREASE_QUOTA_NAME = 'SeIncreaseQuotaPrivilege';
	SE_UNSOLICITED_INPUT_NAME = 'SeUnsolicitedInputPrivilege';
	SE_MACHINE_ACCOUNT_NAME = 'SeMachineAccountPrivilege';
	SE_TCB_NAME = 'SeTcbPrivilege';
	SE_SECURITY_NAME = 'SeSecurityPrivilege';
	SE_TAKE_OWNERSHIP_NAME = 'SeTakeOwnershipPrivilege';
	SE_LOAD_DRIVER_NAME = 'SeLoadDriverPrivilege';
	SE_SYSTEM_PROFILE_NAME = 'SeSystemProfilePrivilege';
	SE_SYSTEMTIME_NAME = 'SeSystemtimePrivilege';
	SE_PROF_SINGLE_PROCESS_NAME = 'SeProfileSingleProcessPrivilege';
	SE_INC_BASE_PRIORITY_NAME = 'SeIncreaseBasePriorityPrivilege';
	SE_CREATE_PAGEFILE_NAME = 'SeCreatePagefilePrivilege';
	SE_CREATE_PERMANENT_NAME = 'SeCreatePermanentPrivilege';
	SE_BACKUP_NAME = 'SeBackupPrivilege';
	SE_RESTORE_NAME = 'SeRestorePrivilege';
	SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
	SE_DEBUG_NAME = 'SeDebugPrivilege';
	SE_AUDIT_NAME = 'SeAuditPrivilege';
	SE_SYSTEM_ENVIRONMENT_NAME = 'SeSystemEnvironmentPrivilege';
	SE_CHANGE_NOTIFY_NAME = 'SeChangeNotifyPrivilege';
	SE_REMOTE_SHUTDOWN_NAME = 'SeRemoteShutdownPrivilege';
	SE_UNDOCK_NAME = 'SeUndockPrivilege';
	SE_SYNC_AGENT_NAME = 'SeSyncAgentPrivilege';
	SE_ENABLE_DELEGATION_NAME = 'SeEnableDelegationPrivilege';
	SE_MANAGE_VOLUME_NAME = 'SeManageVolumePrivilege';

var
	frmMain: TfrmMain;
	ContaMedia: Integer;
  ContaMedidasFalsas: integer;
	LendoAtivo, MediaPronta: Boolean;
	TempoK0: Integer;
	Track: TRzTrackBar;
	Popup: TRzPopupPanel;
	Line, LastLine: string;
	PanelFuro: TRzPopupPanel;
	cmbxDensidade: TRzCombobox;
	edtCalc: TRzNumericEdit;
	btnClose: TRzButton;
	LineSaida, LastLineSaida: string;
	AchouNK700: Boolean;
	AnguloGhost1: single;
	AnguloGhost2: single;

const
	Escala: array [0 .. 25] of single = (0.005, 0.01, 0.02, 0.05, 0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000,
		50000, 100000, 200000, 500000, 1000000);
  USBVID = $04D8;
  USBPID = $F1A5;

implementation

//{$DEFINE ENABLE_TIMER_MEDIDAS}

{$R *.DFM}

uses Sobre, uCalibra, uOpcoes, uRelatorio, uReport, uWizReport; // , uTeclado;

function NTSetPrivilege(sPrivilege: string; bEnabled: Boolean): Boolean;
var
	hToken: THandle;
	TokenPriv: TOKEN_PRIVILEGES;
	PrevTokenPriv: TOKEN_PRIVILEGES;
	ReturnLength: Cardinal;
begin
	Result := True;
	// Only  for  Windows  NT/2000/XP  and  later.
	if not(Win32Platform = VER_PLATFORM_WIN32_NT) then
		Exit;
	Result := False;

	// obtain  the  processes  token
	if OpenProcessToken(GetCurrentProcess(), TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, hToken) then
		begin
			try
				// Get  the  locally  unique  identifier  (LUID)  .
				if LookupPrivilegeValue(nil, PChar(sPrivilege), TokenPriv.Privileges[0].Luid) then
					begin
						TokenPriv.PrivilegeCount := 1; // one  privilege  to  set

						case bEnabled of
							True:
								TokenPriv.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
							False:
								TokenPriv.Privileges[0].Attributes := 0;
						end;

						ReturnLength := 0; // replaces  a  var  parameter
						PrevTokenPriv := TokenPriv;

						// enable  or  disable  the  privilege

						AdjustTokenPrivileges(hToken, False, TokenPriv, SizeOf(PrevTokenPriv), PrevTokenPriv, ReturnLength);
					end;
			finally
				CloseHandle(hToken);
			end;
		end;
	// test  the  return  value  of  AdjustTokenPrivileges.
	Result := GetLastError = ERROR_SUCCESS;
	if not Result then
		raise Exception.Create(SysErrorMessage(GetLastError));
end;

procedure machine_poweroff;
const
	SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
	if IsPwrShutdownAllowed then
		begin
			NTSetPrivilege(SE_SHUTDOWN_NAME, True);
			ExitWindowsEx(EWX_POWEROFF or EWX_FORCE, 0);
		end
	// else
	// MessageDlg('Soft Power Off not supported on this system.', mtWarning, [mbOK], 0);
end;

procedure TfrmMain.TouchKeyBoardEnter(Sender: TObject);
begin
	{ if FormOpcoes.chckKeyboard.checked then
		begin
		frmkeyboard.show;
		frmkeyboard.MyTouchKeyboard.Layout := 'NumPad';
		end; }
end;

procedure TfrmMain.Seta_Rele;
var
	R: Boolean;
	S: String;
begin
	if frmCalibra.RadioButtonDoisPlanos.Checked then
		R := (Gramas.Final[1] < Gramas.Ideal[1]) and (Gramas.Final[2] < Gramas.Ideal[2])
	else
		begin
			if frmCalibra.RadioButtonMancal1.Checked then
				R := (Gramas.Final[1] < Gramas.Ideal[1])
			else
				R := (Gramas.Final[2] < Gramas.Ideal[2])
		end;
	if R then
		S := '1'
	else
		S := '0';
	S := 'RELE' + S + #13;
	if ComPort.Active then
		ComPort.WriteString(S);
end;

procedure TfrmMain.USBConectou(AObject: TObject; const ADevType, ADriverName, AFriendlyName: string);
begin
	if AnsiContainsStr(ADevType, 'USB Serial Converter') or ((AnsiContainsStr(ADevType, 'Communications Port')) and (VersaoHardware = 'USB')) then
    begin
    FormOpcoes.Habilita_Serial(True);
		FormOpcoes.ButtonBuscaPortaClick(nil);
    end;

	//if Pos('hid.devicedesc', ADevType) > 0 then
		//HidDeviceController.Enumerate;
end;

procedure TfrmMain.USBDesconectou(AObject: TObject; const ADevType, ADriverName, AFriendlyName: string);
var
	Value: Byte;
begin
	if (AnsiContainsStr(ADevType, 'Communications Port')) or (AnsiContainsStr(ADevType, 'Porta de Comunicação NK700')) then
		ComPort.Close;

	{if Pos('hid.devicedesc', ADevType) > 0 then
		begin
			try
				if CurrentDevice <> nil then
					begin
						HidDeviceController.CheckIn(CurrentDevice);
						CurrentDevice := nil;
					end;
				HidDeviceController.Enumerate;
				FormOpcoes.Habilita_Serial(True);
				Respondeu := False;
				AchouNK700 := False;
				pnSerialPort.Caption := 'Porta HID Desconectada';
				FormOpcoes.StatusPaneOpcoes.Caption := 'NK700 Removido';
				frmCalibra.SpeedButtonLer.Enabled := false;
			except
				;
			end;
		end;}
end;

{ procedure TfrmMain.RefinaRaio;
	Var
	V1, V2 : TVetor;
	begin
	V1.Amp := Vectormeter[1].Amplitude;
	V1.Fase := Vectormeter[1].Phase;
	V2.Amp := Vectormeter[2].Amplitude;
	V2.Fase := Vectormeter[2].Phase;

	if frmCalibra.RadioButtonDoisPlanos.Checked then
	begin
	if (V1.Amp <= 0) or (V2.Amp <= 0)
	or (V1.Fase < -360) or (V2.Fase < -360)
	or (V1.Fase > 360) or (V2.Fase > 360)
	then exit;
	if not GhostFilled then
	begin
	Vectormeter[1].GhostScale := Vectormeter[1].Scale;
	Vectormeter[2].GhostScale := Vectormeter[2].Scale;

	Vectormeter[1].GhostPhase := fase.final[1];
	Vectormeter[1].GhostAmplitude := gramas.final[1];
	Vectormeter[2].GhostPhase := fase.final[2];
	Vectormeter[2].GhostAmplitude := gramas.final[2];
	end;
	Refinamento2(V1, V2);
	MostraResultado(1);
	MostraResultado(2);
	CompareNorma(1);
	CompareNorma(2);
	end
	else
	begin
	if frmCalibra.RadioButtonMancal1.Checked then
	begin
	if (V1.Amp <= 0) or (V1.Fase < -360) or (V1.Fase > 360) then exit;
	if not GhostFilled then
	begin
	Vectormeter[1].GhostScale := Vectormeter[1].Scale;
	Vectormeter[1].GhostPhase := fase.final[1];
	Vectormeter[1].GhostAmplitude := gramas.final[1];
	end;
	Refina1(V1);
	MostraResultado(1);
	CompareNorma(1);
	end
	else
	begin
	if (V2.Amp <= 0) or (V2.Fase < -360) or (V2.Fase > 360) then exit;
	Vectormeter[2].GhostScale := Vectormeter[2].Scale;
	Vectormeter[2].GhostPhase := fase.final[2];
	Vectormeter[2].GhostAmplitude := gramas.final[2];
	Refina1(V2);
	MostraResultado(2);
	CompareNorma(2);
	end;
	end;
	Seta_Rele;
	end; }

procedure TfrmMain.RefinaManual(A1, F1, A2, F2: single);
Var
	V1, V2, Ajuste1, Ajuste2: Tvetor;
begin
	V1.Amp := A1; // Vectormeter[1].EditAmplitude.Value;
	V1.Fase := F1; // Vectormeter[1].EditFase.Value;
	V2.Amp := A2; // Vectormeter[2].EditAmplitude.Value;
	V2.Fase := F2; // Vectormeter[2].EditFase.Value;

	GhostFilled := False;

	if (FormOpcoes.NumIOCalAmplitude1.Text <> '') and (FormOpcoes.NumIOCalPhase1.Text <> '') then
		begin
			Ajuste1.Amp := FormOpcoes.NumIOCalAmplitude1.Value;
			Ajuste1.Fase := FormOpcoes.NumIOCalPhase1.Value;
			V1 := subvetor(V1, Ajuste1);
		end;

	if (FormOpcoes.NumIOCalAmplitude2.Text <> '') and (FormOpcoes.NumIOCalPhase2.Text <> '') then
		begin
			Ajuste2.Amp := FormOpcoes.NumIOCalAmplitude2.Value;
			Ajuste2.Fase := FormOpcoes.NumIOCalPhase2.Value;
			V2 := subvetor(V2, Ajuste2);
		end;

	if frmCalibra.RadioButtonDoisPlanos.Checked then
		begin
			if (V1.Amp < 0) or (V2.Amp < 0) or (V1.Fase < -360) or (V2.Fase < -360) or (V1.Fase > 360) or (V2.Fase > 360) then
				Exit;

			if not GhostFilled then
				begin
					Vectormeter[1].GhostScale := Vectormeter[1].Scale;
					Vectormeter[2].GhostScale := Vectormeter[2].Scale;
					Vectormeter[1].GhostPhase := Vectormeter[1].Phase; // fase.final[1];
					Vectormeter[1].GhostAmplitude := Vectormeter[1].Amplitude;
					// gramas.final[1];
					Vectormeter[2].GhostPhase := Vectormeter[2].Phase; // fase.final[2];
					Vectormeter[2].GhostAmplitude := Vectormeter[2].Amplitude;
					// gramas.final[2];
				end;
			Refinamento2(V1, V2);
			MostraResultado(1);
			MostraResultado(2);
			CompareNorma(1);
			CompareNorma(2);
		end
	else
		begin
			if frmCalibra.RadioButtonMancal1.Checked then
				begin
					if (V1.Amp < 0) or (V1.Fase < -360) or (V1.Fase > 360) then
						Exit;

					if not GhostFilled then
						begin
							Vectormeter[1].GhostScale := Vectormeter[1].Scale;
							Vectormeter[1].GhostPhase := Vectormeter[1].Phase; // Fase.final[1];
							Vectormeter[1].GhostAmplitude := Vectormeter[1].Amplitude; // Gramas.final[1];
						end;
					Refina1(V1);
					MostraResultado(1);
					CompareNorma(1);
				end
			else
				begin
					if (V2.Amp < 0) or (V2.Fase < -360) or (V2.Fase > 360) then
						Exit;

					if not GhostFilled then
						begin
							Vectormeter[2].GhostScale := Vectormeter[2].Scale;
							Vectormeter[2].GhostPhase := Vectormeter[2].Phase; // Fase.final[2];
							Vectormeter[2].GhostAmplitude := Vectormeter[2].Amplitude; // Gramas.final[2];
						end;
					Refina1(V2);
					MostraResultado(2);
					CompareNorma(2);
				end;
		end;
	Seta_Rele;
	GhostFilled := True;
end;

procedure TfrmMain.MostraResultado(Plano: Byte);
begin
	Vectormeter[Plano].InvertAngle := Vectormeter[Plano].ButtonInvertAngle.Down;
	// se o ângulo é invertido
	if Vectormeter[Plano].InvertAngle then
		Vectormeter[Plano].MarkColor := clRed
	else
		Vectormeter[Plano].MarkColor := clBlack;

	if Vectormeter[Plano].ButtonArc.Down then
		begin
			Vectormeter[Plano].UnitType := utArc;
			Vectormeter[Plano]._Unit := ' arco';
		end
	else
		begin
			Vectormeter[Plano].UnitType := utAngle;
			Vectormeter[Plano]._Unit := ' graus';
		end;

	Vectormeter[Plano].PanelResultado.Font.Color := Vectormeter[Plano].MarkColor;
	Vectormeter[Plano].PanelDivisor.Font.Color := Vectormeter[Plano].MarkColor;

	if Vectormeter[Plano].MassDivider then
		begin
      if Vectormeter[Plano].ButtonDown.Down then
        Vectormeter[Plano].PanelDivisor.Caption := MySetFormat(Vectormeter[Plano].Mass1/Vectormeter[Plano].PesoPadrao)
      else
        Vectormeter[Plano].PanelDivisor.Caption := MySetFormat(Vectormeter[Plano].Mass1);

			if frmCalibra.CheckBoxmg.Checked then
				Vectormeter[Plano].PanelDivisor.Caption := Vectormeter[Plano].PanelDivisor.Caption + 'm';

			if Vectormeter[Plano].ButtonDown.Down then
			  Vectormeter[Plano].PanelDivisor.Caption := Vectormeter[Plano].PanelDivisor.Caption + 'unidades '
      else
        Vectormeter[Plano].PanelDivisor.Caption := Vectormeter[Plano].PanelDivisor.Caption + 'g ';

			if Vectormeter[Plano].ButtonArc.Down then
				Vectormeter[Plano].PanelDivisor.Caption := Vectormeter[Plano].PanelDivisor.Caption + ' no arco ' + IntToStr(Vectormeter[Plano].Arc1)
			else
				Vectormeter[Plano].PanelDivisor.Caption := Vectormeter[Plano].PanelDivisor.Caption + 'a ' + IntToStr(Round(Vectormeter[Plano].Angle1))
					+ Vectormeter[Plano]._Unit;

			if Vectormeter[Plano].ButtonDown.Down then
        Vectormeter[Plano].PanelDivisor.Caption := Vectormeter[Plano].PanelDivisor.Caption + #13 + MySetFormat(Vectormeter[Plano].Mass2/Vectormeter[Plano].PesoPadrao)
      else
        Vectormeter[Plano].PanelDivisor.Caption := Vectormeter[Plano].PanelDivisor.Caption + #13 + MySetFormat(Vectormeter[Plano].Mass2);

			if frmCalibra.CheckBoxmg.Checked then
				Vectormeter[Plano].PanelDivisor.Caption := Vectormeter[Plano].PanelDivisor.Caption + 'm';

      if Vectormeter[Plano].ButtonDown.Down then
			  Vectormeter[Plano].PanelDivisor.Caption := Vectormeter[Plano].PanelDivisor.Caption + 'unidades '
      else
        Vectormeter[Plano].PanelDivisor.Caption := Vectormeter[Plano].PanelDivisor.Caption + 'g ';

			if Vectormeter[Plano].ButtonArc.Down then
				Vectormeter[Plano].PanelDivisor.Caption := Vectormeter[Plano].PanelDivisor.Caption + ' no arco ' + IntToStr(Vectormeter[Plano].Arc2)
			else
				Vectormeter[Plano].PanelDivisor.Caption := Vectormeter[Plano].PanelDivisor.Caption + 'a ' + IntToStr(Round(Vectormeter[Plano].Angle2))
					+ Vectormeter[Plano]._Unit;
		end
	else
		Vectormeter[Plano].PanelDivisor.Caption := '';

	if Vectormeter[Plano].ButtonInvertAngle.Down then
		Vectormeter[Plano].PanelResultado.Caption := 'Remover '
	else
		Vectormeter[Plano].PanelResultado.Caption := 'Adicionar ';

  if Vectormeter[Plano].ButtonDown.Down then
    begin
    if Vectormeter[Plano].PesoPadrao > 0 then
      Vectormeter[Plano].PanelResultado.Caption := Vectormeter[Plano].PanelResultado.Caption + MySetFormat(Vectormeter[Plano].Amplitude/Vectormeter[Plano].PesoPadrao)
    else
      MessageBox(Handle,'Informe o peso da arruela na calibração!', 'Informação', MB_OK+ MB_ICONWARNING);
    end
  else
	  Vectormeter[Plano].PanelResultado.Caption := Vectormeter[Plano].PanelResultado.Caption + MySetFormat(Vectormeter[Plano].Amplitude);

	if (frmCalibra.CheckBoxmg.Checked) and not (Vectormeter[Plano].ButtonDown.Down) then
		Vectormeter[Plano].PanelResultado.Caption := Vectormeter[Plano].PanelResultado.Caption + 'm';

  if Vectormeter[Plano].ButtonDown.Down then
    Vectormeter[Plano].PanelResultado.Caption := Vectormeter[Plano].PanelResultado.Caption + ' unidades' + #13
  else
    Vectormeter[Plano].PanelResultado.Caption := Vectormeter[Plano].PanelResultado.Caption + 'g' + #13;

	if Vectormeter[Plano].ButtonArc.Down then
		Vectormeter[Plano].PanelResultado.Caption := Vectormeter[Plano].PanelResultado.Caption + 'no arco ' + MySetFormat(Vectormeter[Plano].Arc)
			+ #13 + ' no raio ' + MySetFormat(Vectormeter[Plano].Raio) + ' mm'
	else
		Vectormeter[Plano].PanelResultado.Caption := Vectormeter[Plano].PanelResultado.Caption + 'a ' + IntToStr(Round(Vectormeter[Plano].Phase))
			+ Vectormeter[Plano]._Unit
		{ (arco ou graus) } + #13 + ' no raio ' + MySetFormat(Vectormeter[Plano].Raio) + ' mm';
end;

procedure TfrmMain.novoModelo1Click(Sender: TObject);
begin
	frmReportWizard.Visible := True; // ToolButtonRelatorio.Down;
	frmReportWizard.LoadReport;
	frmReportWizard.JvWizard.SelectFirstPage;
end;

procedure TfrmMain.NovoRelatrio1Click(Sender: TObject);
begin
	FrmRelatorio.Show;
end;

function TfrmMain.ProfundidadeFuro(Diametro, Massa, Densidade: single): single;
var
	Raio: single;
	HCone, HCilindro: single;
	VMaterial, VCone, VCilindro, VTotal: single;
begin
	Raio := (Diametro / 20);
	HCone := Raio * tan((30 * pi) / 180);

	{ case cmbxDensidade.ItemIndex of
		0 : Densidade :=  2.699;
		1 : Densidade :=  11.33;
		2 : Densidade :=  4.53;
		3 : Densidade :=  7.860;
		4 : Densidade :=  19.3;
		end; }

	// primeiro calculo o volume do material a ser retirado
	// massa = densidade * Volume;
	VMaterial := Massa / Densidade;

	// calculo o Volume do Cone e Comparo com o Volume do material
	VCone := (pi * Sqr(Raio) * HCone) / 3;

	if VCone < VMaterial then
		begin
			VCilindro := VMaterial - VCone;
			HCilindro := VCilindro / (pi * Sqr(Raio));
			ShowMessage('Resultado: Fure ' + MySetFormat(HCone + HCilindro) + ' cm');
		end;
	if VCone >= VMaterial then
		begin
			HCone := (3 * VCone / pi) * Sqr(Raio);
			ShowMessage('Resultado: Fure ' + MySetFormat(HCone) + ' cm');
		end;
end;

function TfrmMain.GetSpecialFolderPath: string;
const
	SHGFP_TYPE_CURRENT = 0;
var
	path: array [0 .. MAX_PATH] of Char;
begin
	if SUCCEEDED(SHGetFolderPath(0, CSIDL_LOCAL_APPDATA, 0, SHGFP_TYPE_CURRENT, @path[0])) then
		Result := path
	else
		Result := '';
end;

procedure TfrmMain.FormCreate(Sender: TObject);
var
	Exe, Icone, S: string;
	i: Byte;
	Ini700: TiniFile;
begin
	GhostFilled := False;
	PrimeiraMedida := True;
	UsbDevice := TUsbClass.Create;
	UsbDevice.OnUsbInsertion := USBConectou;
	UsbDevice.OnUsbRemoval := USBDesconectou;
	LastLineSaida := '';
	LastLine := '';
  Respondeu := False;
  AchouNK700 := False;
	for i := 1 to 2 do
		begin
			Vectormeter[i] := TVectormeter.Create(self);
			Vectormeter[i].Tag := i;
			Vectormeter[i].Align := alClient;
			Vectormeter[i].ButtonRight.Enabled := True;
			Vectormeter[i].ButtonDown.Enabled := True;
			Vectormeter[i].PanelPlano.Visible := False;
			Vectormeter[i].ButtonArc.Images := PngImageList48;
			Vectormeter[i].ButtonArc.ImageIndex := 1;
			Vectormeter[i].ButtonArc.DownIndex := 0;
			Vectormeter[i].ButtonArc.Hint := 'Arco / Graus';
			Vectormeter[i].ButtonArc.ShowHint := True;

			Vectormeter[i].ButtonRight.ShowHint := True;
			Vectormeter[i].ButtonRight.Hint := 'Raio de Correção';
			Vectormeter[i].ButtonRight.ImageIndex := 6;
			Vectormeter[i].ButtonRight.Images := PngImageList48;
			// Vectormeter[i].ButtonRight.GroupIndex := 0;

			Vectormeter[i].ButtonInvertAngle.Images := PngImageList48;
			Vectormeter[i].ButtonInvertAngle.ImageIndex := 4;
			Vectormeter[i].ButtonInvertAngle.DownIndex := 5;
			Vectormeter[i].ButtonInvertAngle.Hint := 'Adicionar Massa';
			Vectormeter[i].ButtonInvertAngle.ShowHint := True;

			Vectormeter[i].ButtonMassDivider.Images := PngImageList48;
			Vectormeter[i].ButtonMassDivider.ImageIndex := 2;
			Vectormeter[i].ButtonMassDivider.DownIndex := 3;
			Vectormeter[i].ButtonMassDivider.Hint := 'Divisão de Massa';
			Vectormeter[i].ButtonMassDivider.ShowHint := True;

      Vectormeter[i].ButtonDown.Images := PngImageList48;
			Vectormeter[i].ButtonDown.ImageIndex := 2;
			Vectormeter[i].ButtonDown.DownIndex := 3;
			Vectormeter[i].ButtonDown.Hint := 'Peso padrão';
			Vectormeter[i].ButtonDown.ShowHint := True;

			Vectormeter[i].TrackScale.OnChange := Vectormeter1TrackScaleChange;
			// Vectormeter[i].EditAmplitude.OnChange := RefinaManual;
			// Vectormeter[i].EditFase.OnChange := RefinaManual;
			Vectormeter[i].EditAmplitude.OnKeyPress := VectorKeyPress;
			Vectormeter[i].EditFase.OnKeyPress := VectorKeyPress;
			Vectormeter[i].EditAmplitude.ShowHint := True;
			Vectormeter[i].EditFase.ShowHint := True;
			Vectormeter[i].EditAmplitude.Hint := 'Pressione Enter para atualizar';
			Vectormeter[i].EditFase.Hint := 'Pressione Enter para atualizar';
			Vectormeter[i].PanelInfo1.Caption := 'Plano ' + IntToStr(i);
			Vectormeter[i].EditAmplitude.OnEnter := TouchKeyBoardEnter;
			Vectormeter[i].EditFase.OnEnter := TouchKeyBoardEnter;
     end;

	Vectormeter[1].Parent := pnlPlano1;
	Vectormeter[2].Parent := pnlPlano2;

	Vectormeter[1].ButtonArc.OnClick := Vectormeter1ArcClick;
	Vectormeter[2].ButtonArc.OnClick := Vectormeter2ArcClick;
	Vectormeter[1].ButtonInvertAngle.OnClick := Vectormeter1InvertAngleClick;
	Vectormeter[2].ButtonInvertAngle.OnClick := Vectormeter2InvertAngleClick;
	Vectormeter[1].ButtonMassDivider.OnClick := Vectormeter1MassDividerClick;
	Vectormeter[2].ButtonMassDivider.OnClick := Vectormeter2MassDividerClick;
	// botão de compensação de raio
	Vectormeter[1].ButtonRight.OnClick := Vectormeter1RightClick;
	Vectormeter[2].ButtonRight.OnClick := Vectormeter2RightClick;

  // botão de peso de arruelas
  Vectormeter[1].ButtonDown.Visible := False;
  Vectormeter[2].ButtonDown.Visible := False;
	Vectormeter[1].ButtonDown.OnClick := Vectormeter1DownClick;
	Vectormeter[2].ButtonDown.OnClick := Vectormeter2DownClick;

	Application.HelpFile := ChangeFileExt(Application.ExeName, '.hlp');
	Exe := ExtractFilePath(Application.ExeName) + ExtractFileName(Application.ExeName);
	Icone := ExtractFileDir(Application.ExeName) + '\' + ExtractFileName('DEFAULT.ICO');
	HelpFile := ExtractFilePath(Application.ExeName) + 'Help Files\NK700.hlp';
	frmMain.Caption := 'Teknikao - NK700 - Balanceamento em Um ou Dois Planos';

	VetorRI1.Amp := 0;
	VetorRI2.Amp := 0;

	// agora grava na pasta application Data/ NK700 do usuario atual
	S := IncludeTrailingBackslash(GetSpecialFolderPath);
	S := IncludeTrailingBackslash(S) + 'Teknikao\NK700\';
	if not DirectoryExists(S) then
		ForceDirectories(S);
	S := S + 'NK700.ini';
	try
		Ini700 := TiniFile.Create(S);
		with Ini700 do
			begin
				S := 'Configuração';
				VersaoHardware := ReadString(S, 'VersaoHardware', '');
				cmbxMedia.ItemIndex := ReadInteger(S, 'Medias', 1);
				Medias := StrToInt(cmbxMedia.Text);
				frmMain.Top := ReadInteger(S, 'Top', (Screen.Width - frmMain.Width) div 2);
				frmMain.Left := ReadInteger(S, 'Left', (Screen.Height - frmMain.Height) div 2);
				frmMain.Width := ReadInteger(S, 'Width', 800);
				frmMain.Height := ReadInteger(S, 'Height', 600);
				frmMain.WindowState := TWindowState(ReadInteger(S, 'WS', 0));

			end;
	finally
		Ini700.Free;
	end;
	MediaPronta := True;
	ContaMedia := Medias + 1;
	// HidDeviceController.Enumerate;
	//ListaHID := TStringList.Create;
end;

procedure TfrmMain.VectorKeyPress(Sender: TObject; var Key: Char);
begin
	if Key = #13 then
		RefinaManual(Vectormeter[1].EditAmplitude.Value, Vectormeter[1].EditFase.Value, Vectormeter[2].EditAmplitude.Value,
			Vectormeter[2].EditFase.Value);
end;

procedure TfrmMain.FormPaint(Sender: TObject);
begin
	AdvTrackBar.Repaint;
end;

procedure TfrmMain.FormResize(Sender: TObject);
begin
	// painel dos vectometros
	pnlPlano1.Width := (pnlClient.Width div 2) - 2;
	pnlPlano2.Left := pnlPlano1.Width + 2;
	pnlPlano2.Width := pnlPlano1.Width + 2;
end;

procedure TfrmMain.Vectormeter1ArcClick(Sender: TObject);
begin
	MostraResultado(1);
	if FormOpcoes.chckbx2Planos.Checked then
		begin
			Vectormeter[2].ButtonArc.Down := Vectormeter[1].ButtonArc.Down;
			MostraResultado(2);
		end;
end;

procedure TfrmMain.Vectormeter2ArcClick(Sender: TObject);
begin
	MostraResultado(2);
	if FormOpcoes.chckbx2Planos.Checked then
		begin
			Vectormeter[1].ButtonArc.Down := Vectormeter[2].ButtonArc.Down;
			MostraResultado(1);
		end;
end;

procedure TfrmMain.Vectormeter1InvertAngleClick(Sender: TObject);
begin
	if Vectormeter[1].ButtonInvertAngle.Down then
		Vectormeter[1].ButtonInvertAngle.Hint := 'Remover massa'
	else
		Vectormeter[1].ButtonInvertAngle.Hint := 'Adicionar massa';
	MostraResultado(1);

	if FormOpcoes.chckbx2Planos.Checked then
		begin
			Vectormeter[2].ButtonInvertAngle.Down := Vectormeter[1].ButtonInvertAngle.Down;
			if Vectormeter[2].ButtonInvertAngle.Down then
				Vectormeter[2].ButtonInvertAngle.Hint := 'Remover massa'
			else
				Vectormeter[2].ButtonInvertAngle.Hint := 'Adicionar massa';
			MostraResultado(2);
		end;
end;

procedure TfrmMain.Vectormeter2InvertAngleClick(Sender: TObject);
begin
	if Vectormeter[2].ButtonInvertAngle.Down then
		Vectormeter[2].ButtonInvertAngle.Hint := 'Remover massa'
	else
		Vectormeter[2].ButtonInvertAngle.Hint := 'Adicionar massa';
	MostraResultado(2);

	if FormOpcoes.chckbx2Planos.Checked then
		begin
			Vectormeter[1].ButtonInvertAngle.Down := Vectormeter[2].ButtonInvertAngle.Down;
			if Vectormeter[1].ButtonInvertAngle.Down then
				Vectormeter[1].ButtonInvertAngle.Hint := 'Remover massa'
			else
				Vectormeter[1].ButtonInvertAngle.Hint := 'Adicionar massa';
			MostraResultado(1);
		end;
end;

procedure TfrmMain.Vectormeter1RightClick(Sender: TObject);
var
	S: string;
	V: Tvetor;
begin
	if Vectormeter[1].Raio = 0 then
		S := frmCalibra.NumIORaioM1.Text
	else
		S := MySetFormat(Vectormeter[1].Raio);

	if not InputQuery('Raio de Correção', 'Usar este raio (mm) para correção', S) then
		begin
			if Vectormeter[1].ButtonRight.Down then
				Vectormeter[1].ButtonRight.Down := False;
			Exit;
		end;

	// if S <> frmCalibra.NumIORaioM1.Text then
	Vectormeter[1].Raio := StrToFloat(S);

	if FormOpcoes.chckbx2Planos.Checked then
		Vectormeter[2].Raio := Vectormeter[1].Raio;

	// para atualizar o valor da massa e raio
	if frmCalibra.RadioButtonDoisPlanos.Checked then
		begin
			Refina2;
			CompareNorma(1);
			MostraResultado(1);
			if FormOpcoes.chckbx2Planos.Checked then
				begin
					CompareNorma(2);
					MostraResultado(2);
				end;
		end
	else
		begin
			//V.Amp := 0;
			//V.Fase := 0;
			//Refina1(V);
      DoSinglePlaneBalance;
			CompareNorma(1);
			MostraResultado(1);
		end;

	if Vectormeter[1].ButtonRight.Down then
		Vectormeter[1].ButtonRight.Down := False;
end;

procedure TfrmMain.Vectormeter2RightClick(Sender: TObject);
var
	S: string;
	V: Tvetor;
begin
	if Vectormeter[2].Raio = 0 then
		S := frmCalibra.NumIORaioM2.Text
	else
		S := MySetFormat(Vectormeter[2].Raio);

	if not InputQuery('Raio de Correção', 'Usar este raio (mm) para correção', S) then
		begin
			if Vectormeter[2].ButtonRight.Down then
				Vectormeter[2].ButtonRight.Down := False;
			Exit;
		end;

	// if S <> frmCalibra.NumIORaioM2.Text then
	Vectormeter[2].Raio := StrToFloat(S);
	if FormOpcoes.chckbx2Planos.Checked then
		Vectormeter[1].Raio := Vectormeter[2].Raio;

	// para atualizar o valor da massa e raio
	if frmCalibra.RadioButtonDoisPlanos.Checked then
		begin
			Refina2;
			CompareNorma(2);
			MostraResultado(2);
			if FormOpcoes.chckbx2Planos.Checked then
				begin
					CompareNorma(1);
					MostraResultado(1);
				end;
		end
	else
		begin
			//V.Amp := 0;
			//V.Fase := 0;
			//Refina1(V);
      DoSinglePlaneBalance;
			CompareNorma(2);
			MostraResultado(2);
		end;
	if Vectormeter[2].ButtonRight.Down then
		Vectormeter[2].ButtonRight.Down := False;
end;

procedure TfrmMain.Vectormeter1DownClick(Sender: TObject);
var
	S: string;
	V: Tvetor;
begin
	if Vectormeter[1].PesoPadrao  = 0 then
		Vectormeter[1].PesoPadrao := frmCalibra.NumIOPesoPadrao.Value;

  MostraResultado(1);
	if FormOpcoes.chckbx2Planos.Checked then
		begin
		Vectormeter[2].ButtonDown.Down := Vectormeter[1].ButtonDown.Down;
		MostraResultado(2);
		end;
	{if not InputQuery('Raio de Correção', 'Usar este raio (mm) para correção', S) then
		begin
			if Vectormeter[1].ButtonRight.Down then
				Vectormeter[1].ButtonRight.Down := False;
			Exit;
		end; }

	// if S <> frmCalibra.NumIORaioM1.Text then
	//Vectormeter[1].Arruela := StrToFloat(S);


	//if Vectormeter[1].ButtonDown.Down then
		//Vectormeter[1].ButtonDown.Down := False;
end;

procedure TfrmMain.Vectormeter2DownClick(Sender: TObject);
var
	S: string;
	V: Tvetor;
begin
	if Vectormeter[2].PesoPadrao = 0 then
		Vectormeter[2].PesoPadrao := frmCalibra.NumIOPesoPadrao.Value;


	MostraResultado(2);

	if FormOpcoes.chckbx2Planos.Checked then
		begin
		Vectormeter[1].ButtonDown.Down := Vectormeter[2].ButtonDown.Down;
		MostraResultado(1);
		end;

	{if not InputQuery('Raio de Correção', 'Usar este raio (mm) para correção', S) then
		begin
			if Vectormeter[2].ButtonRight.Down then
				Vectormeter[2].ButtonRight.Down := False;
			Exit;
		end; }

	// if S <> frmCalibra.NumIORaioM2.Text then
	{Vectormeter[2].Arruela := StrToFloat(S);
	if FormOpcoes.chckbx2Planos.Checked then
		Vectormeter[1].Arruela := Vectormeter[2].Raio;}


	//if Vectormeter[2].ButtonDown.Down then
		//Vectormeter[2].ButtonDown.Down := False;
end;

procedure TfrmMain.Vectormeter1MassDividerClick(Sender: TObject);
begin
	Vectormeter[1].MassDivider := Vectormeter[1].ButtonMassDivider.Down;
	MostraResultado(1);
	if FormOpcoes.chckbx2Planos.Checked then
		begin
			Vectormeter[2].ButtonMassDivider.Down := Vectormeter[1].ButtonMassDivider.Down;
			Vectormeter[2].MassDivider := Vectormeter[2].ButtonMassDivider.Down;
			MostraResultado(2);
		end;
end;

procedure TfrmMain.Vectormeter2MassDividerClick(Sender: TObject);
begin
	Vectormeter[2].MassDivider := Vectormeter[2].ButtonMassDivider.Down;
	MostraResultado(2);

	if FormOpcoes.chckbx2Planos.Checked then
		begin
			Vectormeter[1].ButtonMassDivider.Down := Vectormeter[2].ButtonMassDivider.Down;
			Vectormeter[1].MassDivider := Vectormeter[1].ButtonMassDivider.Down;
			MostraResultado(1);
		end;
end;

procedure TfrmMain.Vectormeter1TrackScaleChange(Sender: TObject);
begin
	TVectormeter(TRzPanel((Sender as TRzTrackBar).Parent).Parent).GhostScale := Escala[(Sender as TRzTrackBar).Position];
	TVectormeter(TRzPanel((Sender as TRzTrackBar).Parent).Parent).Scale := Escala[(Sender as TRzTrackBar).Position];
	TVectormeter(TRzPanel((Sender as TRzTrackBar).Parent).Parent).LabelScale.Caption := 'Escala: ' + MySetFormat
		(Escala[(Sender as TRzTrackBar).Position]);
end;

procedure TfrmMain.DefineRPM;
begin
	with frmCalibra do
		begin
			LabelRPMRef.Caption := LabelRotacaoMain.Caption;
			RPMReferencia := Rotacao;
			AdvTrackBar.Min := Round(RPMReferencia * 0.75);
			AdvTrackBar.Max := Round(RPMReferencia) + Round(RPMReferencia * 0.25);
			frmMain.AdvTrackBar.Max := AdvTrackBar.Max;
			frmMain.AdvTrackBar.Min := AdvTrackBar.Min;
			frmMain.AdvTrackBar.Position := Round(frmMain.Rotacao);
			VerifyRPM;
		end;
end;

procedure TfrmMain.Get_Vetor(S: string);
var
	V1, V2: Tvetor;
	Sa: String;
begin
	if LastLine[1] = 'A' then
		TryStrToFloat(S, VetorMedioP1.Vin.Amp);
	if LastLine[1] = 'B' then
		TryStrToFloat(S, VetorMedioP1.Vin.Fase);
	if LastLine[1] = 'C' then
		TryStrToFloat(S, VetorMedioP2.Vin.Amp);
	if LastLine[1] = 'D' then
		TryStrToFloat(S, VetorMedioP2.Vin.Fase);
	if LastLine[1] = 'F' then
		RzStatusCalibra.Caption := 'Calibrar interface.';
	if LastLine[1] = 'G' then
		begin
			TryStrToFloat(S, Rotacao);
			LabelRotacaoMain.Caption := S + ' RPM';
			TempoK0 := 0; // zera tempo para saber se RPM = 0
			StatusPaneMess.Caption := '';
			if not EstabOk then
				lblEstab.Caption := ' Estabilizando...'
		end;
	if LastLine[1] = 'E' then
		begin
			EstabOk := True;
			RzStatusCalibra.Caption := '';
			TryStrToFloat(S, Rotacao);
			LabelRotacaoMain.Caption := S + ' RPM';
			TempoK0 := 0; // zera tempo para saber se RPM = 0
      {$IFDEF ENABLE_TIMER_MEDIDAS}
			TimerIgnoraMedidas.Enabled := True;
      {$ELSE}
      lblEstab.Caption := ' Estabilização OK';
      {$ENDIF}


			if tlbtnCalibrar.Down then
				if (frmCalibra.PageCalibra.ActivePage <> frmCalibra.TabRI) and (frmCalibra.PageCalibra.ActivePage <> frmCalibra.TabBal2SM) then
					if (RPMReferencia <> 0) then // and (FormOpcoes.chckbxRPM.Checked) then
						begin
							VetorMedioP1.Vin.Amp := Sqr(RPMReferencia / Rotacao) * VetorMedioP1.Vin.Amp;
							VetorMedioP2.Vin.Amp := Sqr(RPMReferencia / Rotacao) * VetorMedioP2.Vin.Amp;
						end;

			StatusPaneMess.Caption := '';
			if not tlbtnCalibrar.Down then
				begin
					if not VerifyRPM then
						Exit;

          {$IFDEF ENABLE_TIMER_MEDIDAS}
          //Inc(ContaMedidasFalsas);
          if (ContaMedidasFalsas < SpinEditTime.Value) then
            exit;
          lblEstab.Caption := ' Estabilização OK';
          {$ENDIF}

					if (ContaMedia = 0) and not PrimeiraMedida then
						begin
							if not GhostFilled then
								begin
									if Vectormeter[1].Visible then
										begin
											// if (Vectormeter[1].GhostAmplitude <> Vectormeter[1].Amplitude) then//Gramas.final[1]) then // or
											// (Vectormeter[1].GhostPhase <> fase.final[1]) then
											// begin

											Vectormeter[1].GhostPhase := Vectormeter[1].Phase; // Fase.final[1];
											Vectormeter[1].GhostAmplitude := Vectormeter[1].Amplitude; // Gramas.final[1];
											Vectormeter[1].GhostScale := Vectormeter[1].Scale;
											// end;
										end;
									if Vectormeter[2].Visible then
										begin
											// if (Vectormeter[2].GhostAmplitude <> Vectormeter[2].Amplitude) then//Gramas.final[2]) then // or
											// (Vectormeter[2].GhostPhase <> fase.final[2]) then
											// begin
											Vectormeter[2].GhostPhase := Vectormeter[2].Phase; // Fase.final[2];
											Vectormeter[2].GhostAmplitude := Vectormeter[2].Amplitude; // Gramas.final[2];
											Vectormeter[2].GhostScale := Vectormeter[2].Scale;
											// end;
										end;
									GhostFilled := True;
								end;
						end;

					if (ContaMedia >= Medias) then
						begin
							if not MediaPronta then
								begin
									Seta_Rele;
									with FormOpcoes do
										begin
											if CheckBoxSaidaAtiva.Checked then
												begin
													if ComPortSaida.Active then
														ComPortSaida.WriteString(FormataSaida(FormOpcoes.EditSaida.Text));
												end;
										end;
									MediaPronta := True;
									PrimeiraMedida := False;
								end;
							Exit;
						end;

					if ContaMedia = 0 then
						begin
							if ComPort.Active then
								ComPort.WriteString('RELE0' + #13); // desligo o Rele sempre que começa as leituras
						end;




          Inc(ContaMedia);
					try
						V1 := DoMediaVetor(VetorMedioP1);
					except
						ZeroMemory(@VetorMedioP1, SizeOf(TVetorMedio));
					end;

					try
						V2 := DoMediaVetor(VetorMedioP2);
					except
						ZeroMemory(@VetorMedioP2, SizeOf(TVetorMedio));
					end;

					if (FormOpcoes.NumIOCalAmplitude1.Text <> '') and (FormOpcoes.NumIOCalPhase1.Text <> '') then
						begin
							VetorAjuste1.Amp := FormOpcoes.NumIOCalAmplitude1.Value;
							VetorAjuste1.Fase := FormOpcoes.NumIOCalPhase1.Value;
							V1 := subvetor(V1, VetorAjuste1);
						end;

					if (FormOpcoes.NumIOCalAmplitude2.Text <> '') and (FormOpcoes.NumIOCalPhase2.Text <> '') then
						begin
							VetorAjuste2.Amp := FormOpcoes.NumIOCalAmplitude2.Value;
							VetorAjuste2.Fase := FormOpcoes.NumIOCalPhase2.Value;
							V2 := subvetor(V2, VetorAjuste2);
						end;

					if frmCalibra.RadioButtonDoisPlanos.Checked then
						begin
							if FormOpcoes.CheckBoxRI.Checked then
								begin
									V1 := subvetor(V1, VetorRI1);
									V2 := subvetor(V2, VetorRi2);
								end;
							Refinamento2(V1, V2);
							CompareNorma(1);
							CompareNorma(2);
							MostraResultado(1);
							MostraResultado(2);
						end
					else
						begin // bal 1 plano
							if frmCalibra.RadioButtonMancal1.Checked then
								begin
									if FormOpcoes.CheckBoxRI.Checked then
										V1 := subvetor(V1, VetorRI1);
									Refina1(V1);
									MostraResultado(1);
									CompareNorma(1);
								end
							else
								begin
									if FormOpcoes.CheckBoxRI.Checked then
										V2 := subvetor(V2, VetorRi2);
									Refina1(V2);
									MostraResultado(2);
									CompareNorma(2);
								end;
						end;
				end
			else
				with frmCalibra do
					begin
						AdvTrackBar.Position := Round(Rotacao);
						AdvTrackBar.Repaint;
						VerifyRPM;

						if SpeedButtonLer.Down then
							begin
								if FormOpcoes.CheckBoxRI.Checked then
									begin
										if (frmCalibra.PageCalibra.ActivePage = frmCalibra.TabRI) then
											DefineRPM
										else if not VerifyRPM then
											Exit;
									end
								else
									begin
										if (frmCalibra.PageCalibra.ActivePage = frmCalibra.TabBal2SM) then
											DefineRPM
										else if not VerifyRPM then
											Exit;
									end;
							end
						else
							Exit;

            {$IFDEF ENABLE_TIMER_MEDIDAS}
            //Inc(ContaMedidasFalsas);
            if (ContaMedidasFalsas < SpinEditTime.Value) then
              exit;
            lblEstab.Caption := ' Estabilização OK';
            {$ENDIF}

						Inc(ContaMedia);
						if (ContaMedia >= Medias) then
							begin
								SpeedButtonLer.Down := False;
								SpeedButtonLer.Caption := 'Ler Vetores';
							end;

						try
							V1 := DoMediaVetor(VetorMedioP1);
						except
							ZeroMemory(@VetorMedioP1, SizeOf(TVetorMedio));
						end;

						try
							V2 := DoMediaVetor(VetorMedioP2);
						except
							ZeroMemory(@VetorMedioP2, SizeOf(TVetorMedio));
						end;

						// mudei o mysetformat dos angulos para format
						if PageCalibra.ActivePage = TabRI then
							begin
								NumIOA1RI.Text := MySetFormat(V1.Amp);
								NumIOF1RI.Text := FormatFloat('0', V1.Fase); // MySetFormat(V1.Fase);
								NumIOA2RI.Text := MySetFormat(V2.Amp);
								NumIOF2RI.Text := FormatFloat('0', V2.Fase); // MySetFormat(V2.Fase);
								VetorRI1 := V1;
								VetorRi2 := V2;
							end
						else if PageCalibra.ActivePage = TabBal2SM then
							begin
								if FormOpcoes.CheckBoxRI.Checked then
									begin
										V1 := subvetor(V1, VetorRI1);
										V2 := subvetor(V2, VetorRi2);
									end;
								NumIOA1SM.Text := MySetFormat(V1.Amp);
								NumIOF1SM.Text := FormatFloat('0', V1.Fase); // MySetFormat(V1.Fase);
								NumIOA2SM.Text := MySetFormat(V2.Amp);
								NumIOF2SM.Text := FormatFloat('0', V2.Fase); // MySetFormat(V2.Fase);
							end
						else if PageCalibra.ActivePage = TabBal2PM1 then
							begin
								if FormOpcoes.CheckBoxRI.Checked then
									begin
										V1 := subvetor(V1, VetorRI1);
										V2 := subvetor(V2, VetorRi2);
									end;
								NumIOA1M1.Text := MySetFormat(V1.Amp);
								NumIOF1M1.Text := FormatFloat('0', V1.Fase); // MySetFormat(V1.Fase);
								NumIOA2M1.Text := MySetFormat(V2.Amp);
								NumIOF2M1.Text := FormatFloat('0', V2.Fase); // MySetFormat(V2.Fase);
							end
						else if PageCalibra.ActivePage = TabBal2PM2 then
							begin
								if FormOpcoes.CheckBoxRI.Checked then
									begin
										V1 := subvetor(V1, VetorRI1);
										V2 := subvetor(V2, VetorRi2);
									end;
								NumIOA1M2.Text := MySetFormat(V1.Amp);
								NumIOF1M2.Text := FormatFloat('0', V1.Fase); // MySetFormat(V1.Fase);
								NumIOA2M2.Text := MySetFormat(V2.Amp);
								NumIOF2M2.Text := FormatFloat('0', V2.Fase); // MySetFormat(V2.Fase);
							end;
					end;
			lblMedia.Caption := 'Media ' + IntToStr(ContaMedia) + '/' + IntToStr(Medias);
		end;
end;

procedure TfrmMain.HidDeviceControllerArrival(HidDev: TJvHidDevice);
begin
  if (HidDev.Attributes.VendorID <> USBVID) or (HidDev.Attributes.ProductID <> USBPID) then
	  exit;
  HidDeviceController.Enumerate;
end;

procedure TfrmMain.HidDeviceControllerDeviceUnplug(HidDev: TJvHidDevice);
begin
  if (HidDev.Attributes.VendorID <> USBVID) or (HidDev.Attributes.ProductID <> USBPID) then
	  exit;
  HidDeviceController.CheckIn(CurrentDevice);
  //CurrentDevice := nil;
  try
  pnSerialPort.Caption := 'NK700 HID removido ';
  except;
  end;
end;

procedure TfrmMain.ShowRead(HidDev: TJvHidDevice; ReportID: Byte; const Data: Pointer; Size: Word);
var
	i, e: Integer;
	S, Aux: string;

label Vetor;
begin
  if (HidDev.Attributes.VendorID <> USBVID) or (HidDev.Attributes.ProductID <> USBPID) then
	  exit;
	// Line := ComPort.ReadString;
	Line := PAnsiChar(Data);

	for i := 1 to Length(Line) do
		begin
			try
				if Line[i] = ThousandSeparator then
					Line[i] := DecimalSeparator;
				// if (Line[i] <> #10) and (Line[i] <> #13) then
				// LastLine := LastLine + Line[i];

				if ((Line[i] >= '0') and (Line[i] <= '9')) or ((Line[i] >= 'A') and (Line[i] <= 'z') or (Line[i] = DecimalSeparator)) then
					LastLine := LastLine + Line[i];

				if Line[i] = #13 then
					begin
						if Copy(LastLine, 1, 7) = 'ATT=NK7' then
							Respondeu := True;

						if (LastLine[1] <> 'A') and (LastLine[1] <> 'B') and (LastLine[1] <> 'C') and (LastLine[1] <> 'D') and (LastLine[1] <> 'E') and
							(LastLine[1] <> 'F') and
						// calibrar interface
							(LastLine[1] <> 'G') then // rotação sem estabilização
							begin
								LastLine := '';
								Exit;
							end;


						// diagnostico NK700
						{ if (LastLine[1] = 'A') and (LastLine[2] = 'T') and (LastLine[3] = 'T') then
							begin
							FormOpcoes.rchedtDiagnostico.SelAttributes.Color := clPurple;
							Aux := ' (NK700 Encontrado)';
							end; }

						if ((LastLine[1] = 'A') and (LastLine[2] <> 'T')) or (LastLine[1] = 'C') then
							begin
								FormOpcoes.rchedtDiagnostico.SelAttributes.Color := clRed;
								Aux := ' (Amplitude)';
							end;
						if (LastLine[1] = 'B') or (LastLine[1] = 'D') then
							begin
								FormOpcoes.rchedtDiagnostico.SelAttributes.Color := clBlue;
								Aux := ' (Fase)';
							end;
						if LastLine[1] = 'E' then
							begin
								FormOpcoes.rchedtDiagnostico.SelAttributes.Color := clGreen;
								Aux := ' (RPM)';
							end;
						if LastLine[1] = 'F' then
							begin
								FormOpcoes.rchedtDiagnostico.SelAttributes.Color := $00E56701;
								Aux := ' (Calibrar)';
							end;
						if LastLine[1] = 'G' then
							begin
								FormOpcoes.rchedtDiagnostico.SelAttributes.Color := clPurple;
								Aux := ' (Rotação)';
							end;
						if (LastLine[2] <> 'T') then
							begin
								FormOpcoes.TimerLog.Enabled := True;
								FormOpcoes.rchedtDiagnostico.Lines.Add(Copy(LastLine, 1, Length(LastLine)) + Aux + ' - ' + DateTimeToStr(Now));
								FormOpcoes.rchedtDiagnostico.Perform(EM_SCROLL, SB_LINEDOWN, 0);
							end;
						S := Copy(LastLine, 2, Length(LastLine) - 1);
						if LastLine = 'F' then
							begin
								S := LastLine;
								goto Vetor;
							end;
						for e := 1 to Length(S) do
							begin
								if ((S[e] < '0') or (S[e] > '9')) and (S[e] <> DecimalSeparator) then
									begin
										LastLine := '';
										Exit;
									end;
							end;
					Vetor :
						Get_Vetor(S);
						LastLine := '';
					end;
			except
				;
			end;
		end;
end;

procedure TfrmMain.StringToBytes(const S: string; var Bytes: THIDBytes);
var
	i: Byte;
begin
	ZeroMemory(@Bytes, SizeOf(Bytes));
	// S := 'ATT' + #13;
	for i := 1 to Length(S) do
		Bytes[i] := ord(S[i]);
end;

function TfrmMain.HidDeviceControllerEnumerate(HidDev: TJvHidDevice; const Idx: Integer): Boolean;
var
	// N: Word;
	ToWrite: Cardinal;
	Written: Cardinal;
	Buf: THIDBytes;
	// Dev: TJvHidDevice;
begin
	if (HidDev.Attributes.VendorID <> USBVID) or (HidDev.Attributes.ProductID <> USBPID) then
		begin
			Result := True;
			Exit;
		end;

  if (CurrentDevice = nil) then
	  HidDeviceController.CheckOutByID(CurrentDevice, USBVID, USBPID);
	FormOpcoes.Habilita_Serial(False);
	Respondeu := True;
	AchouNK700 := True;
	FormOpcoes.StatusPaneOpcoes.Caption := 'NK700 encontrado';
	pnSerialPort.Caption := 'NK700 HID OK ';

	if ComPort.Active then
		ComPort.Close;


	// CurrentDevice := TJvHidDevice(HidDev);
	// if HidDeviceController.CheckOut(TJvHidDevice(HidDev)) then
	// begin
	//
	// ToWrite := CurrentDevice.Caps.OutputReportByteLength;
	// StringToBytes('ATT' + #13, Buf);
	// CurrentDevice.WriteFile(Buf, ToWrite, Written);
	// end;

	{
		if Assigned(FormOpcoes.cmbxHID) then
		begin
		if HidDev.ProductName <> '' then
		N := FormOpcoes.cmbxHID.Items.Add(HidDev.ProductName + ' ' + HidDev.SerialNumber)
		else
		N := FormOpcoes.cmbxHID.Items.Add(Format('Device VID=%.4x PID=%.4x',
		[HidDev.Attributes.VendorID, HidDev.Attributes.ProductID]));
		HidDeviceController.CheckOutByIndex(Dev, Idx);
		FormOpcoes.cmbxHID.Items.Objects[N] := Dev;
		end;
	}

	Result := True;
end;

procedure TfrmMain.ComPortDataRecived(Sender: TObject; Count: Integer);
var
	i, e: Integer;
	S, Aux: string;

label Vetor;
begin

	Line := ComPort.ReadString;

	for i := 1 to Length(Line) do
		begin
			try
				if Line[i] = ThousandSeparator then
					Line[i] := DecimalSeparator;
				if (Line[i] <> #10) and (Line[i] <> #13) then
					LastLine := LastLine + Line[i];

				if Line[i] = #13 then
					begin
						if Copy(LastLine, 1, 7) = 'ATT=NK7' then
							Respondeu := True;

						if (LastLine[1] <> 'A') and (LastLine[1] <> 'B') and (LastLine[1] <> 'C') and (LastLine[1] <> 'D') and (LastLine[1] <> 'E') and
							(LastLine[1] <> 'F') and
						// calibrar interface
							(LastLine[1] <> 'G') then // rotação sem estabilização
							begin
								LastLine := '';
								Exit;
							end;


						// diagnostico NK700
						{ if (LastLine[1] = 'A') and (LastLine[2] = 'T') and (LastLine[3] = 'T') then
							begin
							FormOpcoes.rchedtDiagnostico.SelAttributes.Color := clPurple;
							Aux := ' (NK700 Encontrado)';
							end; }

						if ((LastLine[1] = 'A') and (LastLine[2] <> 'T')) or (LastLine[1] = 'C') then
							begin
								FormOpcoes.rchedtDiagnostico.SelAttributes.Color := clRed;
								Aux := ' (Amplitude)';
							end;
						if (LastLine[1] = 'B') or (LastLine[1] = 'D') then
							begin
								FormOpcoes.rchedtDiagnostico.SelAttributes.Color := clBlue;
								Aux := ' (Fase)';
							end;
						if LastLine[1] = 'E' then
							begin
								FormOpcoes.rchedtDiagnostico.SelAttributes.Color := clGreen;
								Aux := ' (RPM)';
							end;
						if LastLine[1] = 'F' then
							begin
								FormOpcoes.rchedtDiagnostico.SelAttributes.Color := $00E56701;
								Aux := ' (Calibrar)';
							end;
						if LastLine[1] = 'G' then
							begin
								FormOpcoes.rchedtDiagnostico.SelAttributes.Color := clPurple;
								Aux := ' (Rotação sem estabilização)';
							end;
						if (LastLine[2] <> 'T') then
							begin
								FormOpcoes.TimerLog.Enabled := True;
								FormOpcoes.rchedtDiagnostico.Lines.Add(Copy(LastLine, 1, Length(LastLine)) + Aux + ' - ' + DateTimeToStr(Now));
								FormOpcoes.rchedtDiagnostico.Perform(EM_SCROLL, SB_LINEDOWN, 0);
							end;
						S := Copy(LastLine, 2, Length(LastLine) - 1);
						if LastLine = 'F' then
							begin
								S := LastLine;
								goto Vetor;
							end;
						for e := 1 to Length(S) do
							begin
								if ((S[e] < '0') or (S[e] > '9')) and (S[e] <> DecimalSeparator) then
									begin
										LastLine := '';
										Exit;
									end;
							end;
					Vetor :
						Get_Vetor(S);
						LastLine := '';
					end;
			except
				;
			end;
		end;
end;

procedure TfrmMain.TimerIgnoraMedidasTimer(Sender: TObject);
begin
  Inc(ContaMedidasFalsas);
end;

procedure TfrmMain.TimerTempoportaTimer(Sender: TObject);
begin
	Inc(TempoK0);
	frmCalibra.LabelRotacao.Caption := LabelRotacaoMain.Caption;
	if (TempoK0 > 3) then
		begin
			LabelRotacaoMain.Caption := '0 RPM';
			Rotacao := 0;
			EstabOk := False;
			lblEstab.Caption := ' Sem rotação...';
			VerifyRPM;
			StatusPaneMess.Caption := 'Sem k0 (' + IntToStr(11 - TempoK0) + ')';
			TempoK0 := 0; // parou de receber
			MediaPronta := False;
			ZeraMedia;
      //para zerar a contagem de tempo
      TimerIgnoraMedidas.Enabled := False;
		end;
	AdvTrackBar.Repaint;
	frmCalibra.AdvTrackBar.Repaint;

	if (TempoK0 > formOpcoes.spedtTempo.Value) then
		begin
			// coloquei em cima
			// TempoK0 := 0; // parou de receber
			// MediaPronta := False;
			// ZeraMedia;
			// FormOpcoes.cmbxPortaSerialChange(nil);
			if not(AchouNK700) and not(FormOpcoes.CheckBoxManual.Checked) and not(FormOpcoes.chckbxFixaPorta.Checked) then
				FormOpcoes.ButtonBuscaPortaClick(nil);
			LendoAtivo := False;
			StatusPaneMess.Caption := 'Aguardando Rotação';
			frmCalibra.StatusPaneCalibra.Caption := StatusPaneMess.Caption;
		end
	else
		begin // recebendo

			if (not MediaPronta) and (not LendoAtivo) then
				begin
					LendoAtivo := True;
				end;
		end;
end;

procedure TfrmMain.FormActivate(Sender: TObject);
begin
	Repaint;
	if HasParams then
		begin
			frmCalibra.Show;
			frmCalibra.BringToFront;
			HasParams := False;
		end;
	// frmKeyboard.MyTouchKeyboard.HandleOfTheTargetForm := Self.Handle;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
	i: Byte;
	S: string;
	Ini700: TiniFile;
begin
	TimerTempoporta.Enabled := False;
	try
		try
			// agora grava na pasta application Data/ NK700 do usuario atual
			S := IncludeTrailingBackslash(GetSpecialFolderPath);
			S := IncludeTrailingBackslash(S) + 'Teknikao\NK700\';
			if ForceDirectories(S) then
				S := S + 'NK700.ini';
			Ini700 := TiniFile.Create(S);
			with Ini700 do
				begin
					S := 'Configuração';
					WriteString(S, 'ISO', frmCalibra.ComboBoxISO.Text);
					WriteString(S, 'VersaoHardware', VersaoHardware);
					WriteInteger(S, 'Medias', cmbxMedia.ItemIndex);
					WriteInteger(S, 'COM Port', FormOpcoes.cmbxPortaSerial.ComNumber);
          WriteInteger(S, 'Tempo Rearme', FormOpcoes.spedtTempo.Value);
					WriteInteger(S, 'Top', frmMain.Top);
					WriteInteger(S, 'Left', frmMain.Left);
					WriteInteger(S, 'Width', frmMain.Width);
					WriteInteger(S, 'Height', frmMain.Height);
					WriteInteger(S, 'WS', Integer(frmMain.WindowState));
					S := 'Opcoes';
					WriteInteger(S, 'Circulos', trunc(FormOpcoes.SpinEditCirculos.Value));
					WriteInteger(S, 'EspLinha', trunc(FormOpcoes.SpinEditEspessuraLinha.Value));
					WriteInteger(S, 'CorLinha', FormOpcoes.ColorEditLinha.SelectedColor);
					WriteInteger(S, 'CorFundo', FormOpcoes.ColorEditFundo.SelectedColor);
					WriteInteger(S, 'CorAbaixo', FormOpcoes.ColorEditAbaixoQuali.SelectedColor);
					WriteInteger(S, 'CorAcima', FormOpcoes.ColorEditAcimaQuali.SelectedColor);
					WriteInteger(S, 'EspessTarget', trunc(FormOpcoes.SpinEditEspLinhaQuali.Value));
					WriteInteger(S, 'PanelResidual Style', trunc(FormOpcoes.cmbxResidualStyle.ItemIndex));
					WriteInteger(S, 'PanelResultado Style', trunc(FormOpcoes.cmbxResultadoStyle.ItemIndex));
					WriteInteger(S, 'PanelDivisor Style', trunc(FormOpcoes.cmbxDivisorStyle.ItemIndex));
					WriteInteger(S, 'PanelResidual CorInicial', FormOpcoes.edtColorResidual1.SelectedColor);
					WriteInteger(S, 'PanelResidual CorFinal', FormOpcoes.edtColorResidual2.SelectedColor);
					WriteInteger(S, 'PanelResultado CorInicial', FormOpcoes.edtColorResultado1.SelectedColor);
					WriteInteger(S, 'PanelResultado CorFinal', FormOpcoes.edtColorResultado2.SelectedColor);
					WriteInteger(S, 'PanelDivisor CorInicial', FormOpcoes.edtColorDivisor1.SelectedColor);
					WriteInteger(S, 'PanelDivisor CorFinal', FormOpcoes.edtColorDivisor2.SelectedColor);
					WriteString(S, 'DirRel', FrmRelatorio.DirectoryModeloRelatorio.Text);
					WriteString(S, 'DirDados', FrmRelatorio.DirectoryDados.Text);
					WriteBool(S, 'CheckBox Alterações', FormOpcoes.chckbx2Planos.Checked);
					WriteBool(S, 'Residual Inicial', FormOpcoes.CheckBoxRI.Checked);
					WriteBool(S, 'CheckBox Ghost', FormOpcoes.ChckbxGost.Checked);
					WriteInteger(S, 'Resultado', FormOpcoes.RadioGroupResultado.ItemIndex);
					WriteBool(S, 'CheckBox Peso Prova', FormOpcoes.chckbxPesoProva.Checked);
					WriteBool(S, 'CheckBox Valor Inicial', FormOpcoes.chckbxValorInicial.Checked);
          WriteBool(S, 'Fixar Porta', FormOpcoes.chckbxFixaPorta.Checked);

					S := 'Calibração';
					WriteString(S, 'Massa1', FormOpcoes.NumIOCalAmplitude1.Text);
					WriteString(S, 'Massa2', FormOpcoes.NumIOCalAmplitude2.Text);
					WriteString(S, 'Angulo1', FormOpcoes.NumIOCalPhase1.Text);
					WriteString(S, 'Angulo2', FormOpcoes.NumIOCalPhase2.Text);

					S := 'Saida';
					WriteBool(S, 'Ativo', FormOpcoes.CheckBoxSaidaAtiva.Checked);
					WriteInteger(S, 'COM Port', FormOpcoes.PortComboBoxSaida.ComNumber);
					WriteString(S, 'Baud Rate', FormOpcoes.ComboBoxBRsaida.Text);
					WriteString(S, 'Baud Rate Main', FormOpcoes.ComboBoxBaudRate.Text);
					WriteString(S, 'TextoSaida', FormOpcoes.EditSaida.Text);

				end;
		finally
			Ini700.Free;
		end;
	except
		;
	end;
end;

procedure TfrmMain.btnTurnOffClick(Sender: TObject);
begin
	if MessageBox(Handle, 'Deseja realmente desligar o sistema?', 'Informação', MB_YESNO + MB_ICONQUESTION) = mrNo then
		Exit;
	machine_poweroff;
end;

procedure TfrmMain.cmbxMediaChange(Sender: TObject);
begin
	// ZeraMedia;
	if cmbxMedia.ItemIndex = -1 then
		cmbxMedia.ItemIndex := 0;
	Medias := StrToInt(cmbxMedia.Text);
end;

procedure TfrmMain.tlbtnEscalaClick(Sender: TObject);
var
	e, i: Byte;
begin
	for i := 1 to 2 do
		begin
			Vectormeter[i].PanelPlano.Visible := not tlbtnEscala.Down;
			Vectormeter[i].LabelScale.Visible := not tlbtnEscala.Down;
			Vectormeter[i].AutoScale := tlbtnEscala.Down;
			Vectormeter[i].TrackScale.Invalidate;
			for e := 0 to 25 do
				begin
					if Vectormeter[i].Scale = Escala[e] then
						Vectormeter[i].TrackScale.Position := e;
				end;
		end;
end;

procedure TfrmMain.tlbtnAjudaClick(Sender: TObject);
var
	S: string;
	hWndMe: HWnd;
begin
	S := IncludeTrailingBackslash(ExtractFilePath(Application.ExeName)) + 'Ajuda NK700.pdf';
	hWndMe := FindWindow(nil, 'Ajuda NK700');
	if (hWndMe <> 0) then
		begin
			if IsIconic(hWndMe) then
				ShowWindow(hWndMe, SW_SHOWNORMAL);
		end
	else
		ShellExecute(Handle, 'open', PChar(S), nil, nil, SW_SHOWNORMAL);
end;

procedure TfrmMain.tlbtnCalibrarClick(Sender: TObject);
begin
	// if MessageBox(frmMain.Handle,'Tem certeza de que deseja efetuar nova calibração?','Confirmação', MB_ICONQUESTION + MB_YESNO) = mrNo then exit;
	if tlbtnCalibrar.Down then
		begin
			frmCalibra.PageCalibra.ActivePage := frmCalibra.TabISO;
			frmCalibra.Show;
			frmCalibra.BringToFront;
		end
	else
		frmCalibra.Close;
end;

procedure TfrmMain.tlbtnValorInicialClick(Sender: TObject);
begin
	if MessageBox(frmMain.Handle, 'Definir este valor como inicial?', 'Confirmação', MB_ICONQUESTION + MB_YESNO) = mrNo then
		Exit;

	if frmCalibra.RadioButtonDoisPlanos.Checked or frmCalibra.RadioButtonMancal1.Checked then
		begin
			Gramas.Inicial[1] := Gramas.Final[1];
			Fase.Inicial[1] := Fase.Final[1];
			gmm.Inicial[1] := gmm.Final[1];
			ISOG.Inicial[1] := ISOG.Final[1];
		end;

	if frmCalibra.RadioButtonDoisPlanos.Checked or frmCalibra.RadioButtonMancal2.Checked then
		begin
			Gramas.Inicial[2] := Gramas.Final[2];
			Fase.Inicial[2] := Fase.Final[2];
			gmm.Inicial[2] := gmm.Final[2];
			ISOG.Inicial[2] := ISOG.Final[2];
		end;
end;

procedure TfrmMain.ToolButtonOpcoesClick(Sender: TObject);
begin
	FormOpcoes.Visible := ToolButtonOpcoes.Down;
end;

procedure TfrmMain.ToolButtonRefazMediaClick(Sender: TObject);
begin
	ZeraMedia;
	// if (VersaoHardware = 'USB') then
	// FormOpcoes.ButtonBuscaPortaClick(nil);
end;

procedure TfrmMain.ToolButtonRelatorioClick(Sender: TObject);
begin
	// FrmRelatorio.Visible := ToolButtonRelatorio.Down;
	// frmReport.Visible := ToolButtonRelatorio.Down;

end;

procedure TfrmMain.tlbtnSobreClick(Sender: TObject);
begin
	frmAbout.Show;
end;

procedure TfrmMain.tlbtnValorFinalClick(Sender: TObject);
var
	FileDados: TiniFile;
	i: Byte;
	S: String;
begin
	if not SaveDialogDados.Execute then
		Exit;
	FileDados := TiniFile.Create(SaveDialogDados.FileName);
	with FileDados do
		begin
			// WriteString('Dados','Cliente',frmCalibra.lbledtCliente.Text);
			// WriteString('Dados','Peça', frmCalibra.lbledtPeca.Text);
			// WriteString('Dados','Operador',frmCalibra.lbledtOperador.Text);
			// WriteString('Dados','Obs',frmCalibra.mmObs.Text);
			// WriteString('Dados','ImagemPeca', frmCalibra.FiguraRotor);
			WriteString('Dados', 'PesoRotor', frmCalibra.NumIOPesoRotor.Text);
			WriteString('Dados', 'ClasseISOG', frmCalibra.ComboBoxISO.Text);
			WriteString('Dados', 'RPMTrabalho', frmCalibra.NumIORPMTrabalho.Text);
			WriteString('Dados', 'RPMBalanceamento', MySetFormat(RPMReferencia));
			WriteString('Dados', 'Raio1', frmCalibra.NumIORaioM1.Text);
			WriteString('Dados', 'Raio2', frmCalibra.NumIORaioM2.Text);
			WriteString('Dados', 'ResidualRotorKg', MySetFormat(frmMain.ISO1940.ResidualRotorGmmKg));
			WriteString('Dados', 'ResidualPlano', MySetFormat(frmMain.ISO1940.ResidualPlanoPorPlanoGmm));

			with frmMain do
				for i := 1 to 2 do
					begin
						if not FormOpcoes.chckbx4casasdecimais.Checked then
							begin
								S := 'Inicial' + IntToStr(i);
								WriteString('Gramas', S, MySetFormat(Gramas.Inicial[i]));
								WriteString('Fase', S, MySetFormat(Fase.Inicial[i]));
								WriteString('gmm', S, MySetFormat(gmm.Inicial[i]));
								WriteString('ISOG', S, MySetFormat(ISOG.Inicial[i]));
								S := 'Final' + IntToStr(i);
								WriteString('Gramas', S, MySetFormat(Gramas.Final[i]));
								WriteString('Fase', S, MySetFormat(Fase.Final[i]));
								WriteString('ISOG', S, MySetFormat(ISOG.Final[i]));
								WriteString('gmm', S, MySetFormat(gmm.Final[i]));
								S := 'Ideal' + IntToStr(i);
								WriteString('Gramas', S, MySetFormat(Gramas.Ideal[i]));
								WriteString('gmm', S, MySetFormat(gmm.Ideal[i]));
								WriteString('ISOG', S, MySetFormat(ISOG.Ideal[i]));
							end
						else
							begin
								S := 'Inicial' + IntToStr(i);
								WriteString('Gramas', S, Format('%2.4f', [Gramas.Inicial[i]]));
								WriteString('Fase', S, Format('%2.4f', [Fase.Inicial[i]]));
								WriteString('gmm', S, Format('%2.4f', [gmm.Inicial[i]]));
								WriteString('ISOG', S, Format('%2.4f', [ISOG.Inicial[i]]));
								S := 'Final' + IntToStr(i);
								WriteString('Gramas', S, Format('%2.4f', [Gramas.Final[i]]));
								WriteString('Fase', S, Format('%2.4f', [Fase.Final[i]]));
								WriteString('ISOG', S, Format('%2.4f', [ISOG.Final[i]]));
								WriteString('gmm', S, Format('%2.4f', [gmm.Final[i]]));
								S := 'Ideal' + IntToStr(i);
								WriteString('Gramas', S, Format('%2.4f', [Gramas.Ideal[i]]));
								WriteString('gmm', S, Format('%2.4f', [gmm.Ideal[i]]));
								WriteString('ISOG', S, Format('%2.4f', [ISOG.Ideal[i]]));
							end;
					end;

			WriteBool('Dados', 'UmPlano', frmCalibra.RadioButtonUmPlano.Checked);
			WriteBool('Dados', 'PlanoUsado', frmCalibra.RadioButtonMancal1.Checked);
			WriteBool('Dados', 'Miligramas', frmCalibra.CheckBoxmg.Checked);

			// for i := Low(CamposLivresCal) to High(CamposLivresCal) do
			// begin
			// WriteString('Campo' + IntToStr(i), 'Texto',CamposLivresCal[i].Text);   //so se exitir
			// WriteString('Campo' + IntToStr(i), 'Titulo',CamposLivresCal[i].EditLabel.Caption);
			// end;
		end;
	FileDados.Free;
	FrmRelatorio.DirectoryDadosChange(nil);
end;

function TfrmMain.VerifyRPM: Boolean;
begin
	Result := False;
	frmCalibra.AdvTrackBar.Position := Round(Rotacao);
	AdvTrackBar.Position := Round(Rotacao);
	if Rotacao = 0 then
		begin
			Seta_Rele;
			ContaMedia := 0;
			GhostFilled := False;
		end;

	if (Rotacao >= RPMReferencia * 0.90) // era 0.97
		and (Rotacao < RPMReferencia * 1.10) then // era1.03
		begin
			Result := True;
			AdvTrackBar.Thumb.Shape := tsTriangle;
			frmCalibra.AdvTrackBar.Thumb.Shape := tsTriangle;
			StatusPaneMess.Caption := 'Rotação OK'
		end
	else
		begin
			if Rotacao < (RPMReferencia * 0.90) then // era 0.97
				begin
					AdvTrackBar.Thumb.Shape := tsTriangleLeft;
					frmCalibra.AdvTrackBar.Thumb.Shape := tsTriangleLeft;
					StatusPaneMess.Caption := 'Rotação abaixo da Referência';
				end;
			if Rotacao > (RPMReferencia * 1.10) then // era 1.03
				begin
					AdvTrackBar.Thumb.Shape := tsTriangleRight;
					frmCalibra.AdvTrackBar.Thumb.Shape := tsTriangleRight;
					StatusPaneMess.Caption := 'Rotação acima da Referência';
				end;
		end;
	StatusPaneMess.Refresh;
	frmCalibra.StatusPaneCalibra.Caption := StatusPaneMess.Caption;
end;

procedure TfrmMain.CompareNorma(Plano: Byte);
var
	S, Sa, U: string;
	V1, V2: single;
	Fator: single;
begin
	Sa := '';
	S := '';
	if not(frmMain.Vectormeter[Plano].Raio > 0) then
		Exit;
	if Plano = 1 then
		Fator := (frmCalibra.NumIORaioM1.Value / frmMain.Vectormeter[Plano].Raio)
	else
		Fator := (frmCalibra.NumIORaioM2.Value / frmMain.Vectormeter[Plano].Raio);

	case FormOpcoes.RadioGroupResultado.ItemIndex of
		// gramas
		0:
			begin
				if frmCalibra.CheckBoxmg.Checked then
					U := 'mg'
				else
					U := 'g';
				if Gramas.Ideal[Plano] > 0 then
					S := MySetFormat(Gramas.Ideal[Plano] * Fator);
				if Gramas.Final[Plano] > 0 then
					Sa := MySetFormat(Gramas.Final[Plano] * Fator); // * Fator);
			end;
		// G
		1:
			begin
				U := 'G';
				if frmCalibra.CheckBoxmg.Checked then
					frmMain.ISOG.Final[Plano] := frmMain.ISOG.Final[Plano] / 1000;
				if ISOG.Ideal[Plano] > 0 then
					S := MySetFormat(ISOG.Ideal[Plano]);
				if ISOG.Final[Plano] > 0 then
					Sa := MySetFormat(ISOG.Final[Plano]);
			end;
		// gmm
		2:
			begin
				if frmCalibra.CheckBoxmg.Checked then
					U := 'mg.mm'
				else
					U := 'g.mm';
				if gmm.Ideal[Plano] > 0 then
					S := MySetFormat(gmm.Ideal[Plano] * Fator);
				if gmm.Final[Plano] > 0 then
					Sa := MySetFormat(gmm.Final[Plano] * Fator); // * Fator);
			end;
	end; // case

	Vectormeter[Plano].TargetValue := Fator * frmMain.Gramas.Ideal[Plano];
	// verificar
	// Vectormeter[Plano].TargetValue :=  Gramas.Ideal[Plano];
	TryStrToFloat(S, V1);
	TryStrToFloat(S, V2);
	if (V1 > 0) and (V2 > 0) then
		Vectormeter[Plano].PanelResidual.Caption := 'Limite: ' + S + U + #13 + 'Atual: ' + Sa + U
	else
		Vectormeter[Plano].PanelResidual.Caption := 'Faltam dados!';

	if Gramas.Final[Plano] < Gramas.Ideal[Plano] then
		begin
			Vectormeter[Plano].PanelResidual.Font.Color := clGreen;
			Vectormeter[Plano].TargetLineColor := FormOpcoes.ColorEditAcimaQuali.SelectedColor;
			Vectormeter[Plano].PanelInfo1.Caption := 'Plano ' + IntToStr(Plano) + #13 + 'Aprovado';
			Vectormeter[Plano].PanelInfo1.Color := FormOpcoes.ColorEditAcimaQuali.SelectedColor;
			Vectormeter[Plano].PanelInfo1.VisualStyle := vsClassic;
		end
	else
		begin
			Vectormeter[Plano].PanelResidual.Font.Color := clRed;
			Vectormeter[Plano].TargetLineColor := FormOpcoes.ColorEditAbaixoQuali.SelectedColor;
			Vectormeter[Plano].PanelInfo1.Caption := 'Plano ' + IntToStr(Plano);
			Vectormeter[Plano].PanelInfo1.Color := clBtnFace;
			Vectormeter[Plano].PanelInfo1.VisualStyle := vsGradient;
		end;

	// Seta_Rele;//minha adição Thiago 06/08/2012

end;

procedure TfrmMain.TrataSaida();
var
	S: string;
begin
	try
		// ComPortSaida.WriteString(LastLineSaida);
		if Copy(UpperCase(LastLineSaida), 1, 7) = 'BALANCE' then
			ToolButtonRefazMediaClick(nil);
		if Copy(UpperCase(LastLineSaida), 1, 9) = 'RESULTADO' then
			begin
				S := FormataSaida(FormOpcoes.EditSaida.Text);
				frmMain.ComPortSaida.WriteString(S);
			end;
	except
		;
	end;
end;

procedure TfrmMain.ComPortSaidaDataRecived(Sender: TObject; Count: Integer);
var
	i, e: Integer;
begin
	LineSaida := ComPortSaida.ReadString;
	for i := 1 to Length(LineSaida) do
		begin
			LastLineSaida := LastLineSaida + LineSaida[i];
			if LineSaida[i] = #13 then
				begin
					TrataSaida;
					LastLineSaida := '';
				end;
		end;
end;

end.
