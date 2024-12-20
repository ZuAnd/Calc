unit fm_Calc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ComCtrls, ExpressionEvaluator;

type
  TfmCalc = class(TForm)
    sbPlus: TSpeedButton;
    sbMinus: TSpeedButton;
    sbMultiply: TSpeedButton;
    sbDivide: TSpeedButton;
    sbCancel: TSpeedButton;
    sbOne: TSpeedButton;
    sbTwo: TSpeedButton;
    sbThree: TSpeedButton;
    sbFour: TSpeedButton;
    sbFive: TSpeedButton;
    sbSix: TSpeedButton;
    sbSeven: TSpeedButton;
    sbEight: TSpeedButton;
    sbNine: TSpeedButton;
    sbZero: TSpeedButton;
    sbEnter: TSpeedButton;
    rtResult: TRichEdit;
    sbBracket1: TSpeedButton;
    sbBracket2: TSpeedButton;
    procedure sbEnterClick(Sender: TObject);
    procedure sbCancelClick(Sender: TObject);
    procedure rtResultKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbOneClick(Sender: TObject);
    procedure sbTwoClick(Sender: TObject);
    procedure sbThreeClick(Sender: TObject);
    procedure sbFourClick(Sender: TObject);
    procedure sbFiveClick(Sender: TObject);
    procedure sbSixClick(Sender: TObject);
    procedure sbSevenClick(Sender: TObject);
    procedure sbEightClick(Sender: TObject);
    procedure sbNineClick(Sender: TObject);
    procedure sbZeroClick(Sender: TObject);
    procedure sbMultiplyClick(Sender: TObject);
    procedure sbDivideClick(Sender: TObject);
    procedure sbMinusClick(Sender: TObject);
    procedure sbPlusClick(Sender: TObject);
    procedure sbBracket1Click(Sender: TObject);
    procedure sbBracket2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rtResultKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure HighlightDigitsInRichEdit(Value: string);
  public
    { Public declarations }
  end;
const
  NL = #13#10; //NewLine
var
  fmCalc: TfmCalc;
  Eval: TExpressionEvaluator;

implementation

{$R *.dfm}

procedure TfmCalc.rtResultKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Shift=[ssCtrl] then
    case Key of
      86:Key:=0;
    end;

    if Shift=[ssShift] then
    case Key of
      45:Key:=0;
    end;
end;

procedure TfmCalc.rtResultKeyPress(Sender: TObject; var Key: Char);
begin
    Case key of
      #27: sbCancelClick(sbCancel);
      #13: sbEnterClick(sbEnter);
    End;

    if not CharInSet(key, ['0'..'9', '(',')','[',']','}','{','*','/','-','+']) then
      Key := #0;
end;

procedure TfmCalc.FormCreate(Sender: TObject);
begin
  Eval := TExpressionEvaluator.Create;
end;

procedure TfmCalc.FormDestroy(Sender: TObject);
begin
  Eval := nil;
end;

procedure TfmCalc.FormKeyPress(Sender: TObject; var Key: Char);
begin
    Case key of
      #27: sbCancelClick(sbCancel);
      #13: sbEnterClick(sbEnter);
    End;
end;

procedure TfmCalc.FormShow(Sender: TObject);
begin
  rtResult.SetFocus;
end;

procedure TfmCalc.sbBracket1Click(Sender: TObject);
begin
  rtResult.SelText := '(';
end;

procedure TfmCalc.sbBracket2Click(Sender: TObject);
begin
  rtResult.SelText := ')';
end;

procedure TfmCalc.sbCancelClick(Sender: TObject);
begin
  rtResult.Clear;
end;

procedure TfmCalc.sbDivideClick(Sender: TObject);
begin
  rtResult.SelText := '/';
end;

procedure TfmCalc.sbEightClick(Sender: TObject);
begin
   rtResult.SelText := '8';
end;

procedure TfmCalc.sbEnterClick(Sender: TObject);
var
  Expression: string;
  Result: Real;
begin
try
  Expression := StringReplace(rtResult.Text, ' ', '', [rfReplaceAll]);
  Expression := StringReplace(Expression, NL, '', [rfReplaceAll]);

  Result := TExpressionEvaluator.Evaluate(Expression);
  HighlightDigitsInRichEdit(FloatToStr(Result));
