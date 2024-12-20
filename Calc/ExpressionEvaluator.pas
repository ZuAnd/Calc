unit ExpressionEvaluator;

interface

uses
  System.SysUtils, System.Classes;

type
  TExpressionEvaluator = class
  private
    class function IsDigit(ch: Char): Boolean;
    class function IsOperator(ch: Char): Boolean;
    class function Priority(ch: Char): Integer;
    class function ApplyOperator(op: Char; operand1, operand2: Integer): Real;
  public
    class function Evaluate(const expression: string): Real;
  end;

implementation

{ TExpressionEvaluator }

class function TExpressionEvaluator.IsDigit(ch: Char): Boolean;
begin
  Result := (ch >= '0') and (ch <= '9');
end;

class function TExpressionEvaluator.IsOperator(ch: Char): Boolean;
begin
  Result := (ch = '+') or (ch = '-') or (ch = '*') or (ch = '/');
end;

class function TExpressionEvaluator.Priority(ch: Char): Integer;
begin
  case ch of
    '(', '{', '[': Result := 0;
    '+', '-': Result := 1;
    '*', '/': Result := 2;
    else Result := -1;
  end;
end;

class function TExpressionEvaluator.ApplyOperator(op: Char; operand1, operand2: Integer): Real;
begin
  case op of
    '+': Result := operand1 + operand2;
    '-': Result := operand1 - operand2;
    '*': Result := operand1 * operand2;
    '/': Result := operand1 / operand2; // Integer division
  end;
end;

class function TExpressionEvaluator.Evaluate(const expression: string): Real;
var
  stackOperands: TStringList;
  stackOperators: TStringList;
  stackTypeBracket: TStringList;
  i: Integer;
  ch: Char;
begin
  stackOperands := TStringList.Create;
  stackOperators := TStringList.Create;
  stackTypeBracket := TStringList.Create;
  try
    i := 1;
    while i <= Length(expression) do
    begin
      ch := expression[i];
      if IsDigit(ch) then
      begin
        // Read the whole number
        Result := 0;
        while (i <= Length(expression)) and IsDigit(expression[i]) do
        begin
          Result := Result * 10 + StrToInt(expression[i]);
          Inc(i);
        end;
        stackOperands.Add(FloatToStr(Result));
      end
      else if IsOperator(ch) then
      begin
        while (stackOperators.Count > 0) and (Priority(stackOperators[stackOperators.Count - 1][1]) >= Priority(ch)) do
        begin
          stackOperands.Add(FloatToStr(ApplyOperator(stackOperators[stackOperators.Count - 1][1],
            StrToInt(stackOperands[stackOperands.Count - 2]),
            StrToInt(stackOperands[stackOperands.Count - 1]))));
          stackOperands.Delete(stackOperands.Count - 2);
          stackOperands.Delete(stackOperands.Count - 2);
          stackOperators.Delete(stackOperators.Count - 1);
        end;
        stackOperators.Add(ch);
        Inc(i);
      end
      else if (ch = '(') or (ch = '{') or (ch = '[') then
      begin
        stackOperators.Add(ch);
        case ch of
          '(': stackTypeBracket.Add('1');
          '{': stackTypeBracket.Add('2');
          '[': stackTypeBracket.Add('3');
        end;
        Inc(i);
      end
      else if (ch = ')') or (ch = '}') or (ch = ']') then
      begin

          case ch of
            ')': if stackTypeBracket[stackTypeBracket.Count -1][1] <> '1' then raise Exception.Create('Invalid expression: Brackets are placed incorrectly!');
            '}': if stackTypeBracket[stackTypeBracket.Count -1][1] <> '2' then raise Exception.Create('Invalid expression: Brackets are placed incorrectly!');
            ']': if stackTypeBracket[stackTypeBracket.Count -1][1] <> '3' then raise Exception.Create('Invalid expression: Brackets are placed incorrectly!');
          end;

        while (stackOperators.Count > 0) and (stackOperators[stackOperators.Count - 1][1] <> '(') and
          (stackOperators[stackOperators.Count - 1][1] <> '{') and (stackOperators[stackOperators.Count - 1][1] <> '[') do
        begin

          stackOperands.Add(FloatToStr(ApplyOperator(stackOperators[stackOperators.Count - 1][1],
            StrToInt(stackOperands[stackOperands.Count - 2]),
            StrToInt(stackOperands[stackOperands.Count - 1]))));
          stackOperands.Delete(stackOperands.Count - 2);
          stackOperands.Delete(stackOperands.Count - 2);
          stackOperators.Delete(stackOperators.Count - 1);
          stackTypeBracket.Delete(stackTypeBracket.Count -1);
        end;
        if (stackOperators.Count > 0) and ((stackOperators[stackOperators.Count - 1][1] = '(') or
          (stackOperators[stackOperators.Count - 1][1] = '{') or (stackOperators[stackOperators.Count - 1][1] = '[')) then
          stackOperators.Delete(stackOperators.Count - 1)
        else
          raise Exception.Create('Invalid expression: Unmatched closing bracket');
        Inc(i);
      end
      else
        raise Exception.Create('Invalid expression: Unexpected character');
    end;

    while stackOperators.Count > 0 do
    begin
      if (stackOperators[stackOperators.Count - 1][1] = '(') or (stackOperators[stackOperators.Count - 1][1] = '{') or
        (stackOperators[stackOperators.Count - 1][1] = '[') then
        raise Exception.Create('Invalid expression: Unmatched opening bracket');
      stackOperands.Add(FloatToStr(ApplyOperator(stackOperators[stackOperators.Count - 1][1],
        StrToInt(stackOperands[stackOperands.Count - 2]),
        StrToInt(stackOperands[stackOperands.Count - 1]))));
      stackOperands.Delete(stackOperands.Count - 2);
      stackOperands.Delete(stackOperands.Count - 2);
      stackOperators.Delete(stackOperators.Count - 1);
    end;

    if stackOperands.Count <> 1 then
      raise Exception.Create('Invalid expression');

    Result := StrToFloat(stackOperands[0]);
  finally
    stackOperands.Free;
    stackOperators.Free;
  end;
end;

end.
