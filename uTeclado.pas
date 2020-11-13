unit uTeclado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Keyboard, MyTouchKeyboard;

type

  TfrmKeyboard = class(TForm)
    MyTouchKeyboard: TMyTouchKeyboard;
    procedure FormCreate(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  private

  public
    { Public declarations }
  end;

var
  frmKeyboard: TfrmKeyboard;

implementation

{$R *.dfm}

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
  MyTouchKeyboard.HandleOfTheTargetForm := 0;
end;

end.