except
  on E: Exception do
    begin
      MessageDlg(e.Message, mtError, [tMsgDlgBtn.mbOK], 0);
      rtResult.Clear;
    end;
  end;
end;

procedure TfmCalc.sbFiveClick(Sender: TObject);
begin
  rtResult.SelText := '5';
end;

procedure TfmCalc.sbFourClick(Sender: TObject);
begin
  rtResult.SelText := '4';
end;

procedure TfmCalc.sbMinusClick(Sender: TObject);
begin
   rtResult.SelText := '-';
end;

procedure TfmCalc.sbMultiplyClick(Sender: TObject);
begin
  rtResult.SelText := '*';
end;

procedure TfmCalc.sbNineClick(Sender: TObject);
begin
  rtResult.SelText := '9';
end;

procedure TfmCalc.sbOneClick(Sender: TObject);
begin
  rtResult.SelText := '1';
end;

procedure TfmCalc.sbPlusClick(Sender: TObject);
begin
  rtResult.SelText := '+';
end;

procedure TfmCalc.sbSevenClick(Sender: TObject);
begin
  rtResult.SelText := '7';
end;

procedure TfmCalc.sbSixClick(Sender: TObject);
begin
  rtResult.SelText := '6';
end;

procedure TfmCalc.sbThreeClick(Sender: TObject);
begin
  rtResult.SelText := '3';
end;

procedure TfmCalc.sbTwoClick(Sender: TObject);
begin
  rtResult.SelText := '2';
end;

procedure TfmCalc.sbZeroClick(Sender: TObject);
begin
  rtResult.SelText := '0';
end;

procedure TfmCalc.HighlightDigitsInRichEdit(Value: string);
var
  i: Integer;
  integerPart, fractionalPart: string;
  decimalPos: Integer;
begin
   var CurrentColor: TColor := clGreen;
  rtResult.Clear;


  if (Pos('.', Value) <> 0) then
    decimalPos := Pos('.', Value);

  if (Pos(',', Value) <> 0) then
    decimalPos := Pos(',', Value);
  if decimalPos <> 0 then
  begin
    integerPart := Copy(Value, 1, decimalPos - 1);
    fractionalPart := Copy(Value, decimalPos + 1, Length(Value) - decimalPos);

    if Length(integerPart) > 4 then
      begin
        for i := 1 to Length(integerPart) do
        begin
          if (i mod 3 = 0) then
          begin
            if CurrentColor = clGreen then
              CurrentColor := clred
              else
                CurrentColor := clGreen;
          end;
          rtResult.SelAttributes.Color := CurrentColor;
          rtResult.SelText := integerPart[i];
        end;
      end else if Length(integerPart) = 4 then
      begin

        for i := 1 to 4 do
        begin
          if (i = 1) then
            CurrentColor := clred
            else
                CurrentColor := clGreen;

          rtResult.SelAttributes.Color := CurrentColor;
          rtResult.SelText := integerPart[i];
        end;

      end
        else
        begin
          rtResult.SelAttributes.Color := clGreen;
          rtResult.SelText := integerPart;
        end;

    rtResult.SelAttributes.Color := clyellow;
    rtResult.SelText := ','+fractionalPart;
  end
    else
    begin

      if Length(Value) > 4 then
      begin
        for i := 1 to Length(Value) do
        begin
          if (i mod 3 = 0) then
          begin
            if CurrentColor = clGreen then
              CurrentColor := clred
              else
                CurrentColor := clGreen;
          end;
          rtResult.SelAttributes.Color := CurrentColor;
          rtResult.SelText := Value[i];
        end;
      end else if Length(Value) = 4 then
      begin

        for i := 1 to 4 do
        begin
          if (i = 1) then
            CurrentColor := clred
            else
                CurrentColor := clGreen;

          rtResult.SelAttributes.Color := CurrentColor;
          rtResult.SelText := Value[i];
        end;

      end
        else
        begin
          rtResult.SelAttributes.Color := clGreen;
          rtResult.SelText := Value;
        end;
    end;

end;

end.
