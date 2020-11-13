unit uImpresso;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, PReport, PdfDoc, ExtCtrls, StdCtrls, PRJpegImage;

type
  TfrmImpresso = class(TForm)
    PRPage1: TPRPage;
    PReport1: TPReport;
    PRLayoutPanel1: TPRLayoutPanel;
    PRLayoutPanel2: TPRLayoutPanel;
    PRLayoutPanel3: TPRLayoutPanel;
    PRRect1: TPRRect;
    PRLabel1: TPRLabel;
    PRRect2: TPRRect;
    PRRect3: TPRRect;
    PRImage1: TPRImage;
    PRLabel2: TPRLabel;
    PRLabel3: TPRLabel;
    PRLabel4: TPRLabel;
    PRLabel5: TPRLabel;
    PRLabel6: TPRLabel;
    PRLayoutPanel4: TPRLayoutPanel;
    PRRect4: TPRRect;
    PRLabel7: TPRLabel;
    PRLabel8: TPRLabel;
    PRLayoutPanel5: TPRLayoutPanel;
    PRRect5: TPRRect;
    PRLabel9: TPRLabel;
    PRLabel10: TPRLabel;
    PRLabel11: TPRLabel;
    PRLabel12: TPRLabel;
    PRLabel13: TPRLabel;
    PRLabel14: TPRLabel;
    PRLabel15: TPRLabel;
    PRLabel16: TPRLabel;
    PRLabel17: TPRLabel;
    PRLabel18: TPRLabel;
    PRLabel19: TPRLabel;
    PRLayoutPanel6: TPRLayoutPanel;
    SaveDialog1: TSaveDialog;
    PRTxtCliente: TPRText;
    PRTxtEquip: TPRText;
    PRTxtPeso: TPRText;
    PRTxtFabric: TPRText;
    PRTxtRPMTrab: TPRText;
    PRTxtIsoG: TPRText;
    PRTxtResRotor: TPRText;
    PRTxtResPlano: TPRText;
    PRTxtRPMBal: TPRText;
    PRTxtRaio1: TPRText;
    PRTxtRaio2: TPRText;
    PRTxtA: TPRText;
    PRTxtB: TPRText;
    PRTxtC: TPRText;
    PRTxtObs: TPRText;
    PRLayoutPanel7: TPRLayoutPanel;
    PRRect6: TPRRect;
    PRRect7: TPRRect;
    PRRect8: TPRRect;
    PRRect9: TPRRect;
    PRLabel20: TPRLabel;
    PRLabel21: TPRLabel;
    PRLabel22: TPRLabel;
    PRTxtData: TPRText;
    PRTxtNPA: TPRText;
    PRTxtResRotorGmm: TPRText;
    PRLabel23: TPRLabel;
    PRLabel25: TPRLabel;
    PRTxtDesbalFinal1: TPRText;
    PRTxtDesbalInicial1: TPRText;
    PRTxtDesbalInicial2: TPRText;
    PRTxtDesbalFinal2: TPRText;
    PRLabel24: TPRLabel;
    PRLabel26: TPRLabel;
    PRLabel27: TPRLabel;
    PRLabel28: TPRLabel;
    PRTextOperador: TPRText;
    PRJpegImage: TPRImage;
    PRRect10: TPRRect;
    PRLabelNorma: TPRLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  type TRep = record
  NPA, Cliente, Equipamento, Fabricante, Peso, RPM : string[30];
  ISOG, Raio1, Raio2, A, B, C : string[30];
  Operador : string[30];
  ADInicial1, ADFinal1, FDInicial1, FDFinal1 : string[30];
  ADInicial2, ADFinal2, FDInicial2, FDFinal2 : string[30];
  Imagem, ImagemPeca : string[200];
  Obs : string[100];
  end;

var
  frmImpresso: TfrmImpresso;
  Rep : TRep;

implementation

{$R *.dfm}

end.
