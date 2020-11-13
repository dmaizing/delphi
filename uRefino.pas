unit uRefino;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, NumIO, Buttons;

type
  TfrmRefino = class(TForm)
    GroupBox: TGroupBox;
    BitBtnRefinar: TBitBtn;
    GroupBoxPlano1: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    NumIOA1R: TNumIO;
    NumIOF1R: TNumIO;
    GroupBoxPlano2: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    NumIOA2R: TNumIO;
    NumIOF2R: TNumIO;
    procedure BitBtnRefinarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRefino: TfrmRefino;

implementation

uses Main,Geral;

{$R *.dfm}

procedure TfrmRefino.FormCreate(Sender: TObject);
begin
  //NumIOA1R.OnChange := frmMain.NumIOPeso1Change;
  //NumIOA2R.OnChange := frmMain.NumIOPeso2Change;

  //NumIOF1R.OnChange := frmMain.NumIOAngulo1Change;
  //NumIOF2R.OnChange := frmMain.NumIOAngulo2Change;
end;

procedure TfrmRefino.BitBtnRefinarClick(Sender: TObject);
begin
  if (GroupBoxPlano1.Visible) and (GroupBoxPlano2.Visible) then
    begin
    //frmMain.NumIOPeso1.Text := NumIOA1R.Text;
    //frmMain.NumIOPeso2.Text := NumIOA2R.Text;
    //frmMain.NumIOAngulo1.Text := NumIOF1R.Text;
    //frmMain.NumIOAngulo2.Text := NumIOF2R.Text;
    //Refinamento2;
    end;

  if (GroupBoxPlano1.Visible) and not (GroupBoxPlano2.Visible) then
    begin
    //frmMain.NumIOPeso1.Text := NumIOA1R.Text;
    //frmMain.NumIOAngulo1.Text := NumIOF1R.Text;
    //Refina1;
    end;

  if (GroupBoxPlano2.Visible) and not (GroupBoxPlano1.Visible)then
    begin
    //frmMain.NumIOPeso2.Text := NumIOA2R.Text;
    //frmMain.NumIOAngulo2.Text := NumIOF2R.Text;
    //Refina1;
    end;
end;

end.
