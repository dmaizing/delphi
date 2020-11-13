unit uKeyboard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Keyboard;

type
  TMyKeyboard = class(TTouchKeyboard)
  protected
    procedure WndProc(var Message: TMessage); override;
  end;
  TfrmKeyboard = class(TForm)
    bbtnClose: TBitBtn;
    procedure bbtnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  private
    { Private declarations }
    fHandleOfTheTargetForm: HWND;
    keyboard              :TMyKeyboard;
  public
    { Public declarations }
    property HandleOfTheTargetForm: HWND read fHandleOfTheTargetForm write fHandleOfTheTargetForm;
  end;

var
  frmKeyboard: TfrmKeyboard;

implementation

{$R *.dfm}

{ TfrmKeyboard }

procedure TfrmKeyboard.bbtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmKeyboard.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  begin
    ExStyle   := ExStyle or WS_EX_NOACTIVATE;
    WndParent := GetDesktopwindow;
  end;
end;

procedure TfrmKeyboard.FormCreate(Sender: TObject);
begin
  HandleOfTheTargetForm := 0;
  keyboard              := TMyKeyboard.Create(Self);
  keyboard.Parent       := Self;
  with keyboard do
  begin
    Left          := 0;
    Top           := 0;
    Width         := 550;
    Height        := 180;
    GradientEnd   := clSilver;
    GradientStart := clGray;
    Layout        := 'Standard'
  end;
end;

{ TMyKeyboard }

procedure TMyKeyboard.WndProc(var Message: TMessage);
begin
  if (Assigned(frmKeyboard)) then
  begin
    if frmKeyboard.HandleOfTheTargetForm <> 0 then
    begin
      SetForegroundWindow(frmKeyboard.HandleOfTheTargetForm);
    end;
  end;
  inherited;
end;

end.
