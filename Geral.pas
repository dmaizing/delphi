unit Geral;

interface

uses
  Windows, SysUtils, Forms, Controls, Graphics, ShlObj;

  type TReportFile = class
    public
    FileName  : string;
    constructor Create(const Arquivo : string);
    end;

  type
  TVetor = record
    Amp, Fase: single;
  end;

  type
  TVetorMedio = record
    Vin: TVetor;
    Media: TVetor;
    SomaCos, SomaSen: single;
    AmpCos, AmpSen: Single;
    MediaCos, MediaSen: single;
  end;

type
    PReal = ^TReal;
    TReal = extended;

    PComplex = ^TComplex;
    TComplex = record
      r : TReal;
      i : TReal;
    end;


  function MakeComplex(x, y: TReal): TComplex;
  function Sum(x, y: TComplex) : TComplex;
  function Difference(x, y: TComplex) : TComplex;
  function Product(x, y: TComplex): TComplex;
  function TimesReal(x: TComplex; y: TReal): TComplex;
  function PlusReal(x: TComplex; y: TReal): TComplex;
  function EiT(t: TReal):TComplex;
  function ComplexToStr(x: TComplex): string;
  function AbsSquared(x: TComplex): TReal;

  function MySetFormat(Val: double): string;
  function ToRad(R:double):double;
  function ToReal(Ampl:real; Fase: double):double;
  function ToImag(Ampl:double; Fase: double):double;
  function SetAngulo(k: Double):double;
  function DoMediaVetor(var Vetor: TVetorMedio): TVetor;
  procedure DoTwoPlaneBalance;
  procedure Refina2;
  procedure Refinamento2(Vet1, Vet2: Tvetor);
  procedure DoSinglePlaneBalance;
  procedure Refina1(V: TVetor);
  function Arco(Divisions, Angle: single): string;
  procedure ZeraMedia;
  Function SubVetor(var V1, V2: TVetor): TVetor;
  function ChangeDecSep(Number: string): single;
	function MyRound(x: single): single;
  function FormataSaida(S:String):String;
  function GetMyDocuments: string;


  var
  RPMReferencia: single;

implementation

uses Main, uCalibra, Math, uOpcoes;

var
A,B,C,D,E,F, Delta: double;
C00R, C00I, C01R, C01I: double;
C10R, C10I, C11R, C11I: double;
N0, N1, K0, K1: double;
V0R, V0I, V1R, V1I: double;
V0, V1, A0, A1: double;
T0, T1, B0, B1: double;
T0R, T0I, T1R, T1I: double;
L0, L1, P0, P1: double;
L0R, L0I, L1R, L1I: double;
Z00, Z01, Z10, Z11: double;
Y00, Y01, Y10, Y11: double;
T00R, T11R, T00I, T11I : double;
V00I, V11I, T00, T11 : double;
B00, B11 : double;
ReR1, ReR2, ReI1, ReI2: double;
R00, R11 : double;
V00, V11, A00, A11 : double;
V00R, V11R : double;
D00, D11, C00, C11, D00R , D11R, D00I, D11I : double;
R00R, R11R, R00I, R11I,R0, R1 : double;
K00, K11 : double;
Raiz, Tange, DASMT, DFSMT : single;
X1, Y1, X2, Y2,X3,Y3, Xr, Yr, DACMT, DFCMT : single;
GG,HH,II,JJ: single;
DADM, Vm, Atra, Sensi : single;
DAAC, DFAC: single;
Fase1Plano, Peso1Plano: Single;
Q0, Q1,H0, H1, Q0R, Q1R, Q0I, Q1I : single;
Z20,Z21,Y20,Y21: single;



function GetMyDocuments: string;
 var
    r: Bool;
    path: array[0..Max_Path] of Char;
 begin
    r := ShGetSpecialFolderPath(0, path, CSIDL_Personal, False) ;
    if not r then raise Exception.Create('Não foi possível encontrar a pasta Documentos.') ;
    Result := Path;
 end;

function MyRound(x: single): single; // retorna o numero com apenas um digito
Var
	y: single;
