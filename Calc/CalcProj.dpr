program CalcProj;

uses
  Vcl.Forms,
  fm_Calc in 'fm_Calc.pas' {fmCalc},
  ExpressionEvaluator in 'ExpressionEvaluator.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfmCalc, fmCalc);
  Application.Run;
end.
