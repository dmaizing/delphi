unit Sobre;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ShellApi, RzLabel,RzCommon, RzPanel, pngimage,
  JvExExtCtrls, JvImage;

type
  TfrmAbout = class(TForm)
    Panel1: TRzPanel;
    Label1: TRzLabel;
    Panel2: TRzPanel;
    Label4: TRzLabel;
    Label6: TRzLabel;
    Label2: TRzLabel;
    RzLabel1: TRzLabel;
    imgTel: TImage;
    RzLabel2: TRzLabel;
    RzLabel3: TRzLabel;
    RzLabel4: TRzLabel;
    Image2: TImage;
    JvImage1: TJvImage;
    Label3: TLabel;
    procedure FormPaint(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure RzPanel1Paint(Sender: TObject);
    Function GetBuildInfo:string;
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.DFM}

Function TfrmAbout.GetBuildInfo:string;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
  V1, V2, V3, V4: Word;
  Prog : string;

begin
  Prog := Application.Exename;
  VerInfoSize := GetFileVersionInfoSize(PChar(prog), Dummy);
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(prog), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '', Pointer(VerValue), VerValueSize);
  with VerValue^ do
    begin
      V1 := dwFileVersionMS shr 16;
      V2 := dwFileVersionMS and $FFFF;
      V3 := dwFileVersionLS shr 16;
      V4 := dwFileVersionLS and $FFFF;
    end;
  FreeMem(VerInfo, VerInfoSize);
  result :=
//  Copy (IntToStr (100 + v1), 3, 3) + '.' +
  IntToStr (v1) + '.' +
  Copy (IntToStr (100 + v2), 3, 2) + '.' +
  Copy (IntToStr (100 + v3), 3, 2) + '.' +
  Copy (IntToStr (100 + v4), 3, 2);
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
  caption := 'TEKNIKAO - NK700 - ' + GetBuildInfo;
end;

procedure TfrmAbout.FormPaint(Sender: TObject);
var
   X,Y: Integer;
begin
  {
   X:= 30;
   Y:= 30;
  with RzPanel1 do
  begin
  Canvas.Brush.Color := clblack;
  Canvas.Polygon([Point(X, Y), Point(5+x, y), Point(5+x, 5+y),
                Point(16+x, 5+y), Point(16+x, 15+y), Point(9+x, 8+y),
                Point(x, 8+y)]);
  Canvas.Polygon([Point(23+x, 5+y), Point(34+x, 5+y), Point(34+x, y),
                Point(39+x, y), Point(39+x, 8+y), Point(30+x, 8+y),
                Point(30+x, 27+y), Point(23+x, 20+y)]);
  Canvas.Polygon([Point(x, 36+y), Point(x, 33+y), Point(9+x, 33+y),
                Point(9+x, 15+y),Point(16+x, 21+y), Point(16+x, 36+y)]);
  Canvas.Polygon([Point(23+x, 36+y), Point(23+x, 26+y), Point(30+x, 33+y),
                Point(39+x, 33+y), Point(39+x, 36+y)]);

  Canvas.Brush.Color := clBtnFace;
  Canvas.Font.Height := 58;
  Canvas.Font.Name := 'Times New Roman';
  Canvas.Font.Style := [fsbold];
  Canvas.TextOut(45+x,y-11,'TEKNIKAO');
  end;
  }

end;

procedure TfrmAbout.Label1Click(Sender: TObject);
begin
     ShellExecute(Handle,'open','http://www.teknikao.com.br',nil,nil, SW_SHOWNORMAL);
end;

procedure TfrmAbout.RzPanel1Paint(Sender: TObject);
var
   X,Y: Integer;
begin
  {
   X:= 30;
   Y:= 30;
  with RzPanel1 do
  begin
  Canvas.Brush.Color := clblack;
  Canvas.Polygon([Point(X, Y), Point(5+x, y), Point(5+x, 5+y),
                Point(16+x, 5+y), Point(16+x, 15+y), Point(9+x, 8+y),
                Point(x, 8+y)]);
  Canvas.Polygon([Point(23+x, 5+y), Point(34+x, 5+y), Point(34+x, y),
                Point(39+x, y), Point(39+x, 8+y), Point(30+x, 8+y),
                Point(30+x, 27+y), Point(23+x, 20+y)]);
  Canvas.Polygon([Point(x, 36+y), Point(x, 33+y), Point(9+x, 33+y),
                Point(9+x, 15+y),Point(16+x, 21+y), Point(16+x, 36+y)]);
  Canvas.Polygon([Point(23+x, 36+y), Point(23+x, 26+y), Point(30+x, 33+y),
                Point(39+x, 33+y), Point(39+x, 36+y)]);

  Canvas.Brush.Color := clBtnFace;
  Canvas.Font.Height := 58;
  Canvas.Font.Name := 'Times New Roman';
  Canvas.Font.Style := [fsbold];
  Canvas.Brush.Style := bsClear;
  Canvas.TextOut(45+x,y-11,'TEKNIKAO');
  end;
  }
end;

end.