begin
	y := Log10(x);
	if y > 0 then
		y := Int(y + 0.5)
	else
		y := Int(y - 0.5);
	y := Power(10, y);
	y := Int((x / y) + 0.5) * y;
	result := y;
end;

function ChangeDecSep(Number: string): single;
var
i: byte;
begin
  for i := 1 to Length(Number) do
    if Number[i] = '.' then
      Number[i] := ',';
  TryStrToFloat(Number, Result);
end;

function MakeComplex(x, y: TReal): TComplex;
begin
  with result do
    begin
    r := x;
    i := y;
    end;
end;

function Sum(x, y: TComplex) : TComplex;
begin
  with result do
    begin
    r := x.r + y.r;
    i := x.i + y.i;
    end;
end;

function Difference(x, y: TComplex) : TComplex;
begin
  with result do
    begin
    r := x.r - y.r;
    i := x.i - y.i;
    end;
end;

function EiT(t: TReal): TComplex;
begin
  with result do
    begin
    r := cos(t);
    i := sin(t);
    end;
end;

function Product(x, y: TComplex): TComplex;
begin
  with result do
    begin
    r := x.r * y.r - x.i * y.i;
    i := x.r * y.i + x.i * y.r;
    end;
end;

function TimesReal(x: TComplex; y: TReal): TComplex;
begin
  with result do
    begin
    r := x.r * y;
    i := x.i * y;
    end;
end;

function PlusReal(x: TComplex; y: TReal): TComplex;
begin
  with result do
    begin
    r := x.r + y;
    i := x.i;
    end;
end;

function ComplexToStr(x: TComplex): string;
begin
   result := FloatToStr(x.r)
            + ' + '
            + FloatToStr(x.i)
            + 'i';
end;

function AbsSquared(x: TComplex): TReal;
begin
  result := x.r*x.r + x.i*x.i;
end;


Function SubVetor(var V1, V2: TVetor): TVetor;
var
  AmpCos1, AmpSen1, Fase1: Single;
  AmpCos2, AmpSen2, Fase2: Single;
  AmpCos, AmpSen, Fase: Single;
  Amp: Single;

begin
  Fase1 := V1.Fase * PI /180;
  Fase2 := V2.Fase * PI /180;
  AmpCos1 := V1.Amp * cos(Fase1);
  AmpSen1 := V1.Amp * sin(Fase1);
  AmpCos2 := V2.Amp * cos(Fase2);
  AmpSen2 := V2.Amp * sin(Fase2);
  AmpCos := AmpCos1 - AmpCos2;
  AmpSen := AmpSen1 - AmpSen2;
  Amp := sqrt(sqr(AmpCos) + sqr(AmpSen));
  if AmpCos <> 0 then
    begin
      Fase  := ArcTan( AmpSen / AmpCos) * 180 / pi;
      if AmpCos < 0 then Fase := Fase + 180;
      end
  else
    begin
      if AmpSen < 0 then Fase := 90
        else Fase := -90;
    end;
  Fase := SetAngulo(fase);
  Result.Amp := amp;
  Result.Fase := Fase;
end;

Function DoMediaVetor(var Vetor: TVetorMedio): TVetor;
var
  AmpCos, AmpSen: Single;
begin
  Vetor.Vin.Fase := Vetor.Vin.Fase * pi / 180;
  AmpCos := Vetor.Vin.Amp * cos(Vetor.Vin.Fase);
  AmpSen := Vetor.Vin.Amp * sin(Vetor.Vin.Fase);

  Vetor.SomaCos := Vetor.SomaCos + AmpCos;
  Vetor.SomaSen := Vetor.SomaSen + AmpSen;
  Vetor.MediaCos := Vetor.SomaCos / Contamedia;
  Vetor.MediaSen := Vetor.SomaSen / Contamedia;

  Vetor.Media.Amp := sqrt((Vetor.MediaCos * Vetor.MediaCos) + (Vetor.MediaSen * Vetor.MediaSen));
  if Vetor.MediaCos <> 0 then
    begin
      Vetor.Media.Fase  := ArcTan( Vetor.MediaSen / Vetor.MediaCos) * 180 / pi;
      if Vetor.MediaCos < 0 then Vetor.Media.Fase := Vetor.Media.Fase + 180;
      end
  else
    begin
      if Vetor.MediaSen < 0 then Vetor.Media.Fase := 90
        else Vetor.Media.Fase := -90;
    end;
  if Vetor.Media.Fase < 0 then Vetor.Media.Fase := Vetor.Media.Fase + 360;
  Result.Amp := Vetor.Media.amp;
  Result.Fase := Vetor.Media.Fase;
