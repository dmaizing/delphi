unit uWizReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvWizard, JvExControls, Buttons, StdCtrls, ExtCtrls, Spin, Grids,
  AdvObj, BaseGrid, AdvGrid, ExtDlgs, IniFiles;

type
  TfrmReportWizard = class(TForm)
    JvWizard: TJvWizard;
    JvWizardLogotipoPage: TJvWizardInteriorPage;
    JvWizardDesenhoPage: TJvWizardInteriorPage;
    edtLogotipo: TEdit;
    btnLogotipo: TSpeedButton;
    imgLogotipo: TImage;
    edtDesenhoPeca: TEdit;
    btnDesenhoPeca: TSpeedButton;
    imgDesenhoPeca: TImage;
    JvWizardCamposPage: TJvWizardInteriorPage;
    spedtCampos: TSpinEdit;
    gridCampos: TAdvStringGrid;
    JvWizardDadosPage: TJvWizardInteriorPage;
    chckgmm: TCheckBox;
    chckgramas: TCheckBox;
    chckISOG: TCheckBox;
    chckRaio: TCheckBox;
    chckRPMTrabalho: TCheckBox;
    chckRPMBalanceamento: TCheckBox;
    JvWizardFinishPage: TJvWizardInteriorPage;
    OpenPictureDialog: TOpenPictureDialog;
    lblCampos: TLabel;
    JvWizardWelcomePage: TJvWizardWelcomePage;
    lblDesenho: TLabel;
    lblLogotipo: TLabel;
    rdgrpBalanceamento: TRadioGroup;
    rdgrpMancal: TRadioGroup;
    imgTerminate: TImage;
    Label1: TLabel;
    chckPesoRotor: TCheckBox;
    chckResidualRotor: TCheckBox;
    chckResidualPlano: TCheckBox;
    procedure spedtCamposChange(Sender: TObject);
    procedure btnLogotipoClick(Sender: TObject);
    procedure btnDesenhoPecaClick(Sender: TObject);
    procedure JvWizardCancelButtonClick(Sender: TObject);
    procedure JvWizardFinishButtonClick(Sender: TObject);
    procedure rdgrpBalanceamentoClick(Sender: TObject);
    procedure rdgrpMancalClick(Sender: TObject);
  private
    { Private declarations }
  public
    DoisPlanos: Boolean;
    QualMancal: Byte;
    procedure SaveReport;
    procedure LoadReport;

  end;

var
  frmReportWizard: TfrmReportWizard;
  IniReport: TIniFile;

implementation

uses uReport, Main, frxClass, Printers;

{$R *.dfm}

procedure TfrmReportWizard.SaveReport;
var
S: string;
i: Byte;
begin
 //agora grava na pasta application Data/ NK700 do usuario atual
	S := IncludeTrailingBackslash(frmMain.GetSpecialFolderPath);
	S := IncludeTrailingBackslash(S) + 'Teknikao\NK700\';
  if not DirectoryExists(S) then
    ForceDirectories(S);
  S := S + 'Relatório.ini';
  try
  IniReport := TIniFile.Create(S);
  with IniReport do
    begin
      S := 'Relatório';
      //Logotipo da empresa
      WriteString(S, 'Logotipo',edtLogotipo.Text);
      //Desenho peça
      WriteString(S,'Desenho',edtDesenhoPeca.Text);
      //Numero de Campos
      WriteInteger(S, 'NumeroCampos', spedtCampos.Value);
      //Campos Adicionais
      for i := 1 to spedtCampos.Value do
        WriteString(S, 'Campo'+IntToStr(i), gridCampos.Cells[0,i]);

      WriteBool(S, 'MostrarRaio', chckRaio.Checked);
      WriteBool(S, 'MostrarRPMTrabalho', chckRPMTrabalho.Checked);
      WriteBool(S, 'MostrarRPMBalanceamento', chckRPMBalanceamento.Checked);
      WriteBool(S, 'MostrarGMM', chckgmm.Checked);
      WriteBool(S, 'MostrarGramas', chckgramas.Checked);
      WriteBool(S, 'MostrarISOG', chckISOG.Checked);
      WriteBool(S, 'PesoRotor', chckPesoRotor.Checked);
      WriteBool(S, 'DoisPlanos', rdgrpBalanceamento.ItemIndex = 1);
      WriteBool(S, 'Residual Rotor', chckResidualRotor.Checked);
      WriteBool(S, 'ResidualporPlano', chckResidualPlano.Checked);
      WriteInteger(S, 'QualMancal', rdgrpMancal.ItemIndex + 1);
    end;
  finally
  IniReport.Free;
  end;
