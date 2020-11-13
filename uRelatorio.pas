unit uRelatorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, RzButton, RzRadChk, RzPanel, Mask, RzEdit, RzSpnEdt, frxClass,
  frxPreview, ComCtrls, ShellCtrls, StdCtrls, ExtCtrls, Buttons, RzLabel,
  RzTabs, ExtDlgs, IniFiles, ShellApi, frxVariables, Main, RzCmboBx,
  AdvEdit, AdvEdBtn, AdvDirectoryEdit, frxExportPDF,frxDCtrl;

  type TResultado = (reGramas, reISOG, reGmm);
  type TResultados = set of TResultado;

  type
  TRelatorio = record
  //Cliente, Peca, Operador: string[100];
  Obs: string[200];
  RPMBalanceamento: single;
  PesoRotor, Raio1, Raio2: single;
  ResidualporPlano,ResidualRotorKg: single;
  RPMTrabalho: single;
  gmm, ISOG, Gramas, Fase: TValores;
  PlanoUsado: byte;
  NomeCampo, Campos: array of string[50];//array [1..8] of string[50];
  ImagemPeca: shortstring;
  UsouISO, Miligramas, DoisPlanos: Boolean;
  Resultados: TResultados;
  end;

type
  TFrmRelatorio = class(TForm)
    grpbxPreview: TGroupBox;
    frxPreview: TfrxPreview;
    RzPanel4: TRzPanel;
    PanelBase: TRzPanel;
    GroupBoxArquivos: TRzGroupBox;
    OpenPictureDialog: TOpenPictureDialog;
    frxReport: TfrxReport;
    GroupBox1: TGroupBox;
    lstvwRelatorio: TListView;
    GroupBox2: TGroupBox;
    lstvwDados: TListView;
    GroupBoxCliente: TRzGroupBox;
    DirectoryModeloRelatorio: TAdvDirectoryEdit;
    DirectoryDados: TAdvDirectoryEdit;
    frxPDFExport: TfrxPDFExport;
    tlbtnGeraRelatorio: TRzToolButton;
    TlbtnReDo: TRzToolButton;
    tlbtnEditarRelatorio: TRzToolButton;
    ButtonSalvaCal: TRzToolButton;
    SaveDialog: TSaveDialog;
    cmbxZoom: TComboBox;
    btnSalvarDados: TSpeedButton;
    btnAbrirDados: TSpeedButton;
    OpenDialog: TOpenDialog;
    ScrollBox: TScrollBox;
    btnFigura: TSpeedButton;
    edtFigura: TEdit;
    btnRetiraFigura: TSpeedButton;
    procedure tlbtnGeraRelatorioClick(Sender: TObject);
    procedure FileSearch(const PathName, FileName: string;  List: TListView; const InDir: boolean);
    procedure lstvwRelatorioClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpinEditZoomRelChange(Sender: TObject);
    procedure MontaPreview;
    procedure spbtnLimparImagemClick(Sender: TObject);
    procedure tlbtnEditarRelatorioClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DirectoryDadosChange(Sender: TObject);
    procedure DirectoryModeloRelatorioChange(Sender: TObject);
    procedure TlbtnReDoClick(Sender: TObject);
    procedure ChangeNotifierRelChange;
    procedure ChangeNotifierDadosChange;
    procedure ButtonSalvaCalClick(Sender: TObject);
    procedure lbledtOperadorChange(Sender: TObject);
    procedure lbledtPecaChange(Sender: TObject);
    procedure lbledtClienteChange(Sender: TObject);
    procedure cmbxZoomChange(Sender: TObject);
    procedure btnImagemClick(Sender: TObject);
    procedure btnSalvarDadosClick(Sender: TObject);
    procedure btnAbrirDadosClick(Sender: TObject);
    procedure TouchKeyBoardEnter(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnFiguraClick(Sender: TObject);
    procedure frxReportBeforePrint(Sender: TfrxReportComponent);
    procedure btnRetiraFiguraClick(Sender: TObject);
  private
    procedure AbreArquivoDados(FileName: string);
    procedure EditLabelOnDblClick(Sender: TObject);

    { Private declarations }
  public
    Relatorio : TRelatorio;
    FiguraRotor: String;
    { Public declarations }
  end;

var
  FrmRelatorio: TFrmRelatorio;
  CamposLivresRel: array of TLabeledEdit;//array [1..8] of TLabeledEdit;

implementation

uses Geral, uCalibra, uOpcoes, uWizReport, uReport; //uTeclado;//, GeradorRelatorio;

{$R *.dfm}

procedure TFrmRelatorio.btnAbrirDadosClick(Sender: TObject);
var
i: byte;
FileDados : TiniFile;
begin
  if not OpenDialog.Execute then exit;
  FileDados := TIniFile.Create(OpenDialog.FileName);
  with FileDados do
    begin
    for i := 0 to High(CamposLivresRel) do
      begin
      if CamposLivresRel[i] <> nil then
        CamposLivresRel[i].Text := ReadString('Dados Adicionais',CamposLivresRel[i].EditLabel.Caption, '');
      end;
    edtFigura.Text := ReadString('Dados','ImagemPeca', '');
    FrmRelatorio.FiguraRotor := edtFigura.Text;
    end;
end;
procedure TFrmRelatorio.btnFiguraClick(Sender: TObject);
begin
  if not OpenPictureDialog.Execute then
    exit;

  FiguraRotor := OpenPictureDialog.FileName;
  edtFigura.Text := FiguraRotor;
  frxReport.PrepareReport;
end;

procedure TFrmRelatorio.btnImagemClick(Sender: TObject);
begin
  if not OpenPictureDialog.Execute then exit;
  FiguraRotor := OpenPictureDialog.FileName;
  //imgPeca.Picture.LoadFromFile(OpenPictureDialog.FileName);
  //LabelNomeFigura.Caption := ExtractFileName(FiguraRotor);
  //LabelNomeFigura.Caption := StringReplace(LabelNomeFigura.Caption,ExtractFileExt(FiguraRotor),'', [rfReplaceAll]);
  //TfrxPictureView(frxReport.FindObject('Desenho')).Picture.LoadFromFile(OpenPictureDialog.FileName);
end;

procedure TFrmRelatorio.btnSalvarDadosClick(Sender: TObject);
var
i: byte;
FileDados : TiniFile;
begin
  if not SaveDialog.Execute then exit;
  FileDados := TIniFile.Create(SaveDialog.FileName);
  with FileDados do
    begin
    for i := 0 to High(CamposLivresRel) do
      begin
      if CamposLivresRel[i] <> nil then
        WriteString('Dados Adicionais',CamposLivresRel[i].EditLabel.Caption, CamposLivresRel[i].Text);
      end;

    WriteString('Dados','ImagemPeca', FrmRelatorio.FiguraRotor);
    end;
end;

procedure TFrmRelatorio.ButtonSalvaCalClick(Sender: TObject);
var
  FileDados : TiniFile;
  i: byte;
  S: string;
begin
  SaveDialog.DefaultExt := '.BalDados';
  SaveDialog.FileName := '*.BalDados';
  SaveDialog.Filter:= 'Arquivo de Dados NK700|*.BalDados';

  if not SaveDialog.Execute then exit;
  FileDados := TIniFile.Create(SaveDialog.FileName);
  with FileDados do
    begin
    //WriteString('Dados','Cliente',FrmRelatorio.lbledtCliente.Text);
    //WriteString('Dados','Peça', FrmRelatorio.lbledtPeca.Text);
    //WriteString('Dados','Operador',FrmRelatorio.lbledtOperador.Text);
    //WriteString('Dados','Obs',FrmRelatorio.mmObs.Text);
    //WriteString('Dados','ImagemPeca', FrmRelatorio.FiguraRotor);
    WriteString('Dados','PesoRotor',frmCalibra.NumIOPesoRotor.Text);
    WriteString('Dados','ClasseISOG',frmCalibra.ComboBoxISO.Text);
    WriteString('Dados','RPMTrabalho', frmCalibra.NumIORPMTrabalho.Text);
    WriteString('Dados','RPMBalanceamento',MySetFormat(RPMReferencia));
    WriteString('Dados','Raio1', frmCalibra.NumIORaioM1.Text);
    WriteString('Dados','Raio2', frmCalibra.NumIORaioM2.Text);

    {with FrmMain do for I := 1 to 2 do
      begin
      S := 'Inicial' + IntToStr(i);
      WriteString('Gramas', S, MySetFormat(Gramas.Inicial[i]));
      WriteString('Fase',S, MySetFormat(Fase.Inicial[i]));
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
      end;}

    WriteBool('Dados','UmPlano', frmCalibra.RadioButtonUmPlano.Checked);
    WriteBool('Dados','PlanoUsado',frmCalibra.RadioButtonMancal1.Checked);
    WriteBool('Dados','Miligramas',frmCalibra.CheckBoxmg.Checked);

    for i := Low(CamposLivresRel) to High(CamposLivresRel) do
      begin
      WriteString('Campo' + IntToStr(i), 'Texto',CamposLivresRel[i].Text);   //so se exitir
      WriteString('Campo' + IntToStr(i), 'Titulo',CamposLivresRel[i].EditLabel.Caption);
      end;
    end;
  FileDados.Free;
end;

procedure TFrmRelatorio.ChangeNotifierDadosChange;
begin
  DirectoryDadosChange(nil);
end;

procedure TFrmRelatorio.ChangeNotifierRelChange;
begin
  DirectoryModeloRelatorioChange(nil);
end;

procedure TFrmRelatorio.cmbxZoomChange(Sender: TObject);
begin
  case cmbxZoom.ItemIndex of
  0 : frxPreview.Zoom := 0.25;
  1 : frxPreview.Zoom := 0.5;
  2 : frxPreview.Zoom := 0.75;
  3 : frxPreview.Zoom := 1;
  4 : frxPreview.ZoomMode := zmWholePage;
  5 : frxPreview.ZoomMode := zmPageWidth;
  end;
end;

procedure TFrmRelatorio.DirectoryDadosChange(Sender: TObject);
begin
  lstvwDados.Clear;
  FileSearch(DirectoryDados.Text ,'*.BalDados',lstvwDados,False);
  //ChangeNotifierDados.Root := DirectoryDados.Text;
end;

procedure TFrmRelatorio.DirectoryModeloRelatorioChange(Sender: TObject);
begin
  lstvwRelatorio.Clear;
  FileSearch(DirectoryModeloRelatorio.text,'*.fr3',lstvwRelatorio,False);
	//ChangeNotifierRel.Root := DirectoryModeloRelatorio.Text;
end;

procedure TFrmRelatorio.spbtnLimparImagemClick(Sender: TObject);
begin
  //imgPeca.Picture.Graphic := nil;
  //LabelNomeFigura.Caption := '';
  //lstvwRelatorioClick(nil);
end;

procedure TFrmRelatorio.lbledtClienteChange(Sender: TObject);
//var
//Reg: TRegistry;
begin
  {Reg:= TRegistry.Create;
   try
     Reg.RootKey := HKEY_CURRENT_USER;
     if Reg.OpenKey('SOFTWARE\NK700', TRUE) then begin
       Reg.WriteString('Cliente', lbledtCliente.Text);
     end;
   finally
     Reg.Free;
   end;}
end;

procedure TFrmRelatorio.lbledtOperadorChange(Sender: TObject);
//var
//Reg: TRegistry;
begin
  {Reg:= TRegistry.Create;
   try
     Reg.RootKey := HKEY_CURRENT_USER;
     if Reg.OpenKey('SOFTWARE\NK700', TRUE) then begin
       Reg.WriteString('Operador', lbledtOperador.Text);
     end;
   finally
     Reg.Free;
   end; }
end;

procedure TFrmRelatorio.lbledtPecaChange(Sender: TObject);
//var
//Reg: TRegistry;
begin
  {Reg:= TRegistry.Create;
   try
     Reg.RootKey := HKEY_CURRENT_USER;
     if Reg.OpenKey('SOFTWARE\NK700', TRUE) then begin
       Reg.WriteString('Peça', lbledtPeca.Text);
     end;
   finally
     Reg.Free;
   end;}
end;

procedure TFrmRelatorio.TouchKeyBoardEnter(Sender: TObject);
begin
  {if FormOpcoes.chckKeyboard.checked then
    begin
    frmkeyboard.show;
    frmkeyboard.MyTouchKeyboard.Layout := 'Standard';
    end;}
end;

procedure TFrmRelatorio.lstvwRelatorioClick(Sender: TObject);
var
i: byte;
sl: TStringList;
begin
  if (TListView(Sender).Name = 'lstvwRelatorio') then
  begin
  FiguraRotor := '';
  //imgPeca.Picture.Graphic := nil;
  //LabelNomeFigura.Caption := '-';
  if (lstvwRelatorio.Selected <> nil) then //and (lstvwDados.Selected = nil) then
    begin
    frxReport.Clear;
    frxReport.LoadFromFile(TReportFile(lstvwRelatorio.Selected.Data).FileName);
    btnSalvarDados.Enabled := True;
    btnAbrirDados.Enabled := True;
    btnFigura.Enabled := True;
    //edtFigura.Enabled := True;
    btnRetiraFigura.Enabled := True;

    sl := TStringList.Create;
    frxReport.Variables.GetVariablesList('Dados Adicionais',sl);

    if (Length(CamposLivresRel) > 0) then
      begin
      if High(CamposLivresRel) <> (sl.Count - 1) then
        begin
        for i := 0 to High(CamposLivresRel) do
          begin
          if CamposLivresRel[i] <> nil then
            FreeAndNil(CamposLivresRel[i]);
          end;
        end;
      end;


    SetLength(CamposLivresRel,sl.Count);
    SetLength(Relatorio.NomeCampo,sl.Count);
    SetLength(Relatorio.Campos,sl.Count);


    if (Length(CamposLivresRel) > 0) then
      begin
      for i := 0 to sl.Count - 1 do//for i := 1 to High(CamposLivresRel) do
        begin
        if CamposLivresRel[i] <> nil then
          FreeAndNil(CamposLivresRel[i]);
        end;
      end;


    for i := 0 to sl.Count - 1 do
        begin
        CamposLivresRel[i] := TLabeledEdit.Create(Self);
        CamposLivresRel[i].Parent := ScrollBox;//GroupBoxCliente;
        CamposLivresRel[i].Top := (((i+1) * 30));
        CamposLivresRel[i].Left := 120;
        CamposLivresRel[i].Width := 200;
        CamposLivresRel[i].EditLabel.ShowHint := true;
        CamposLivresRel[i].EditLabel.Caption := sl[i];//sl[i-1];
        CamposLivresRel[i].LabelPosition := lpLeft;
        CamposLivresRel[i].OnEnter := TouchKeyBoardEnter;
        end;
     cmbxZoom.ItemIndex := 3;
     cmbxZoomChange(nil);
     frxReport.PrepareReport;
    end;
  end;

  //FrxPreview.Zoom := SpinEditZoomRel.Value / 10;

  if (TListView(Sender).Name = 'lstvwDados') then
    begin
    if (lstvwDados.Selected <> nil) then
      AbreArquivoDados(TReportFile(lstvwDados.Selected.Data).FileName)
    else
      begin
        //lbledtCliente.Text := ''; // apagar todos
      end;
    end;

  if (lstvwRelatorio.Selected <> nil) and (lstvwDados.Selected <> nil) then
    begin
    frxReport.LoadFromFile(TReportFile(lstvwRelatorio.Selected.Data).FileName);
    //Relatorio.Cliente :=lbledtCliente.Text;
    //Relatorio.Peca := lbledtPeca.Text;
    //Relatorio.Operador := lbledtOperador.Text;
    //Relatorio.Obs := mmObs.Text;
    Relatorio.ImagemPeca := FiguraRotor;

    MontaPreview;
    frxReport.PrepareReport;
    grpbxPreview.Caption := StringReplace(ExtractFileName(TReportFile(lstvwRelatorio.Selected.Data).FileName), '.fr3','', [rfReplaceAll]);
    end;
end;

procedure TfrmRelatorio.AbreArquivoDados(FileName: string);
var
  FileDados: TInifile;
  i: byte;
  S : String;
  NK700Format: TFormatSettings;
  sl: TStringList;
begin
  NK700Format.ThousandSeparator := '.';
  NK700Format.DecimalSeparator := ',';
  sl := TStringList.Create;
  sl.LoadFromFile(FileName);
  sl.Text := StringReplace(sl.Text,'.',',',[rfReplaceAll]);
  sl.SaveToFile(FileName);
  FileDados := TIniFile.Create(FileName);
  with FileDados do
    begin
    //lbledtCliente.Text  := ReadString('Dados','Cliente','');
    //lbledtPeca.Text := ReadString('Dados','Peça', '');
    //lbledtOperador.Text := ReadString('Dados','Operador','');
    //mmObs.Text := ReadString('Dados','Obs','');
    //FiguraRotor := ReadString('Dados','ImagemPeca', '');
    {if FileExists(FiguraRotor) then
      begin
      imgPeca.Picture.LoadFromFile(FiguraRotor);
      LabelNomeFigura.Caption := ExtractFileName(FiguraRotor);
      LabelNomeFigura.Caption := StringReplace(LabelNomeFigura.Caption,ExtractFileExt(FiguraRotor),'', [rfReplaceAll]);
      end
    else frmRelatorio.LabelNomeFigura.Caption := 'Figura não encontrada!';}
    //este bloco estava usando Try
    //Relatorio.PesoRotor := ReadString('Dados','PesoRotor','');
    //Relatorio.Raio1 := ReadString('Dados','Raio1', '');
    //Relatorio.Raio2 := ReadString('Dados','Raio2', '');
    TryStrToFloat(ReadString('Dados','PesoRotor',''), Relatorio.PesoRotor);
    TryStrToFloat(ReadString('Dados','RPMTrabalho', ''), Relatorio.RPMTrabalho);
    TryStrToFloat(ReadString('Dados','RPMBalanceamento',''), Relatorio.RPMBalanceamento);
    TryStrToFloat(ReadString('Dados','Raio1', ''), Relatorio.Raio1);
    TryStrToFloat(ReadString('Dados','Raio2', ''), Relatorio.Raio2);

    TryStrToFloat(ReadString('Dados','ResidualRotorKg', ''), Relatorio.ResidualRotorKg);
    TryStrToFloat(ReadString('Dados','ResidualPlano', ''), Relatorio.ResidualporPlano);

    //para evitar que os valores não apareçam devido decimalseparator diferente
    //Relatorio.PesoRotor := ChangeDecSep(ReadString('Dados','PesoRotor',''));
    //Relatorio.RPMTrabalho :=  ChangeDecSep(ReadString('Dados','RPMTrabalho', ''));
    //Relatorio.RPMBalanceamento := ChangeDecSep(ReadString('Dados','RPMBalanceamento',''));
    //Relatorio.Raio1 := ChangeDecSep(ReadString('Dados','Raio1', ''));
    //Relatorio.Raio2 := ChangeDecSep(ReadString('Dados','Raio2', ''));

    with FrmMain do for i := 1 to 2 do
      begin
      S := 'Inicial' + IntToStr(i);
      TryStrToFloat(ReadString('Gramas', S, ''), Relatorio.Gramas.Inicial[i]);
      TryStrToFloat(ReadString('Fase', S, ''), Relatorio.Fase.Inicial[i]);
      TryStrToFloat(ReadString('gmm', S, ''), Relatorio.gmm.Inicial[i]);
      TryStrToFloat(ReadString('ISOG', S, ''), Relatorio.ISOG.Inicial[i]);

      S := 'Ideal' + IntToStr(i);
      TryStrToFloat(ReadString('Gramas', S, ''), Relatorio.Gramas.Ideal[i]);
      TryStrToFloat(ReadString('gmm', S, ''), Relatorio.gmm.Ideal[i]);
      TryStrToFloat(ReadString('ISOG', S, ''), Relatorio.ISOG.Ideal[i]);

      S := 'Final' + IntToStr(i);
      TryStrToFloat(ReadString('Gramas', S, ''), Relatorio.Gramas.Final[i]);
      TryStrToFloat(ReadString('Fase', S, ''), Relatorio.Fase.Final[i]);
      TryStrToFloat(ReadString('gmm', S, ''), Relatorio.gmm.Final[i]);
      TryStrToFloat(ReadString('ISOG', S, ''), Relatorio.ISOG.Final[i]);
      end;

    Relatorio.UsouISO := frmCalibra.RadioButtonIso.Checked;
    Relatorio.DoisPlanos := not ReadBool('Dados','UmPlano', False);
    Relatorio.Miligramas := ReadBool('Dados','Miligramas', False);

    if ReadBool('Dados','PlanoUsado', True) then Relatorio.PlanoUsado := 1
    else Relatorio.PlanoUsado := 2;

    {for i := Low(Relatorio.Campos) to High(Relatorio.Campos) do
      begin
      CamposLivresRel[i].text := ReadString('Campo' + IntToStr(i), 'Texto', '');
      CamposLivresRel[i].EditLabel.Caption := ReadString('Campo' + IntToStr(i), 'Titulo', '');
      end;}
    end;
  FileDados.Free;
  if Relatorio.DoisPlanos then
    begin
    //FrmRelatorio.CheckBoxGrama.Enabled := (Relatorio.Gramas.Ideal[1] > 1e-10) and (Relatorio.Gramas.Final[1] > 1e-10)
      //and (Relatorio.Gramas.Ideal[2] > 1e-10) and (Relatorio.Gramas.Final[2] > 1e-10);
    //FrmRelatorio.CheckBoxISO.Enabled := (Relatorio.ISOG.Ideal[1] > 1e-10) and (Relatorio.ISOG.Final[1] > 1e-10)
      //and (Relatorio.ISOG.Ideal[2] > 1e-10) and (Relatorio.ISOG.Final[2] > 1e-10);
    //FrmRelatorio.CheckBoxGmm.Enabled := (Relatorio.Gmm.Inicial[1] > 1e-10) and (Relatorio.Gmm.Final[1] > 1e-10)
      //and (Relatorio.Gmm.Ideal[2] > 1e-10) and (Relatorio.Gmm.Final[2] > 1e-10);
    end;
  if Relatorio.PlanoUsado = 1 then
    begin
    //FrmRelatorio.CheckBoxGrama.Enabled := (Relatorio.Gramas.Ideal[1] > 1e-10) and (Relatorio.Gramas.Final[1] > 1e-10);
    //FrmRelatorio.CheckBoxISO.Enabled := (Relatorio.ISOG.Ideal[1] > 1e-10) and (Relatorio.ISOG.Final[1] > 1e-10);
    //FrmRelatorio.CheckBoxGmm.Enabled := (Relatorio.Gmm.Ideal[1] > 1e-10) and (Relatorio.Gmm.Final[1] > 1e-10);
    end;
  if Relatorio.PlanoUsado = 2 then
    begin
    //FrmRelatorio.CheckBoxGrama.Enabled := (Relatorio.Gramas.Ideal[2] > 1e-10) and (Relatorio.Gramas.Final[2] > 1e-10);
    //FrmRelatorio.CheckBoxISO.Enabled := (Relatorio.ISOG.Ideal[2] > 1e-10) and (Relatorio.ISOG.Final[2] > 1e-10);
    //FrmRelatorio.CheckBoxGmm.Enabled := (Relatorio.Gmm.Ideal[2] > 1e-10) and (Relatorio.Gmm.Final[2] > 1e-10);
    end;
end;

procedure TFrmRelatorio.btnRetiraFiguraClick(Sender: TObject);
begin
  if MessageBox(Handle,'Deseja realmente apagar a figura?', 'Informação', MB_YESNO + MB_ICONINFORMATION) = mrNo then exit;
  edtFigura.Clear;
  FiguraRotor := '';
  frxReport.PrepareReport;
end;

procedure TFrmRelatorio.SpinEditZoomRelChange(Sender: TObject);
begin
  //FrxPreview.Zoom := SpinEditZoomRel.Value / 10;
  
end;

procedure TFrmRelatorio.FormActivate(Sender: TObject);
begin
  //frmKeyboard.MyTouchKeyboard.HandleOfTheTargetForm := Self.Handle;
end;

procedure TFrmRelatorio.FormClose(Sender: TObject; var Action: TCloseAction);
var
i: byte;
begin
  //Action := caNone;
  frmMain.ToolButtonRelatorio.Down := false;
  frmMain.ToolButtonRelatorioClick(nil);
  frxReport.Clear;
  frxPreview.Clear;
end;

procedure TFrmRelatorio.FormCreate(Sender: TObject);
var
  i:byte;
  Ini700 : TiniFile;
  //Reg: TRegistry;
  S: string;
begin
  frxPreview.ZoomMode := zmWholePage;
  S := IncludeTrailingBackslash(frmMain.GetSpecialFolderPath);
  S := IncludeTrailingBackslash(S) + 'Teknikao\NK700\';
  if ForceDirectories(S) then  S := S + 'NK700.ini';
  Ini700 := TIniFile.Create(S);

  //Ini700 := TIniFile.Create(IncludeTrailingBackslash(ExtractFilePath(Application.ExeName)) + 'NK700.ini');
   with Ini700 do
    begin
      DirectoryModeloRelatorio.Text := ReadString('Opcoes', 'DirRel', GetMyDocuments + '\Arquivos de Balanceamento');
      DirectoryModeloRelatorioChange(nil);
      DirectoryDados.Text := ReadString('Opcoes', 'DirDados', GetMyDocuments + '\Arquivos de Balanceamento');
      //FrmRelatorio.DirectoryModeloRelatorio.Text := ReadString('Opcoes', 'DirRel', '');
      //FrmRelatorio. DirectoryDados.Text := ReadString('Opcoes', 'DirDados', '');
      DirectoryDadosChange(nil);
      {for i := 1 to High(CamposLivresRel) do
        begin
        frxReport.Script.AddVariable('Campo ' + IntToStr(i), 'string','');
        CamposLivresRel[i] := TLabeledEdit.Create(Self);
        CamposLivresRel[i].Parent := GroupBoxCliente;
        CamposLivresRel[i].Top := (((i) * 30));
        CamposLivresRel[i].Left := 97;
        CamposLivresRel[i].Width := 142;
        CamposLivresRel[i].EditLabel.Hint := 'Dois cliques para mudar o nome do campo.' + #13 + 'Deixar vazio para não aparecer no relatório';
        CamposLivresRel[i].Hint := CamposLivresRel[i].EditLabel.Hint;
        CamposLivresRel[i].EditLabel.ShowHint := true;
        CamposLivresRel[i].Tag := i;
        CamposLivresRel[i].EditLabel.Tag := i;
        CamposLivresRel[i].EditLabel.Caption := 'Campo ' + IntToStr(i);//ReadString('Campos', 'Campo' + IntToStr(i), 'Campo ' + IntToStr(i));
        CamposLivresRel[i].EditLabel.OnDblClick := EditLabelOnDblClick;
        CamposLivresRel[i].OnDblClick := EditLabelOnDblClick;
        CamposLivresRel[i].LabelPosition := lpLeft;
        end; }
    end;
  Ini700.Free;
  DirectoryModeloRelatorioChange(nil);
  DirectoryDadosChange(nil);
  
end;

procedure TFrmRelatorio.frxReportBeforePrint(Sender: TfrxReportComponent);
begin
  if (Sender is TfrxPictureView) then
  begin
  if (FiguraRotor <> '') and (TfrxPictureView(Sender).Name = 'PicturePeca') then
    begin
    TfrxPictureView(Sender).Picture.LoadFromFile(FiguraRotor);
    end;
  end;
end;

procedure TFrmRelatorio.EditLabelOnDblClick(Sender: TObject);
//var
//Reg: TRegistry;
begin
  CamposLivresRel[TControl(Sender).Tag].EditLabel.Caption := InputBox('Nome do Campo', 'Nome do Campo', CamposLivresRel[TControl(Sender).Tag].EditLabel.Caption);
end;

procedure TFrmRelatorio.FileSearch(const PathName, FileName : string; List: TListView; const InDir : boolean);
var Rec  : TSearchRec;
    Path : string;
    Item: TListItem;
begin
Path := IncludeTrailingBackslash(PathName);
if FindFirst(Path + FileName, faAnyFile - faDirectory, Rec) = 0 then
 try
   repeat
     Item := List.Items.Add;
     Item.Data := TReportFile.Create(Path + Rec.Name);
     Item.Caption := Rec.Name;
   until FindNext(Rec) <> 0;
 finally
   FindClose(Rec);
 end;

If not InDir then Exit;

if FindFirst(Path + '*.*', faDirectory, Rec) = 0 then
 try
   repeat
    if ((Rec.Attr and faDirectory) <> 0)  and (Rec.Name<>'.') and (Rec.Name<>'..') then
     FileSearch(Path + Rec.Name, FileName,List, True);
   until FindNext(Rec) <> 0;
 finally
   FindClose(Rec);
 end;
end;

procedure TFrmRelatorio.tlbtnEditarRelatorioClick(Sender: TObject);
var
S,T: string;
val: integer;
begin
  (*S := IncludeTrailingBackslash(ExtractFilePath(Application.ExeName))+ 'Relatorio.exe';
  T := '';
  if lstvwRelatorio.Selected <> nil then
    T := TReportFile(lstvwRelatorio.Selected.Data).FileName;

  ShellExecute(Handle,'open',PChar(T),nil{PChar(T)},nil, SW_SHOWNORMAL); *)
  if lstvwRelatorio.Selected <> nil then
    T := TReportFile(lstvwRelatorio.Selected.Data).FileName;
  frmReport.frxReport1.LoadFromFile(T);
  frmReport.Show;
  //application.ProcessMessages;
  {FrmRelatorio.Close;
  S :='';
  if lstvwRelatorio.Selected <> nil then
    S := TReportFile(lstvwRelatorio.Selected.Data).FileName;

  if not Assigned(frmGeradorRelatorio) then
    begin
      try
      frmGeradorRelatorio := TfrmGeradorRelatorio.Create(Self);
      frmGeradorRelatorio.ShowModal;
      frmGeradorRelatorio.frxReport.LoadFromFile(S);
      finally;

      FreeAndNil(frmGeradorRelatorio);
      end;
    end;}
end;

procedure TFrmRelatorio.TlbtnReDoClick(Sender: TObject);
var
  i: byte;
begin
  if (lstvwRelatorio.Selected = nil) or (lstvwDados.Selected = nil) then exit;
  //if CheckBoxGrama.Checked and CheckBoxGrama.Enabled then Include(Relatorio.Resultados, reGramas)
  //else Exclude(Relatorio.Resultados, reGramas);

  //if CheckBoxISO.Checked and CheckBoxISO.Enabled then Include(Relatorio.Resultados, reISOG)
  //else Exclude(Relatorio.Resultados, reISOG);

  //if CheckBoxGmm.Checked and CheckBoxGmm.Enabled then Include(Relatorio.Resultados, reGmm)
  //else Exclude(Relatorio.Resultados, reGmm);

  for i := Low(Relatorio.Campos) to High(Relatorio.Campos) do
    begin
    if CamposLivresRel[i] <> nil then
      begin
      Relatorio.Campos[i] := CamposLivresRel[i].Text;
      Relatorio.NomeCampo[i] := CamposLivresRel[i].EditLabel.Caption;
      end;
    end;

  //Relatorio.Cliente :=lbledtCliente.Text;
  //Relatorio.Peca := lbledtPeca.Text;
  //Relatorio.Operador := lbledtOperador.Text;
  //Relatorio.Obs := mmObs.Text;
  Relatorio.ImagemPeca := FiguraRotor;
  MontaPreview;
  //FrxPreview.Zoom := SpinEditZoomRel.Value / 10;
  frxReport.PrepareReport;
end;

procedure TFrmRelatorio.tlbtnGeraRelatorioClick(Sender: TObject);
begin
  frxPDFExport.ShowDialog := False;
  frxPDFExport.ShowProgress := False;
  frxPDFExport.OpenAfterExport := True;
  SaveDialog.DefaultExt := '.pdf';
  SaveDialog.FileName := '*.pdf';
  SaveDialog.Filter:= 'Arquivo de Relatório|*.pdf';
  if not SaveDialog.Execute then exit;
  frxPDFExport.FileName := SaveDialog.FileName;
  frxReport.PrepareReport;
  frxReport.Export(frxPDFExport);
end;

procedure TFrmRelatorio.MontaPreview;
var
  Category, Variable: TfrxVariable;
  i: byte;
  Existe: Boolean;
  Campo: TfrxMemoView;
  Picture : TfrxPictureView;
begin
  //PreencheRecord;
  frxReport.Variables.Clear;
  with frmMain do
    begin


    //Balanceamento
    Category := frxReport.Variables.Add;
    Category.Name := ' ' + 'Balanceamento';

    {Variable := frxReport.Variables.Add;
    Variable.Name := 'ISO G';
    Variable.Value := Relatorio.ISOG.Inicial[1]; //??
    }
    Variable := frxReport.Variables.Add;
    Variable.Name := 'RPM Trabalho';
    Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.RPMTrabalho]));//Relatorio.RPMTrabalho;

    Variable := frxReport.Variables.Add;
    Variable.Name := 'RPM Balanceamento';
    Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.RPMBalanceamento]));

    Variable := frxReport.Variables.Add;
    Variable.Name := 'Peso Rotor';
    //Variable.Value := Relatorio.PesoRotor;
    Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.PesoRotor]));

    Variable := frxReport.Variables.Add;
    Variable.Name := 'Raio 1';
    //Variable.Value := Relatorio.Raio1;
    Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Raio1]));

    Variable := frxReport.Variables.Add;
    Variable.Name := 'Raio 2';
    //Variable.Value := Relatorio.Raio2;
    Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Raio2]));

    Variable := frxReport.Variables.Add;
    Variable.Name := 'Residual por Plano';
    //Variable.Value := Relatorio.Raio2;
    Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.ResidualporPlano]));

    Variable := frxReport.Variables.Add;
    Variable.Name := 'Residual Rotor Kg';
    //Variable.Value := Relatorio.Raio2;
    Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.ResidualRotorKg]));


    Variable := frxReport.Variables.Add;
    Variable.Name := 'Ângulo Inicial 1';
    Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Fase.Inicial[1]]));

    Variable := frxReport.Variables.Add;
    Variable.Name := 'Ângulo Inicial 2';
    Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Fase.Inicial[2]]));

    Variable := frxReport.Variables.Add;
    Variable.Name := 'Ângulo Final 1';
    Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Fase.Final[1]]));

    Variable := frxReport.Variables.Add;
    Variable.Name := 'Ângulo Final 2';
    Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Fase.Final[2]]));

    if not FormOpcoes.chckbx4casasdecimais.Checked then
      begin
      Variable := frxReport.Variables.Add;
      Variable.Name := 'Peso Inicial 1';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Gramas.Inicial[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'gmm Inicial 1';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.gmm.Inicial[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'gmm Inicial 2';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.gmm.Inicial[2]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'ISOG Inicial 1';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.ISOG.Inicial[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'ISOG Inicial 2';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.ISOG.Inicial[2]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Peso Inicial 2';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Gramas.Inicial[2]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Peso Final 1';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Gramas.Final[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Peso Final 2';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Gramas.Final[2]]));

      //residual ideal e atual grama
      Variable := frxReport.Variables.Add;
      Variable.Name := 'Ideal Gramas 1';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Gramas.Ideal[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Ideal Gramas 2';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Gramas.Ideal[2]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Atual Gramas 1';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Gramas.Final[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Atual Gramas 2';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Gramas.Final[2]]));

      //residual ideal e atual ISOG
      Variable := frxReport.Variables.Add;
      Variable.Name := 'Ideal ISOG 1';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.ISOG.Ideal[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Ideal ISOG 2';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.ISOG.Ideal[2]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Atual ISOG 1';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.ISOG.Final[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Atual ISOG 2';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.ISOG.Final[2]]));
      //soma dos ISOGs
      Variable := frxReport.Variables.Add;
      Variable.Name := 'Total Atual ISOG';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.ISOG.Final[1]+Relatorio.ISOG.Final[2]]));

      //residual ideal e atual g.mm
      Variable := frxReport.Variables.Add;
      Variable.Name := 'Ideal gmm 1';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Gmm.Ideal[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Ideal gmm 2';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Gmm.Ideal[2]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Atual gmm 1';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Gmm.Final[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Atual gmm 2';
      Variable.Value := QuotedStr(Format('%2.2f',[Relatorio.Gmm.Final[2]]));
      end
    else
      begin
      Variable := frxReport.Variables.Add;
      Variable.Name := 'Peso Inicial 1';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.Gramas.Inicial[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'gmm Inicial 1';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.gmm.Inicial[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'gmm Inicial 2';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.gmm.Inicial[2]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'ISOG Inicial 1';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.ISOG.Inicial[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'ISOG Inicial 2';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.ISOG.Inicial[2]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Peso Inicial 2';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.Gramas.Inicial[2]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Peso Final 1';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.Gramas.Final[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Peso Final 2';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.Gramas.Final[2]]));

      //residual ideal e atual grama
      Variable := frxReport.Variables.Add;
      Variable.Name := 'Ideal Gramas 1';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.Gramas.Ideal[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Ideal Gramas 2';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.Gramas.Ideal[2]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Atual Gramas 1';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.Gramas.Final[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Atual Gramas 2';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.Gramas.Final[2]]));

      //residual ideal e atual ISOG
      Variable := frxReport.Variables.Add;
      Variable.Name := 'Ideal ISOG 1';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.ISOG.Ideal[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Ideal ISOG 2';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.ISOG.Ideal[2]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Atual ISOG 1';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.ISOG.Final[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Atual ISOG 2';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.ISOG.Final[2]]));

      //soma dos ISOGs
      Variable := frxReport.Variables.Add;
      Variable.Name := 'Total Atual ISOG';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.ISOG.Final[1]+Relatorio.ISOG.Final[2]]));

      //residual ideal e atual g.mm
      Variable := frxReport.Variables.Add;
      Variable.Name := 'Ideal gmm 1';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.Gmm.Ideal[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Ideal gmm 2';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.Gmm.Ideal[2]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Atual gmm 1';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.Gmm.Final[1]]));

      Variable := frxReport.Variables.Add;
      Variable.Name := 'Atual gmm 2';
      Variable.Value := QuotedStr(Format('%2.4f',[Relatorio.Gmm.Final[2]]));
      end;


    {Variable := frxReport.Variables.Add;
    Variable.Name := 'Dois Planos';
    Variable.Value := (Relatorio.DoisPlanos); }

    Variable := frxReport.Variables.Add;
    Variable.Name := 'Miligramas';
    Variable.Value := (Relatorio.Miligramas);

    {Variable := frxReport.Variables.Add;
    Variable.Name := 'Plano Usado';
    Variable.Value := (Relatorio.PlanoUsado);}

    //flags resultado
   { Existe := (reGramas in Relatorio.Resultados);
    Variable := frxReport.Variables.Add;
    Variable.Name := 'Resultado Gramas';
    Variable.Value := Existe;

    Existe := (reISOG in Relatorio.Resultados);
    Variable := frxReport.Variables.Add;
    Variable.Name := 'Resultado ISOG';
    Variable.Value := Existe;

    Existe := (reGmm in Relatorio.Resultados);
    Variable := frxReport.Variables.Add;
    Variable.Name := 'Resultado gmm';
    Variable.Value := Existe; }

    //Cliente
   // Category := frxReport.Variables.Add;
    //Category.Name := ' ' + 'Dados Cliente';

    {Variable := frxReport.Variables.Add;
    Variable.Name := 'Cliente';
    Variable.Value := QuotedStr(Relatorio.Cliente);

    Variable := frxReport.Variables.Add;
    Variable.Name := 'Peça';
    Variable.Value := QuotedStr(Relatorio.Peca);

    Variable := frxReport.Variables.Add;
    Variable.Name := 'Operador';
    Variable.Value := QuotedStr(Relatorio.Operador);
    }

    {Variable := frxReport.Variables.Add;
    Variable.Name := 'Observações';
    Variable.Value := QuotedStr(Relatorio.Obs);
    }
    {Variable := frxReport.Variables.Add;
    Variable.Name := 'Desenho Peça';
    Variable.Value := QuotedStr(Relatorio.ImagemPeca);}


    Category := frxReport.Variables.Add;
    Category.Name := ' ' + 'Dados Adicionais';

    //Campos extras
      for i := 0 to High(Relatorio.NomeCampo) do
      begin
      if CamposLivresRel[i] <> nil then
        begin
        frxReport.Variables[CamposLivresRel[i].EditLabel.Caption] := QuotedStr(CamposLivresRel[i].Text);
        //Variable := frxReport.Variables.Add;
        //Variable.Name := Relatorio.NomeCampo[i];
        //Variable.Value := QuotedStr(Relatorio.NomeCampo[i] + ' ' + Relatorio.Campos[i]);
        //frxReport.Script.Variables['Campo ' + IntToStr(i)] := Relatorio.NomeCampo[i] + ' ' + Relatorio.Campos[i];
        end;
      end;
    end;
    {if FiguraRotor <> '' then
      begin
       Picture := TfrxPictureView(frxReport. FindObject('PicturePeca'));
      //TfrxPictureView(frxReport.Pages[0].FindObject('PicturePeca')).Picture.Graphic.LoadFromFile(FiguraRotor);
      end; }
end;

end.
