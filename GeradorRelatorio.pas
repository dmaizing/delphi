unit GeradorRelatorio;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  frxDesgn, frxClass, frxPreview, ComCtrls, Menus, frxExportImage,
  frxExportHTML, frxExportPDF, frxRich, frxCross, frxOLE, frxCrypt, frxGZip,
  frxDCtrl, frxDMPExport, ExtCtrls, frxGradient, frxChBox, frxBarcode, ShellAPI,
  ISO1940;

type
  TCopyDataType = (cdtString = 0, cdtImage = 1, cdtRecord = 2);

 type TResultado = (reGramas, reISOG, reGmm);
 type TResultados = set of TResultado;

  type
  TResultadoNorma = record
    ResidualGramasAtual: single;
    ResidualGmmAtual: single;
    ResidualISOGAtual: single;
    ResidualGramasIdeal: single;
    ResidualGmmIdeal: single;
    ResidualISOGIdeal: single;
  end;

  type
  TRelatorio = record
  Cliente, Peca, Operador: string[100];
  Obs: string[200];
  RPMBalanceamento: single;
  PesoRotor, ISOG, RPMTrabalho, Raio1, Raio2: single;
  ADInicial1,ADFinal1,ADInicial2,ADFinal2: single;
  FDInicial1,FDFinal1,FDInicial2,FDFinal2: single;
  gmmInicial1, ISOGInicial1: single;
  gmmInicial2, ISOGInicial2: single;
  Resultado1, Resultado2: TResultadoNorma;
  GMMKGRotor: single;
  PlanoUsado: byte;
  NomeCampo, Campos: array [1..5] of string[50];
  ImagemPeca: shortstring;
  UsouISO, Miligramas, DoisPlanos: Boolean;
  NomeArquivo,ArquivoVariaveis: ShortString;
  Resultados: TResultados;
  end;

type
  TfrmGeradorRelatorio = class(TForm)
    PageControl: TPageControl;
    DesignerSheet: TTabSheet;
    PreviewSheet: TTabSheet;
    frxPreview: TfrxPreview;
    frxDesigner: TfrxDesigner;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    OpenMI: TMenuItem;
    SaveMI: TMenuItem;
    SaveasMI: TMenuItem;
    N1: TMenuItem;
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
    Help1: TMenuItem;
    HelpContentsMI: TMenuItem;
    AboutFastReportMI: TMenuItem;
    frxRichObject: TfrxRichObject;
    frxBarCodeObject: TfrxBarCodeObject;
    frxCheckBoxObject: TfrxCheckBoxObject;
    frxGradientObject: TfrxGradientObject;
    frxDotMatrixExport: TfrxDotMatrixExport;
    frxGZipCompressor: TfrxGZipCompressor;
    frxCrypt: TfrxCrypt;
    frxOLEObject: TfrxOLEObject;
    SaveDialog: TSaveDialog;
    Novo: TMenuItem;
    frxReport: TfrxReport;
    procedure FormShow(Sender: TObject);
    procedure ExitMIClick(Sender: TObject);
    procedure AboutFastReportMIClick(Sender: TObject);
  private

  public
    
  end;

var
  frmGeradorRelatorio: TfrmGeradorRelatorio;

implementation

{$R *.DFM}

uses frxRes, frxVariables, Sobre, jpeg;

procedure TfrmGeradorRelatorio.FormShow(Sender: TObject);
var
  Designer: TfrxDesignerForm;
  Preview: TfrxPreviewForm;
begin

  // prevent saving/restoring a report when previewing. This will destroy
  // objects that are loaded in the designer and will lead to AV.
  frxReport.EngineOptions.DestroyForms := False;
  // set the custom preview
  frxReport.Preview := frxPreview;
  // display the designer
  frxReport.DesignReportInPanel(DesignerSheet);
  // set FR images for our menu
  MainMenu.Images := frxResources.MainButtonImages;
  // get the reference to the Designer
  Designer := TfrxDesignerForm(frxReport.Designer);
  OpenMI.Action := Designer.OpenCmd;
  SaveMI.Action := Designer.SaveCmd;
  SaveasMI.Action := Designer.SaveAsCmd;
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
  Novo.Action := Designer.NewPageCmd;
  Novo.ImageIndex := Designer.NewPageMI.ImageIndex;
  VariablesMI.Action := Designer.VariablesCmd;
  StylesMI.Action := Designer.ReportStylesCmd;
  ReportOptionsMI.Action := Designer.ReportOptionsCmd;

  ToolbarsMI.Action := Designer.ToolbarsCmd;
  StandardMI.Action := Designer.StandardTBCmd;
  TextMI.Action := Designer.TextTBCmd;
  FrameMI.Action := Designer.FrameTBCmd;
  AlignmentPaletteMI.Action := Designer.AlignTBCmd;
  RulersMI.Action := Designer.ShowRulersCmd;
  GuidesMI.Action := Designer.ShowGuidesCmd;
  DeleteGuidesMI.Action := Designer.DeleteGuidesCmd;
  OptionsMI.Action := Designer.OptionsCmd;

  HelpContentsMI.Action := Designer.HelpContentsCmd;

  //script editor
  Designer.TabPanel.Visible := False;
  Designer.NewB.Visible := False;
  Designer.NewPageB.Visible := False;
  Designer.NewDialogB.Visible := False;
  Designer.DeletePageB.Visible := False;
  Designer.PreviewB.Visible := False;
  Designer.DataTree.Visible := False;
  Designer.ReportTree.Visible := False;
  Designer.Inspector.Visible := False;
end;

procedure TfrmGeradorRelatorio.AboutFastReportMIClick(Sender: TObject);
begin
  frmAbout.Show;
end;

procedure TfrmGeradorRelatorio.ExitMIClick(Sender: TObject);
begin
  Close;
end;

end.