end;

procedure TfrmReportWizard.LoadReport;
var
S: string;
i: Byte;
begin
	S := IncludeTrailingBackslash(frmMain.GetSpecialFolderPath);
	S := IncludeTrailingBackslash(S) + 'Teknikao\NK700\';
  if not DirectoryExists(S) then
    ForceDirectories(S);
  S := S + 'Relatório.ini';
  try
  IniReport := TIniFile.Create(S);
  with IniReport do
    begin
      S := 'Relatório';
      //Logotipo da empresa
      edtLogotipo.Text := ReadString(S, 'Logotipo','');
      if FileExists(edtLogotipo.Text) then
        imgLogotipo.Picture.LoadFromFile(edtLogotipo.Text);

      //Desenho peça
      edtDesenhoPeca.Text := ReadString(S,'Desenho','');
      if FileExists(edtDesenhoPeca.Text) then
        imgDesenhoPeca.Picture.LoadFromFile(edtDesenhoPeca.Text);

      //Numero de Campos
      spedtCampos.Value := ReadInteger(S, 'NumeroCampos', 8);
      spedtCamposChange(nil);

      //Campos Adicionais
      for i := 1 to spedtCampos.Value do
        gridCampos.Cells[0,i] := ReadString(S, 'Campo'+IntToStr(i), '');

      chckRaio.Checked := ReadBool(S, 'MostrarRaio', False);
      chckRPMTrabalho.Checked := ReadBool(S, 'MostrarRPMTrabalho', False);
      chckRPMBalanceamento.Checked := ReadBool(S, 'MostrarRPMBalanceamento', False);
      chckgmm.Checked := ReadBool(S, 'MostrarGMM', False);
      chckgramas.Checked := ReadBool(S, 'MostrarGramas', False);
      chckISOG.Checked := ReadBool(S, 'MostrarISOG', False);
      chckPesoRotor.Checked := ReadBool(S, 'PesoRotor', False);
      DoisPlanos := ReadBool(S, 'DoisPlanos', True);
      if DoisPlanos then
        rdgrpBalanceamento.ItemIndex := 1
      else
        rdgrpBalanceamento.ItemIndex := 0;

      chckResidualRotor.Checked := ReadBool(S, 'Residual Rotor', False);
      chckResidualPlano.Checked := ReadBool(S, 'ResidualporPlano', False);
      rdgrpMancal.ItemIndex := ReadInteger(S, 'QualMancal', 0);
      QualMancal := rdgrpMancal.ItemIndex + 1;
    end;
  finally
  IniReport.Free;
  end;
end;


procedure TfrmReportWizard.rdgrpBalanceamentoClick(Sender: TObject);
begin
  if rdgrpBalanceamento.ItemIndex = 0 then
    begin
    rdgrpMancal.Enabled := True;
    DoisPlanos := False;
    end
  else
    begin
    rdgrpMancal.Enabled := False;
    DoisPlanos := True;
    end;
end;

procedure TfrmReportWizard.rdgrpMancalClick(Sender: TObject);
begin
  QualMancal := rdgrpMancal.ItemIndex + 1;
end;

procedure TfrmReportWizard.btnDesenhoPecaClick(Sender: TObject);
begin
   if not OpenPictureDialog.Execute then exit;

   edtDesenhoPeca.Text := OpenPictureDialog.FileName;
   imgDesenhoPeca.Picture.LoadFromFile(edtDesenhoPeca.Text);
end;

procedure TfrmReportWizard.btnLogotipoClick(Sender: TObject);
begin
  if not OpenPictureDialog.Execute then exit;

   edtLogotipo.Text := OpenPictureDialog.FileName;
   imgLogotipo.Picture.LoadFromFile(edtLogotipo.Text);
end;

procedure TfrmReportWizard.JvWizardCancelButtonClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmReportWizard.JvWizardFinishButtonClick(Sender: TObject);
begin
  try
  rdgrpBalanceamentoClick(nil);
  rdgrpMancalClick(nil);
  SaveReport;
  frmReport.Show;
  frmReport.CreateFields;
  finally
  Close;
  end;
end;

procedure TfrmReportWizard.spedtCamposChange(Sender: TObject);
begin
  gridCampos.RowCount := spedtCampos.Value + 1;
end;

end.
