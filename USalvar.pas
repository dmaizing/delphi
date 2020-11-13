unit USalvar;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, RzPanel, IniFiles, RzButton, ExtDlgs, Buttons, RzLabel;

type
  TFrmSalvar = class(TForm)
    tlbtnSalvarDados: TRzToolButton;
  private
    { Private declarations }
  public
    CamposLivres: array [1..5] of TLabeledEdit;
    { Public declarations }
  end;

var
  FrmSalvar: TFrmSalvar;

implementation

uses Main, uRelatorio, uCalibra, Geral;

{$R *.dfm}

end.
