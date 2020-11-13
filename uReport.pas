unit uReport;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frxDesgn, frxClass, frxPreview, ComCtrls, Menus, frxExportImage, frxExportHTML,
  frxExportPDF, frxDCtrl, frxGradient, frxRich, frxOLE;

type
  TfrmReport = class(TForm)
    PageControl1: TPageControl;
    DesignerSheet: TTabSheet;
    PreviewSheet: TTabSheet;
    frxPreview1: TfrxPreview;
    frxReport1: TfrxReport;
    frxDesigner1: TfrxDesigner;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    NewMI: TMenuItem;
    OpenMI: TMenuItem;
    SaveMI: TMenuItem;
    SaveasMI: TMenuItem;
    N1: TMenuItem;
    PreviewMI: TMenuItem;
    PagesettingsMI: TMenuItem;
    N2: TMenuItem;
    ExitMI: TMenuItem;
    Edit1: TMenuItem;
    UndoMI: TMenuItem;
    RedoMI: TMenuItem;
    N3: TMenuItem;
    CutMI: TMenuItem;
    CopyMI: TMenuItem;
    PasteMI: TMenuItem;
    N4: TMenuItem;
    DeleteMI: TMenuItem;
    DeletePageMI: TMenuItem;
    SelectAllMI: TMenuItem;
    GroupMI: TMenuItem;
    UngroupMI: TMenuItem;
    EditMI: TMenuItem;
    N5: TMenuItem;
    BringtoFrontMI: TMenuItem;
    SendtoBackMI: TMenuItem;
    N6: TMenuItem;
    FindMI: TMenuItem;
    ReplaceMI: TMenuItem;
    FindNextMI: TMenuItem;
    Report1: TMenuItem;
    DataMI: TMenuItem;
    VariablesMI: TMenuItem;
    StylesMI: TMenuItem;
    ReportOptionsMI: TMenuItem;
    View1: TMenuItem;
    ToolbarsMI: TMenuItem;
    N7: TMenuItem;
    RulersMI: TMenuItem;
    GuidesMI: TMenuItem;
    DeleteGuidesMI: TMenuItem;
    N8: TMenuItem;
    OptionsMI: TMenuItem;
    StandardMI: TMenuItem;
    TextMI: TMenuItem;
    FrameMI: TMenuItem;
    AlignmentPaletteMI: TMenuItem;
    ObjectInspectorMI: TMenuItem;
    DataTreeMI: TMenuItem;
    ReportTreeMI: TMenuItem;
    Help1: TMenuItem;
    HelpContentsMI: TMenuItem;
    AboutFastReportMI: TMenuItem;
    N9: TMenuItem;
    NewReportMI: TMenuItem;
    NewPageMI: TMenuItem;
    NewDialogMI: TMenuItem;
    frxDialogControls1: TfrxDialogControls;
    frxPDFExport1: TfrxPDFExport;
    frxHTMLExport1: TfrxHTMLExport;
    frxJPEGExport1: TfrxJPEGExport;
    frxBMPExport1: TfrxBMPExport;
    frxOLEObject1: TfrxOLEObject;
    frxRichObject1: TfrxRichObject;
    frxGradientObject1: TfrxGradientObject;
    procedure FormShow(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure ExitMIClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);

  private
    { Private declarations }
  public
    procedure CreateFields;
  end;

var
  frmReport: TfrmReport;

const
  Offset = 15;


implementation

{$R *.DFM}

uses frxRes, Printers, uWizReport, frxVariables;

procedure TfrmReport.CreateFields;
var
  i: byte;
  Campo: TfrxMemoView;
  MyPage: TfrxReportPage;
  DataPage: TfrxDataPage;
  Picture: TfrxPictureView;
  Ms: TMemoryStream;
  Category, Variable: TfrxVariable;
