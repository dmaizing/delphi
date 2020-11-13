unit uDivisor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, NUMIO;

type
  TfrmDivisor = class(TForm)
    BitBtnDividir: TBitBtn;
    GroupBoxPlano1: TGroupBox;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    EditA1Plano1: TEdit;
    EditA2Plano1: TEdit;
    GroupBox3: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    edtResultado1Plano1: TEdit;
    edtResultado2Plano1: TEdit;
    GroupBoxPlano2: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label6: TLabel;
    EditA1Plano2: TEdit;
    EditA2Plano2: TEdit;
    GroupBox4: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    edtResultado1Plano2: TEdit;
    edtResultado2Plano2: TEdit;
    procedure BitBtnDividirClick(Sender: TObject);
    procedure DividirMassa(Amplitude, Angulo: TNumIO; Angulo1, Angulo2, Res1, Res2: TEdit);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDivisor: TfrmDivisor;

implementation

{$R *.dfm}

uses Main;

procedure TfrmDivisor.DividirMassa(Amplitude, Angulo: TNumIO; Angulo1, Angulo2, Res1, Res2: TEdit);
var
   Peso, Fase, Mx, My, A1, A2: single;
   SinA1, SinA2, CosA1, CosA2: Single;
   Delta, R1, R2: Single;
   Q11, Q12, Q21, Q22: Single;
begin
   if (Amplitude.Text = '') or (Angulo.Text = '')
   or (Angulo1.Text = '') or (Angulo2.Text = '') then exit;
   A1 := StrToFloat(Angulo1.Text);
   A2 := StrToFloat(Angulo2.Text);
   if (A1 < 0) or (A1> 360) then Angulo1.Text :='0';
   if (A2 < 0) or (A2> 360) then Angulo2.Text :='0';
   Fase := StrToFloat(Angulo.Text);
   Peso := StrToFloat(Amplitude.Text);

   Mx:= Peso * cos(fase* pi/180);
   My:= Peso * sin(fase* pi/180);
   SinA1:=sin(A1*pi/180);
   SinA2:=sin(A2*pi/180);
   CosA1:=cos(A1*pi/180);
   CosA2:=cos(A2*pi/180);
   Delta:= CosA1*SinA2 - SinA1*CosA2;
   if Delta <> 0 then
     begin
      Q11:= SinA2/Delta;
      Q12:= CosA2/Delta*-1;
      Q21:= SinA1/Delta*-1;
      Q22:= CosA1/Delta;
      R1:= Q11*Mx + Q12*My;
      R2:= Q21*Mx + Q22*My;
      Res1.Text := Format('%1.1f' ,[R1]);
      Res2.Text := Format('%1.1f' ,[R2]);
     end
   else
     begin
      Res1.Text := '';
      Res2.Text := '';
     end;
end;

procedure TfrmDivisor.BitBtnDividirClick(Sender: TObject);
begin
  {if (GroupBoxPlano1.Visible) and (GroupBoxPlano2.Visible) then
    begin
    DividirMassa(frmMain.NUMIOPeso1, frmMain.NUMIOAngulo1,
               EditA1Plano1, EditA2Plano1,
               edtResultado1Plano1,edtResultado2Plano1);
    DividirMassa(frmMain.NUMIOPeso2, frmMain.NUMIOAngulo2,
               EditA1Plano2, EditA2Plano2,
               edtResultado1Plano2,edtResultado2Plano2);
    end;

  if (GroupBoxPlano1.Visible) and not (GroupBoxPlano2.Visible) then
    begin
    DividirMassa(frmMain.NUMIOPeso1, frmMain.NUMIOAngulo1,
               EditA1Plano1, EditA2Plano1,
               edtResultado1Plano1,edtResultado2Plano1);
    end;

  if (GroupBoxPlano2.Visible) and not (GroupBoxPlano1.Visible)then
    begin
    DividirMassa(frmMain.NUMIOPeso2, frmMain.NUMIOAngulo2,
               EditA1Plano2, EditA2Plano2,
               edtResultado1Plano2,edtResultado2Plano2);
    end; }
end;

end.