end;


procedure DoTwoPlaneBalance;
begin
// Sem massa  V10 e V20
   V0 := frmCalibra.NumIOA1SM.Value;
   V1 := frmCalibra.NumIOA2SM.Value;
   A0 := frmCalibra.NumIOF1SM.Value;
   A1 := frmCalibra.NumIOF2SM.Value;
   A0 := ToRad(A0);
   A1 := ToRad(A1);
   V0R := ToReal(V0,A0);
   V1R := ToReal(V1,A1);
   V0I := ToImag(V0,A0);
   V1I := ToImag(V1,A1);

// Com massa M1  V11 e V21
   T0 := frmCalibra.NumIOA1M1.Value;
   T1 := frmCalibra.NumIOA2M1.Value;
   B0 := frmCalibra.NumIOF1M1.Value;
   B1 := frmCalibra.NumIOF2M1.Value;
   B0 := ToRad(B0);
   B1 := ToRad(B1);
   T0R := ToReal(T0,B0);
   T1R := ToReal(T1,B1);
   T0I := ToImag(T0,B0);
   T1I := ToImag(T1,B1);

// Com massa M2    V12 e V22
   L0 := frmCalibra.NumIOA1M2.Value;
   L1 := frmCalibra.NumIOA2M2.Value;
   P0 := frmCalibra.NumIOF1M2.Value;
   P1 := frmCalibra.NumIOF2M2.Value;
   P0 := ToRad(P0);
   P1 := ToRad(P1);
   L0R := ToReal(L0,P0);
   L1R := ToReal(L1,P1);
   L0I := ToImag(L0,P0);
   L1I := ToImag(L1,P1);


// SUBTRACAO DOS VETORES
   Z00 := T0R-V0R;
   Z10 := T1R-V1R;
   Z01 := L0R-V0R;
   Z11 := L1R-V1R;

   Y00 := T0I-V0I;
   Y10 := T1I-V1I;
   Y01 := L0I-V0I;
   Y11 := L1I-V1I;

   V0R := V0R * -1.0;
   V0I := V0I * -1.0;
   V1R := V1R * -1.0;
   V1I := V1I * -1.0;

   A := Z00*Z11-Y00*Y11-Z01*Z10+Y01*Y10;
   B := Z00*Y11+Z11*Y00-Z10*Y01-Z01*Y10;
   Delta := A*A + B*B;

   if delta <> 0 then
     begin
       C00R := (Z11*A + B*Y11) / Delta;
       C01R := (Z01*A*-1 - B*Y01) / Delta;
       C00I := (Z11*B*-1 + A*Y11) / Delta;
       C01I := (Z01*B - A*Y01) / Delta;

       C10R := (Z10*A*-1 - B*Y10) / Delta;
       C11R := (Z00*A + B*Y00) / Delta;
       C10I := (Z10*B - A*Y10) / Delta;
       C11I := (Z00*B*-1 + A*Y00) / Delta;
     end;
   Refina2;
end;

procedure Refinamento2(Vet1, Vet2: Tvetor);
begin
   V0 := Vet1.Amp;
   V1 := Vet2.Amp;
   A0 := ToRad(Vet1.Fase);
   A1 := ToRad(Vet2.Fase);
   V0R := ToReal(V0,A0);
   V1R := ToReal(V1,A1);
   V0I := ToImag(V0,A0);
   V1I := ToImag(V1,A1);
   V0R := V0R * -1;
   V1R := V1R * -1;
   V0I := V0I * -1;
   V1I := V1I * -1;
   Refina2;
end;

