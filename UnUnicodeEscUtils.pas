unit UnUnicodeEscUtils;

interface

uses
  Windows, Classes, SysUtils;

type
  TUnicodeEscapeString = String;

function UnicodeEscToString(AUEStr: TUnicodeEscapeString): String;

implementation

uses StrUtils;

const
  cUnicodeEscCharList : array[$40..$4F, $0..$F] of Char = (
    {           0    1    2    3    4    5    6    7    8    9    A    B    C    D    E    F   }
    {U+040x}  ('?', '¨', '€', '', 'ª', '½', '²', '¯', '£', 'Š', 'Œ', 'Ž', '', '?', '¡', ''),
    {U+041x}  ('À', 'Á', 'Â', 'Ã', 'Ä', 'Å', 'Æ', 'Ç', 'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï'),
    {U+042x}  ('Ð', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', '×', 'Ø', 'Ù', 'Ú', 'Û', 'Ü', 'Ý', 'Þ', 'ß'),
    {U+043x}  ('à', 'á', 'â', 'ã', 'ä', 'å', 'æ', 'ç', 'è', 'é', 'ê', 'ë', 'ì', 'í', 'î', 'ï'),
    {U+044x}  ('ð', 'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', '÷', 'ø', 'ù', 'ú', 'û', 'ü', 'ý', 'þ', 'ÿ'),
    {U+045x}  ('?', '¸', '', 'ƒ', 'º', '¾', '³', '¿', '¼', 'š', 'œ', 'ž', '', '?', '¢', 'Ÿ'),
    {U+046x}  ('?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?'),
    {U+047x}  ('?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?'),
    {U+048x}  ('?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?'),
    {U+049x}  ('¥', '´', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?'),
    {U+04Ax}  ('?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?'),
    {U+04Bx}  ('?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?'),
    {U+04Cx}  ('?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?'),
    {U+04Dx}  ('?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?'),
    {U+04Ex}  ('?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?'),
    {U+04Fx}  ('?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?', '?')
  );

function UnicodeEscToString(AUEStr: TUnicodeEscapeString): String;
var
  i : Integer;
  j : Integer;
  lInputStr : String;
  lUEChar : String;
  lPosUEChar : Integer;
  lPredPos : Integer;
begin
  Result := '';
  lInputStr := StringReplace(AUEStr, '\"', '"', [rfReplaceAll]);
  lPredPos := 1;
  lPosUEChar := PosEx('\u0', lInputStr, lPredPos);
  if lPosUEChar>0 then
    begin
      Result := Copy(lInputStr, 1, lPosUEChar-1);
      while lPosUEChar>0 do
        begin
          lUEChar := Copy(lInputStr, lPosUEChar, 6);
          i := StrToInt('$'+Copy(lUEChar, 4, 2));
          j := StrToInt('$'+Copy(lUEChar, 6, 1));
          Result := Result + cUnicodeEscCharList[i, j];
          lPredPos := lPosUEChar + 6;
          if lPredPos>Length(lInputStr) then
            lPosUEChar := 0
          else
            begin
              lPosUEChar := PosEx('\u0', lInputStr, lPredPos);
              if lPosUEChar>lPredPos then
                begin
                  Result := Result + Copy(lInputStr, lPredPos, lPosUEChar-lPredPos);
                  lPredPos := lPosUEChar;
                end;
            end;
        end;
      if lPredPos<Length(lInputStr)then
        Result := Result + Copy(lInputStr, lPredPos, Length(lInputStr)-lPredPos+1);
    end
  else
    Result := lInputStr;
end;

end.