begin
  frxReport1.Clear;
  frxReport1.Variables.Clear;
  DataPage := TfrxDataPage.Create(frxReport1);
  DataPage.CreateUniqueName;
  MyPage := TfrxReportPage.Create(frxReport1);
  MyPage.CreateUniqueName;
  MyPage.SetDefaults;
  MyPage.Orientation := poPortrait;

  Category := frxReport1.Variables.Add;
  Category.Name := ' ' + 'Dados Adicionais';

  //campos adicionais
  for i := 1 to frmReportWizard.spedtCampos.Value do
    frxReport1.Variables.AddVariable('Dados Adicionais', frmReportWizard.gridCampos.Cells[0,i], QuotedStr(' '));

  Category := frxReport1.Variables.Add;
  Category.Name := ' ' + 'Balanceamento';

  //peso rotor
  if frmReportWizard.chckPesoRotor.checked then
    frxReport1.Variables.AddVariable('Balanceamento', 'Peso Rotor', QuotedStr(' '));

  //logotipo
  Ms := TMemoryStream.Create;
  if FileExists(frmReportWizard.edtLogotipo.Text) then
    begin
    Ms.LoadFromFile(frmReportWizard.edtLogotipo.Text);
    Picture := TfrxPictureView.Create(MyPage);
    Picture.Name := 'Logotipo';
    Picture.AutoSize := True;
    Picture.LoadPictureFromStream(Ms,True);
    Picture.Top := 250;
    Picture.Left := 10;
    end;

  //desenho peça
  if FileExists(frmReportWizard.edtDesenhoPeca.Text) then
    begin
    Ms.LoadFromFile(frmReportWizard.edtDesenhoPeca.Text);
    Picture := TfrxPictureView.Create(MyPage);
    Picture.Name := 'Desenho';
    Picture.AutoSize := True;
    Picture.LoadPictureFromStream(Ms,True);
    Picture.Top := 350;
    Picture.Left := 10;
    end;

  //raio
  if frmReportWizard.chckRaio.Checked then
    begin
    if frmReportWizard.DoisPlanos then
      begin
      for i := 1 to 2 do
        frxReport1.Variables.AddVariable('Balanceamento', 'Raio ' + InttoStr(i), QuotedStr(' '));
      end
    else
      frxReport1.Variables.AddVariable('Balanceamento', 'Raio ' + InttoStr(frmReportWizard.QualMancal), QuotedStr(' '));
    end;

  if frmReportWizard.chckResidualRotor.Checked then
    frxReport1.Variables.AddVariable('Balanceamento', 'Residual Rotor Kg', QuotedStr(' '));

  if frmReportWizard.chckResidualPlano.Checked then
    frxReport1.Variables.AddVariable('Balanceamento', 'Residual por Plano', QuotedStr(' '));

  //gramas
  if frmReportWizard.chckgramas.Checked then
    begin
    if frmReportWizard.DoisPlanos then
      begin
      for i := 1 to 2 do
        begin
        frxReport1.Variables.AddVariable('Balanceamento', 'Ângulo Inicial '+ InttoStr(i), QuotedStr(' '));
        frxReport1.Variables.AddVariable('Balanceamento', 'Ângulo Final '+ InttoStr(i), QuotedStr(' '));

        frxReport1.Variables.AddVariable('Balanceamento', 'Peso Inicial '+ InttoStr(i), QuotedStr(' '));
        frxReport1.Variables.AddVariable('Balanceamento', 'Peso Final '+ InttoStr(i), QuotedStr(' '));

        frxReport1.Variables.AddVariable('Balanceamento', 'Ideal Gramas '+ InttoStr(i), QuotedStr(' '));
        frxReport1.Variables.AddVariable('Balanceamento', 'Atual Gramas '+ InttoStr(i), QuotedStr(' '));
        end;
      end
    else
      begin
      frxReport1.Variables.AddVariable('Balanceamento', 'Ângulo Inicial '+ InttoStr(frmReportWizard.QualMancal), QuotedStr(' '));
      frxReport1.Variables.AddVariable('Balanceamento', 'Ângulo Final '+ InttoStr(frmReportWizard.QualMancal), QuotedStr(' '));

      frxReport1.Variables.AddVariable('Balanceamento', 'Peso Inicial '+ InttoStr(frmReportWizard.QualMancal), QuotedStr(' '));
      frxReport1.Variables.AddVariable('Balanceamento', 'Peso Final '+ InttoStr(frmReportWizard.QualMancal), QuotedStr(' '));

      frxReport1.Variables.AddVariable('Balanceamento', 'Ideal Gramas '+ InttoStr(frmReportWizard.QualMancal), QuotedStr(' '));
      frxReport1.Variables.AddVariable('Balanceamento', 'Atual Gramas '+ InttoStr(frmReportWizard.QualMancal), QuotedStr(' '));
      end;
    end;

  //gramas mm
  if frmReportWizard.chckgmm.Checked then
    begin
    if frmReportWizard.DoisPlanos then
      begin
      for i := 1 to 2 do
        begin
        frxReport1.Variables.AddVariable('Balanceamento', 'gmm Inicial ' + InttoStr(i), QuotedStr(' '));
        frxReport1.Variables.AddVariable('Balanceamento', 'Ideal gmm ' + InttoStr(i), QuotedStr(' '));
        frxReport1.Variables.AddVariable('Balanceamento', 'Atual gmm ' + InttoStr(i), QuotedStr(' '));
        end;
      end
    else
      begin
      frxReport1.Variables.AddVariable('Balanceamento', 'gmm Inicial ' + InttoStr(frmReportWizard.QualMancal), QuotedStr(' '));
      frxReport1.Variables.AddVariable('Balanceamento', 'Ideal gmm ' + InttoStr(frmReportWizard.QualMancal), QuotedStr(' '));
      frxReport1.Variables.AddVariable('Balanceamento', 'Atual gmm ' + InttoStr(frmReportWizard.QualMancal), QuotedStr(' '));
      end;
    end;

  //ISOG
  if frmReportWizard.chckgramas.Checked then
    begin
    if frmReportWizard.DoisPlanos then
      begin
      for i := 1 to 2 do
        begin
        frxReport1.Variables.AddVariable('Balanceamento', 'ISOG Inicial '+ InttoStr(i), QuotedStr(' '));
        frxReport1.Variables.AddVariable('Balanceamento', 'Ideal ISOG '+ InttoStr(i), QuotedStr(' '));
        frxReport1.Variables.AddVariable('Balanceamento', 'Atual ISOG '+ InttoStr(i), QuotedStr(' '));
        end;
      end
    else
      begin
      frxReport1.Variables.AddVariable('Balanceamento', 'ISOG Inicial '+ InttoStr(frmReportWizard.QualMancal), QuotedStr(' '));
      frxReport1.Variables.AddVariable('Balanceamento', 'Ideal ISOG '+ InttoStr(frmReportWizard.QualMancal), QuotedStr(' '));
      frxReport1.Variables.AddVariable('Balanceamento', 'Atual ISOG '+ InttoStr(frmReportWizard.QualMancal), QuotedStr(' '));
      end;
    end;

  //rpm trabalho
  if frmReportWizard.chckRPMTrabalho.Checked then
    frxReport1.Variables.AddVariable('Balanceamento', 'RPM Trabalho', QuotedStr(' '));

    //rpm balanceamento
  if frmReportWizard.chckRPMBalanceamento.Checked then
    frxReport1.Variables.AddVariable('Balanceamento', 'RPM Balanceamento', QuotedStr(' '));

  frxReport1.Designer.UpdateDataTree;
  frxReport1.Designer.ReloadReport;