procedure Refina2;
begin
//Retorno do Refinamento
   C := C00R*V0R - C00I*V0I + C01R*V1R - C01I*V1I;
   D := C00R*V0I + C00I*V0R + C01R*V1I + C01I*V1R;
   E := C10R*V0R - C10I*V0I + C11R*V1R - C11I*V1I;
   F := C10R*V0I + C10I*V0R + C11R*V1I + C11I*V1R;

   //desconto alex

   //GG := FormOpcoes.NumIOCalAmplitude1.Value * Cos(FormOpcoes.NumIOCalPhase1.Value * pi / 180);
   //HH := FormOpcoes.NumIOCalAmplitude1.Value * Sin(FormOpcoes.NumIOCalPhase1.Value * pi / 180);

   //II := FormOpcoes.NumIOCalAmplitude2.Value * Cos(FormOpcoes.NumIOCalPhase2.Value * pi / 180);
   //JJ := FormOpcoes.NumIOCalAmplitude2.Value * Sin(FormOpcoes.NumIOCalPhase2.Value * pi / 180);

   //C := C - GG;
   //D := D - HH;

   //E := E - II;
   //F := F - JJ;


   K0 := 0;
   K1 := 0;   // so para iniciar a variavel
   N0 := SQRT(SQR(C) + SQR(D));
   N1 := SQRT(SQR(E) + SQR(F));
   if C <> 0 then K0 := ArcTan(D/C);
   if E <> 0 then K1 := ArcTan(F/E);
   K0 := K0*180/PI;
   K1 := K1*180/PI;

   if C < 0 then K0 := K0 + 180;
   if E < 0 then K1 := K1 + 180;

   K0 := K0 + frmCalibra.NumIOAnguloM1.Value;
   K1 := K1 + frmCalibra.NumIOAnguloM2.Value;

   frmMain.Gramas.Final[1] := N0 * frmCalibra.NumIOPesoM1.Value;
   frmMain.Gramas.Final[2] := N1 * frmCalibra.NumIOPesoM2.Value;
   frmMain.Fase.Final[1] := SetAngulo(K0);
   frmMain.Fase.Final[2] := SetAngulo(K1);

   if (frmMain.Vectormeter[1].Raio > 0) then
     frmMain.Gramas.Final[1] := (frmCalibra.NumIORaioM1.Value / frmMain.Vectormeter[1].Raio) * frmMain.Gramas.Final[1];
   if (frmMain.Vectormeter[2].Raio > 0) then
     frmMain.Gramas.Final[2] := (frmCalibra.NumIORaioM2.Value / frmMain.Vectormeter[2].Raio) * frmMain.Gramas.Final[2];

   frmMain.Vectormeter[1].Phase := frmMain.Fase.Final[1];
   frmMain.Vectormeter[2].Phase := frmMain.Fase.Final[2];

   if (frmMain.Gramas.Final[1] > 1E+10) or (frmMain.Gramas.Final[2] > 1E+10) then
     begin
     MessageBox(frmMain.Handle,'Verifique se os valores dos vetores estão coerentes!','Informação', MB_ICONWARNING + MB_OK);
     exit;
     end;

   frmMain.Vectormeter[1].Amplitude := frmMain.Gramas.Final[1];
   frmMain.Vectormeter[2].Amplitude := frmMain.Gramas.Final[2];

   frmMain.Gmm.Final[1] := frmMain.Gramas.Final[1] * frmCalibra.NumIORaioM1.Value;//frmMain.Gramas.Final[1] * (frmCalibra.NumIORaioM1.Value / frmMain.Vectormeter[1].Raio)(*frmCalibra.NumIORaioM1.Value*);
   //*****************************************************************
   //**  Modificado: 06/12/2018 - por: Davis Maizing
   //**  ISO-G estava dividindo o resultado de calcularISO pelo RAIO
   //**  o que gerava um resultado errado.
   //**   Correção aplicada: RETIRADO A DIVISÃO PELO RAIO
   //*****************************************************************
   //frmMain.ISOG.Final[1] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[1], (frmCalibra.NumIORaioM1.Value / frmMain.Vectormeter[1].Raio)(*frmCalibra.NumIORaioM1.Value*)); // para qual mancal???
   frmMain.ISOG.Final[1] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[1], (frmCalibra.NumIORaioM1.Value)(*frmCalibra.NumIORaioM1.Value*)); // para qual mancal???

   frmMain.Gmm.Final[2] := frmMain.Gramas.Final[2] * frmCalibra.NumIORaioM2.Value;//frmMain.Gramas.Final[2] * (frmCalibra.NumIORaioM2.Value / frmMain.Vectormeter[2].Raio)(*frmCalibra.NumIORaioM2.Value*);
   //*****************************************************************
   //**  Modificado: 06/12/2018 - por: Davis Maizing
   //**  ISO-G estava dividindo o resultado de calcularISO pelo RAIO
   //**  o que gerava um resultado errado.
   //**   Correção aplicada: RETIRADO A DIVISÃO PELO RAIO
   //*****************************************************************
   //frmMain.ISOG.Final[2] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[2], (frmCalibra.NumIORaioM2.Value / frmMain.Vectormeter[2].Raio)(*frmCalibra.NumIORaioM2.Value*)); // para qual mancal???
   frmMain.ISOG.Final[2] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[2], (frmCalibra.NumIORaioM2.Value)(*frmCalibra.NumIORaioM2.Value*)); // para qual mancal???
end;

function ToRad(R:double):double;
begin
  Result := R * PI / 180;
end;

function ToReal(Ampl:real; Fase: double):double;
begin
  Result := Ampl * Cos(Fase);
end;

function ToImag(Ampl:double; Fase: double):double;
begin
  Result := Ampl * Sin(Fase);
end;

Function SetAngulo(k: Double):Double;
begin
  if K > 360 Then K := K - 360;
  if K < 0 Then K := K + 360;
  Result := K;
end;

function MySetFormat(Val: double): string;
var
  F: string;
  A: Double;
begin
  A := Val;
  if A < 0 then A := -A;
  if A <= 0.001 then F := '%1.4f'
  else if A <= 0.01 then F := '%1.3f'
  else if A <= 0.1 then F := '%1.2f'
  else if A <= 10 then F := '%1.2f'
  else if A <= 100 then F := '%1.2f'
  else if A <= 1000 then F := '%1.0f'
	else if A > 1000 then F := '%1.0f';
	if A = 0 then F := '%1.1f';
	F := Format(F, [Val]);
	result := F;
end;

function Arco(Divisions, Angle: single): string;
var
value : single;
begin
	if (Divisions = 0) then exit;
	value := (Angle * Divisions) / 360;
	Result := Format('%2.2f', [value]);
end;

function FormataSaida(S:String):String;
var
	i: Byte;
	Sa,V: string;
  Myfloat: single;
begin
	i := 1;
	Sa := '';
	while i <= Length(S) do
		begin
			if S[i] = '%' then
				begin
					if (UpperCase(S[i+1]) = 'R') and (UpperCase(S[i+2]) = 'O') and (UpperCase(S[i+3]) = 'T')then
						begin
							Sa := Sa + FormatFloat('00000', frmMain.Rotacao);//MySetFormat(frmMain.Rotacao);
							Inc(i,3);
						end
					else if (UpperCase(S[i+1]) = 'G') and (UpperCase(S[i+2]) = 'M') and (UpperCase(S[i+3]) = 'M')then
						begin
							Sa := Sa + MySetFormat(frmMain.gmm.Final[StrToInt(S[i+4])]);
              Inc(i,4);
						end
					else if (UpperCase(S[i+1]) = 'I') and (UpperCase(S[i+2]) = 'S') and (UpperCase(S[i+3]) = 'O')then
						begin
							Sa := Sa + MySetFormat(frmMain.ISOG.Final[StrToInt(S[i+4])]);
              Inc(i,4);
						end
					else if (UpperCase(S[i+1]) = 'G') and (UpperCase(S[i+2]) = 'R') and (UpperCase(S[i+3]) = 'S')then
						begin
              if frmCalibra.CheckBoxmg.Checked then
							  Sa := Sa + FormatFloat('00000', frmMain.Gramas.Final[StrToInt(S[i+4])])//MySetFormat(frmMain.Gramas.Final[StrToInt(S[i+4])]);
              else
                begin
                V := Format('%.2f',[frmMain.Gramas.Final[StrToInt(S[i+4])]]);
                Myfloat := StrToFloat(V) * 1000;
                Sa := Sa + FormatFloat('00000', Myfloat);//MySetFormat(frmMain.Gramas.Final[StrToInt(S[i+4])]);
                end;
							Inc(i,4);
						end;
					end
			else if S[i] = '\' then
				begin
					if (UpperCase(S[i+1]) = 'N') then
							Sa := Sa + #10;
					if (UpperCase(S[i+1]) = 'R') then
							Sa := Sa + #13;
					Inc(i);
				end
			else
				Sa := Sa + S[i];
			Inc(i);
		end;
	Result := Sa;