end;

procedure TfrmReport.FormShow(Sender: TObject);
var
  Designer: TfrxDesignerForm;
begin
  // prevent saving/restoring a report when previewing. This will destroy
  // objects that are loaded in the designer and will lead to AV.
  frxReport1.EngineOptions.DestroyForms := False;
  // set the custom preview
  frxReport1.Preview := frxPreview1;
  // display the designer
  frxReport1.DesignReportInPanel(DesignerSheet);

  // set FR images for our menu
  MainMenu1.Images := frxResources.MainButtonImages;
  // get the reference to the Designer
  Designer := TfrxDesignerForm(frxReport1.Designer);

  // assign FR actions to our menu items
  NewMI.Action := Designer.NewItemCmd;
  NewReportMI.Action := Designer.NewReportCmd;
  NewPageMI.Action := Designer.NewPageCmd;
  NewDialogMI.Action := Designer.NewDialogCmd;
  OpenMI.Action := Designer.OpenCmd;
  SaveMI.Action := Designer.SaveCmd;
  SaveasMI.Action := Designer.SaveAsCmd;
  PreviewMI.Action := Designer.PreviewCmd;
  PageSettingsMI.Action := Designer.PageSettingsCmd;

  UndoMI.Action := Designer.UndoCmd;
  RedoMI.Action := Designer.RedoCmd;
  CutMI.Action := Designer.CutCmd;
  CopyMI.Action := Designer.CopyCmd;
  PasteMI.Action := Designer.PasteCmd;
  DeleteMI.Action := Designer.DeleteCmd;
  DeletePageMI.Action := Designer.DeletePageCmd;
  SelectAllMI.Action := Designer.SelectAllCmd;
  GroupMI.Action := Designer.GroupCmd;
  UngroupMI.Action := Designer.UngroupCmd;
  EditMI.Action := Designer.EditCmd;
  FindMI.Action := Designer.FindCmd;
  ReplaceMI.Action := Designer.ReplaceCmd;
  FindNextMI.Action := Designer.FindNextCmd;
  BringtoFrontMI.Action := Designer.BringToFrontCmd;
  SendtoBackMI.Action := Designer.SendToBackCmd;

  DataMI.Action := Designer.ReportDataCmd;
  VariablesMI.Action := Designer.VariablesCmd;
  StylesMI.Action := Designer.ReportStylesCmd;
  ReportOptionsMI.Action := Designer.ReportOptionsCmd;

  ToolbarsMI.Action := Designer.ToolbarsCmd;
  StandardMI.Action := Designer.StandardTBCmd;
  TextMI.Action := Designer.TextTBCmd;
  FrameMI.Action := Designer.FrameTBCmd;
  AlignmentPaletteMI.Action := Designer.AlignTBCmd;
  ObjectInspectorMI.Action := Designer.InspectorTBCmd;
  DataTreeMI.Action := Designer.DataTreeTBCmd;
  ReportTreeMI.Action := Designer.ReportTreeTBCmd;
  RulersMI.Action := Designer.ShowRulersCmd;
  GuidesMI.Action := Designer.ShowGuidesCmd;
  DeleteGuidesMI.Action := Designer.DeleteGuidesCmd;
  OptionsMI.Action := Designer.OptionsCmd;

  HelpContentsMI.Action := Designer.HelpContentsCmd;
  AboutFastReportMI.Action := Designer.AboutCmd;
end;

procedure TfrmReport.PageControl1Change(Sender: TObject);
begin
  if PageControl1.ActivePage = PreviewSheet then
    frxReport1.PrepareReport
end;

procedure TfrmReport.ExitMIClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmReport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frxReport1.Designer.Close;
end;

end.