end;

procedure ZeraMedia;
begin
  ZeroMemory(@frmmain.VetorMedioP1,SizeOf(frmmain.VetorMedioP1));
  ZeroMemory(@frmmain.VetorMedioP2,SizeOf(frmmain.VetorMedioP2));
  {frmmain.VetorMedioP1.Vin.Amp := 0;
  frmmain.VetorMedioP1.Vin.Fase := 0;
  frmmain.VetorMedioP1.Media.Amp := 0;
  frmmain.VetorMedioP1.Media.Fase := 0;
  frmmain.VetorMedioP1.SomaCos := 0;
  frmmain.VetorMedioP1.SomaSen := 0;
  frmmain.VetorMedioP1.MediaCos := 0;
  frmmain.VetorMedioP1.MediaSen := 0;
  frmmain.VetorMedioP1.AmpCos := 0;
  frmmain.VetorMedioP1.AmpSen := 0;
  frmmain.VetorMedioP2 := frmmain.VetorMedioP1;}
	ContaMedia := 0;
  ContaMedidasFalsas := 0;
	MediaPronta := False;
  frmMain.lblMedia.Caption := 'Media ' + IntToStr(ContaMedia) + '/' + IntToStr(frmMain.Medias);
end;

procedure DoSinglePlaneBalance;
begin
  if frmCalibra.RadioButtonMancal1.Checked then
    begin
    DASMT := frmCalibra.NumIOA1SM.Value;
    DFSMT := frmCalibra.NumIOF1SM.Value;
    DACMT := frmCalibra.NumIOA1M1.Value;
    DFCMT := frmCalibra.NumIOF1M1.Value;
    DADM := frmCalibra.NumIOAnguloM1.Value;
    end
  else
    begin
    DASMT := frmCalibra.NumIOA2SM.Value;
    DFSMT := frmCalibra.NumIOF2SM.Value;
    DACMT := frmCalibra.NumIOA2M2.Value;
    DFCMT := frmCalibra.NumIOF2M2.Value;
    DADM := frmCalibra.NumIOAnguloM2.Value;
    end;

  //V0R
  X1 := DASMT * Cos(DFSMT * pi / 180);
  //V0I
  Y1 := DASMT * Sin(DFSMT * pi / 180);
  //V1R
  X2 := DACMT * Cos(DFCMT * pi / 180);
  //V1I
  Y2 := DACMT * Sin(DFCMT * pi / 180);

  {if frmCalibra.RadioButtonMancal1.Checked then
    begin
    X3 := FormOpcoes.NumIOCalAmplitude1.Value * Cos(FormOpcoes.NumIOCalPhase1.Value * pi / 180);
    Y3 := FormOpcoes.NumIOCalAmplitude1.Value * Sin(FormOpcoes.NumIOCalPhase1.Value * pi / 180);
    end;

  if frmCalibra.RadioButtonMancal2.Checked then
    begin
    X3 := FormOpcoes.NumIOCalAmplitude2.Value * Cos(FormOpcoes.NumIOCalPhase2.Value * pi / 180);
    Y3 := FormOpcoes.NumIOCalAmplitude2.Value * Sin(FormOpcoes.NumIOCalPhase2.Value * pi / 180);
    end;}

  Xr := X2 - X1; //V0R - V1R
  Yr := Y2 - Y1; //V0I - V1I

  //desconto alex
  {Xr := Xr - X3;
  Yr := Yr - Y3;}

  //encontro o módulo do vetor resultante (valor amplitude)
  Raiz := Sqrt(Sqr(Xr) + Sqr(Yr));

  if Xr <> 0 then
    begin
    //encontro o angulo de correção
    Tange := ArcTan(Yr / Xr) * 180 / pi;
    if Xr < 0 then Tange := Tange + 180;
	  end;

   if (DADM < 0) or (DADM > 360) then DADM := 0;
    //angulo massa de teste
    Vm := DADM;
    Fase1Plano := DFSMT + 180 - Tange + DADM;
    Fase1Plano := SetAngulo(Fase1Plano);
		if frmCalibra.RadioButtonMancal1.Checked then
      begin
      Peso1Plano := (frmCalibra.NumIOPesoM1.Value * DASMT) / Raiz;
      end;
		if frmCalibra.RadioButtonMancal2.Checked then
      begin
      Peso1Plano := (frmCalibra.NumIOPesoM2.Value * DASMT) / Raiz;
      end;

	if frmCalibra.RadioButtonMancal1.Checked then
		begin
		frmMain.Gramas.Final[1] := Peso1Plano;
		frmMain.Fase.Final[1] := Fase1Plano;
    if (frmMain.Vectormeter[1].Raio > 0) then
      Peso1Plano := (frmCalibra.NumIORaioM1.Value / frmMain.Vectormeter[1].Raio) * Peso1Plano;
		frmMain.Vectormeter[1].Phase := Fase1Plano;
		frmMain.Vectormeter[1].Amplitude := Peso1Plano;
    frmMain.Gmm.Final[1] := frmMain.Gramas.Final[1] * frmCalibra.NumIORaioM1.Value;//frmMain.Gramas.Final[1] * (frmCalibra.NumIORaioM1.Value / frmMain.Vectormeter[1].Raio)(*frmCalibra.NumIORaioM1.Value*);

    //frmMain.ISOG.Final[1] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[1], (frmCalibra.NumIORaioM1.Value / frmMain.Vectormeter[1].Raio)(*frmCalibra.NumIORaioM1.Value*)); // para qual mancal???
    frmMain.ISOG.Final[1] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[1], frmCalibra.NumIORaioM1.Value); // para qual mancal???
    end
	else
		begin
		frmMain.Gramas.Final[2] := Peso1Plano;
		frmMain.Fase.Final[2] := Fase1Plano;
    if (frmMain.Vectormeter[2].Raio > 0) then
      Peso1Plano := (frmCalibra.NumIORaioM2.Value / frmMain.Vectormeter[2].Raio) * Peso1Plano;
		frmMain.Vectormeter[2].Phase := Fase1Plano;
		frmMain.Vectormeter[2].Amplitude := Peso1Plano;
    frmMain.Gmm.Final[2] := frmMain.Gramas.Final[2] * frmCalibra.NumIORaioM2.Value;////frmMain.Gramas.Final[2] * (frmCalibra.NumIORaioM2.Value / frmMain.Vectormeter[2].Raio)(*frmCalibra.NumIORaioM2.Value*);
    //frmMain.ISOG.Final[2] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[2], (frmCalibra.NumIORaioM2.Value / frmMain.Vectormeter[2].Raio)(*frmCalibra.NumIORaioM2.Value*)); // para qual mancal???
    frmMain.ISOG.Final[2] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[2], frmCalibra.NumIORaioM2.Value); // para qual mancal???
    end;
end;

procedure Refina1(V: TVetor);
begin
  DAAC := V.Amp;
  DFAC := V.Fase;
  if frmCalibra.RadioButtonMancal1.Checked then
    if (frmCalibra.NumIOPesoM1.Value <= 0)
      or (frmCalibra.NumIOAnguloM1.Value < -360)
        or (frmCalibra.NumIOAnguloM1.Value > 360)then exit;
  if frmCalibra.RadioButtonMancal2.Checked then
    if (frmCalibra.NumIOPesoM2.Value <= 0)
      or (frmCalibra.NumIOAnguloM2.Value < -360)
        or (frmCalibra.NumIOAnguloM2.Value > 360)then exit;

  Atra := Vm - Tange;
  if frmCalibra.RadioButtonMancal1.Checked then
    Sensi := Raiz / frmCalibra.NumIOPesoM1.Value;
  if frmCalibra.RadioButtonMancal2.Checked then
    Sensi := Raiz / frmCalibra.NumIOPesoM2.Value;

  if DAAC > 0 then
    begin
    Peso1Plano := DAAC / Sensi;
    Fase1Plano := SetAngulo(Atra + DFAC + 180);
    end
  else
    begin
    if frmCalibra.RadioButtonMancal1.Checked then
      begin
      Peso1Plano := frmCalibra.NumIOPesoM1.Value * DASMT / Raiz;
      end
    else
      begin
      Peso1Plano := frmCalibra.NumIOPesoM2.Value * DASMT / Raiz;
      end;

    if (DADM < 0) or (DADM > 360) then DADM := 0;
    Fase1Plano := DFSMT + 180 - Tange + DADM;
    end;

	if frmCalibra.RadioButtonMancal1.Checked then
		begin
		frmMain.Gramas.Final[1] := Peso1Plano;
		frmMain.Fase.Final[1] := Fase1Plano;
    if (frmMain.Vectormeter[1].Raio > 0) then
      Peso1Plano := (frmCalibra.NumIORaioM1.Value / frmMain.Vectormeter[1].Raio) * Peso1Plano;
		frmMain.Vectormeter[1].Phase := Fase1Plano;
		frmMain.Vectormeter[1].Amplitude := Peso1Plano;
    frmMain.Gmm.Final[1] := frmMain.Gramas.Final[1] * frmCalibra.NumIORaioM1.Value;////frmMain.Gramas.Final[1] * (frmCalibra.NumIORaioM1.Value / frmMain.Vectormeter[1].Raio)(*frmCalibra.NumIORaioM1.Value*);

    //*****************************************************************
    //**  Modificado: 06/12/2018 - por: Davis Maizing
    //**  ISO-G estava dividindo o resultado de calcularISO pelo RAIO
    //**  o que gerava um resultado errado.
    //**   Correção aplicada: RETIRADO A DIVISÃO PELO RAIO
    //*****************************************************************
    //frmMain.ISOG.Final[1] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[1], (frmCalibra.NumIORaioM1.Value / frmMain.Vectormeter[1].Raio)(*frmCalibra.NumIORaioM1.Value*)); // para qual mancal???
    frmMain.ISOG.Final[1] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[1], frmCalibra.NumIORaioM1.Value); // para qual mancal???

    end
	else
		begin
		frmMain.Gramas.Final[2] := Peso1Plano;
		frmMain.Fase.Final[2] := Fase1Plano;
    if (frmMain.Vectormeter[2].Raio > 0) then
      Peso1Plano := (frmCalibra.NumIORaioM2.Value / frmMain.Vectormeter[2].Raio) * Peso1Plano;
    frmMain.Vectormeter[2].Phase := Fase1Plano;
		frmMain.Vectormeter[2].Amplitude := Peso1Plano;
    frmMain.Gmm.Final[2] := frmMain.Gramas.Final[2] * frmCalibra.NumIORaioM2.Value;//frmMain.Gramas.Final[2] * (frmCalibra.NumIORaioM2.Value / frmMain.Vectormeter[2].Raio)(*frmCalibra.NumIORaioM2.Value*);

    //*****************************************************************
    //**  Modificado: 06/12/2018 - por: Davis Maizing
    //**  ISO-G estava dividindo o resultado de calcularISO pelo RAIO
    //**  o que gerava um resultado errado.
    //**   Correção aplicada: RETIRADO A DIVISÃO PELO RAIO
    //*****************************************************************
    //frmMain.ISOG.Final[2] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[2], (frmCalibra.NumIORaioM2.Value / frmMain.Vectormeter[2].Raio)(*frmCalibra.NumIORaioM2.Value*)); // para qual mancal???
    frmMain.ISOG.Final[2] := frmMain.ISO1940.CalcularISO(frmMain.Gramas.Final[2], frmCalibra.NumIORaioM2.Value); // para qual mancal???

    end;
end;

{ TReportFile }

constructor TReportFile.Create(const Arquivo: string);
begin
  FileName := Arquivo;
end;

end.
