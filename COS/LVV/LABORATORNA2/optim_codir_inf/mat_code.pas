unit mat_code;

interface
uses Math;

const
  CHARTABLE_SIZE = 256;
  CODETABLE_MAXCODEBITS = 48;

type
  PMatCharTableItem = ^TMatCharTableItem;
  TMatCharTableItem = record
    Value: Byte;
    Counter: Integer;
    Probability: Single;
    Entropy: Single;
  end;

  TMatCharTable = array[0..CHARTABLE_SIZE-1]of TMatCharTableItem;
  TMatCharIndex = array[0..CHARTABLE_SIZE-1]of Integer;

  TMatModeler = class
  private
    FCharTable: TMatCharTable;
    FCharIndex: TMatCharIndex;
    FText: string;
    FCharsPerTable: Integer;
    FCharsPerText: Integer;
    FEntropyPerChar: Single;
    FEntropyPerText: Single;
    FBitsPerChar: Integer;
    FBitsPerText: Integer;
    FRedundancePerText: Single;
    FRedundancePerChar: Single;
    procedure ZeroCharTable;
    procedure InitCharTable;
    procedure SortCharTable;
    function GetCharsPerText: Integer;
    function GetCharsPerTable: Integer;
    function GetEntropyPerText: Single;
    function GetEntropyPerChar: Single;
    function GetCharTable(Index: Integer): PMatCharTableItem;
    function GetCharIndex(Index: Integer): Integer;
    function GetBitsPerChar: Integer;
    function GetBitsPerText: Integer;
    function GetRedundancePerText: Single;
    function GetRedundancePerChar: Single;
  public
    constructor Create;

    procedure Execute(AText: string);

    property Text: string read FText;
    property CharsPerTable: Integer read FCharsPerTable;
    property CharsPerText: Integer read FCharsPerText;
    property CharTable[Index: Integer]: PMatCharTableItem read GetCharTable;
    property CharIndex[Index: Integer]: Integer read GetCharIndex;
    property EntropyPerText: Single read FEntropyPerText;
    property EntropyPerChar: Single read FEntropyPerChar;
    property BitsPerChar: Integer read FBitsPerChar;
    property BitsPerText: Integer read FBitsPerText;
    property RedundancePerText: Single read FRedundancePerText;
    property RedundancePerChar: Single read FRedundancePerChar;
  end;

  PMatCodeTableItem = ^TMatCodeTableItem;
  TMatCodeTableItem = record
    CharItem: PMatCharTableItem;
    Code: String[CODETABLE_MAXCODEBITS];
    CodeBits: Integer;
    Redundance: Single;
  end;

  TMatCodeTable = array of TMatCodeTableItem;
  TMatCodeIndex = array of Integer;

  TMatCoder = class
  private
    FModeler: TMatModeler;
    FCodeTable: TMatCodeTable;
    FCodeIndex: TMatCodeIndex;
    FCodesPerTable: Integer;
    function GetCodeTable(Index: Integer): PMatCodeTableItem;
    function GetCodeIndex(Index: Integer): Integer;
    procedure InitCodeTable;
    procedure BuildCodeTable;virtual;abstract;
    procedure SortCodeTable;
    procedure CalcCodeTable;
    function GetAvgCodeLength: Single;
    function GetRatioEffective: Single;
    function GetRatioCompression: Single;
    function GetBitsPerText: Integer;
    function GetCodeTableByValue(Value: Byte): PMatCodeTableItem;
  public
    constructor Create(AModeler: TMatModeler);
    procedure Execute;virtual;

    property Modeler: TMatModeler read FModeler;
    property CodesPerTable: Integer read FCodesPerTable;
    property CodeTable[Index: Integer]: PMatCodeTableItem read GetCodeTable;
    property CodeTableByValue[Value: Byte]: PMatCodeTableItem read GetCodeTableByValue;
    property CodeIndex[Index: Integer]: Integer read GetCodeIndex;
    property AvgCodeLength: Single read GetAvgCodeLength;
    property BitsPerText: Integer read GetBitsPerText;
    property RatioEffective: Single read GetRatioEffective;
    property RatioCompression: Single read GetRatioCompression;
  end;

  TMatCoderShannonFano = class(TMatCoder)
  private
    procedure BuildCodeTable;override;
  end;

  TMatCoderHuffman = class(TMatCoder)
  private
    procedure BuildCodeTable;override;
  end;


implementation

function CalcRelativeRedundance(Entropy, BitsLen: Single): Single;
begin
  if BitsLen <> 0 then
    Result := 1 - (Entropy / BitsLen)
  else
    Result := 0;  
end;

function CalcAbsoluteRedundance(Entropy, BitsLen: Single): Single;
begin
  Result := BitsLen - Entropy;
end;

{ TMatModeler }

procedure TMatModeler.Execute(AText: string);
begin
  FText := AText;
  InitCharTable;
end;

constructor TMatModeler.Create;
begin
  InitCharTable;
end;

procedure TMatModeler.ZeroCharTable;
var i: Integer;
begin
  for i := 0 to CHARTABLE_SIZE-1 do
  with FCharTable[i] do
  begin
    Value := i;
    Counter := 0;
    Probability := 0;
    Entropy := 0;
  end;
end;

procedure TMatModeler.SortCharTable;
var i, j, x: Integer;
begin
  for i := 0 to CHARTABLE_SIZE-1 do FCharIndex[i] := i;

  for i := 0 to CHARTABLE_SIZE-1 do
    for j := i + 1 to CHARTABLE_SIZE-1 do
      if FCharTable[FCharIndex[i]].Probability <=
         FCharTable[FCharIndex[j]].Probability then
      begin
        x := FCharIndex[i];
        FCharIndex[i] := FCharIndex[j];
        FCharIndex[j] := x;
      end;
end;

procedure TMatModeler.InitCharTable;
var i, l: Integer;
begin
  FCharsPerText := GetCharsPerText;

  ZeroCharTable;

  for i := 1 to FCharsPerText do Inc(FCharTable[Ord(FText[i])].Counter);

  if FCharsPerText > 0 then
  begin
     l := FCharsPerText;
     for i := 0 to CHARTABLE_SIZE-1 do
     with FCharTable[i] do
     if Counter <> 0 then
     begin
       Probability := Counter / l;
       Entropy := -log2(Probability);
     end;
  end;

  SortCharTable;

  FCharsPerTable := GetCharsPerTable;
  FEntropyPerText := GetEntropyPerText;
  FEntropyPerChar := GetEntropyPerChar;
  FBitsPerChar := GetBitsPerChar;
  FBitsPerText := GetBitsPerText;
  FRedundancePerText := GetRedundancePerText;
  FRedundancePerChar := GetRedundancePerChar;
end;

function TMatModeler.GetCharsPerText: Integer;
begin
  Result := Length(FText);
end;

function TMatModeler.GetCharsPerTable: Integer;
var i: Integer;
begin
  Result := 0;
  for i := 0 to CHARTABLE_SIZE-1 do
    if FCharTable[i].Counter <> 0 then Inc(Result);
end;

function TMatModeler.GetCharTable(Index: Integer): PMatCharTableItem;
begin
  Result := @FCharTable[Index];
end;

function TMatModeler.GetCharIndex(Index: Integer): Integer;
begin
  Result := FCharIndex[Index];
end;

function TMatModeler.GetEntropyPerText: Single;
var i: Integer;
begin
  Result := 0;
  for i := 1 to FCharsPerText do
  begin
    Result := Result + FCharTable[Ord(FText[i])].Entropy;
  end;
end;

function TMatModeler.GetEntropyPerChar: Single;
begin
  if FCharsPerText <> 0 then
    Result := FEntropyPerText / FCharsPerText
  else
    Result := 0;
end;

function TMatModeler.GetBitsPerChar: Integer;
begin
  if FCharsPerTable <> 0 then
    Result := ceil(log2(FCharsPerTable))
  else
    Result := 0;
end;

function TMatModeler.GetBitsPerText: Integer;
begin
  Result := FCharsPerText * FBitsPerChar;
end;

function TMatModeler.GetRedundancePerText: Single;
begin
  Result := FBitsPerText - FEntropyPerText;
end;

function TMatModeler.GetRedundancePerChar: Single;
begin
  Result := FBitsPerChar - FEntropyPerChar;
end;

{ TMatCoder }

constructor TMatCoder.Create(AModeler: TMatModeler);
begin
  FModeler := AModeler;
end;

function TMatCoder.GetCodeTable(Index: Integer): PMatCodeTableItem;
begin
  Result := @FCodeTable[Index];
end;

function TMatCoder.GetCodeIndex(Index: Integer): Integer;
begin
  Result := FCodeIndex[Index];
end;

procedure TMatCoder.InitCodeTable;
var CharItem: PMatCharTableItem;
    i, k: Integer;
begin
  FCodesPerTable := FModeler.CharsPerTable;

  SetLength(FCodeTable, FCodesPerTable);
  k := 0;
  for i := 0 to CHARTABLE_SIZE-1 do
  begin
    CharItem := FModeler.CharTable[FModeler.CharIndex[i]];
    if CharItem.Counter <> 0 then
    begin
      FCodeTable[k].CharItem := CharItem;
      FCodeTable[k].CodeBits := 0;
      Inc(k);
    end;
  end;
end;

procedure TMatCoder.CalcCodeTable;
var i: Integer;
begin
  for i := 0 to FCodesPerTable-1 do
  with FCodeTable[i] do
  begin
    SetLength(Code, CodeBits);
    Redundance := CalcRelativeRedundance(CharItem.Entropy, CodeBits);
  end;
end;

procedure TMatCoder.SortCodeTable;
var i, j, x: Integer;
begin
  SetLength(FCodeIndex, FCodesPerTable);
  for i := 0 to FCodesPerTable-1 do FCodeIndex[i] := i;
  for i := 0 to FCodesPerTable-1 do
    for j := i + 1 to FCodesPerTable-1 do
      if FCodeTable[FCodeIndex[i]].CodeBits >=
         FCodeTable[FCodeIndex[j]].CodeBits then
      begin
        x := FCodeIndex[i];
        FCodeIndex[i] := FCodeIndex[j];
        FCodeIndex[j] := x;
      end;
end;

procedure TMatCoder.Execute;
begin
  InitCodeTable;
  BuildCodeTable;
  CalcCodeTable;
  SortCodeTable;
end;

function TMatCoder.GetAvgCodeLength: Single;
var i: Integer;
begin
  Result := 0;
  for i := 0 to FCodesPerTable-1 do
    Result := Result + FCodeTable[i].CharItem.Probability * FCodeTable[i].CodeBits;
end;

function TMatCoder.GetRatioEffective: Single;
var r: Single;
begin
  r := GetAvgCodeLength;
  if (FCodesPerTable <> 0) and (r <> 0) then
    Result := FModeler.EntropyPerChar / (r * log2(FCodesPerTable))
  else
    Result := 0;
end;

function TMatCoder.GetRatioCompression: Single;
var r: Single;
begin
  r := GetAvgCodeLength;
  if (FCodesPerTable <> 0) and (r <> 0) then
    Result := FModeler.FBitsPerChar / (r * log2(FCodesPerTable))
  else
    Result := 0;
end;

function TMatCoder.GetBitsPerText: Integer;
var i: Integer;
begin
  Result := 0;
  for i := 1 to FModeler.CharsPerText do
    Inc(Result, CodeTableByValue[Ord(FModeler.Text[i])].CodeBits);
end;

function TMatCoder.GetCodeTableByValue(Value: Byte): PMatCodeTableItem;
var k: Integer;
begin
  k := 0;
  while (FCodeTable[k].CharItem.Value <> Value) do Inc(k);
  Result := @FCodeTable[k];
end;

{ TMatCoderShannonFano }

procedure TMatCoderShannonFano.BuildCodeTable;

procedure DivGroup(i1, i2: Integer);

procedure FillGroup(i1, i2: Integer; Value: AnsiChar);
var i: Integer;
begin
  for i := i1 to i2 do
  with FCodeTable[i] do
  begin
    Inc(CodeBits);
    Code[CodeBits] := Value;
  end;
end;

var s, c, oldc, g1, g2: Single;
    i, k2: Integer;
begin
  if i1 < i2 then
  begin
    s := 0;
    for i := i1 to i2 do s := s + FCodeTable[i].CharItem.Probability;

    k2 := i1;
    g1 := 0;
    g2 := s;
    c := g2 - g1;
    repeat
      g1 := g1 + FCodeTable[k2].CharItem.Probability;
      g2 := g2 - FCodeTable[k2].CharItem.Probability;
      oldc := c;
      c := abs(g2 - g1);
      Inc(k2);
    until (c >= oldc) or (k2 = i2);
    if c > oldc then Dec(k2);

    FillGroup(i1, k2-1, '0');
    FillGroup(k2, i2, '1');

    DivGroup(i1, k2-1);
    DivGroup(k2, i2);
  end;
end;

begin
  DivGroup(0, FCodesPerTable-1);
end;

{ TMatCoderHuffman }

type
  PMatNode = ^TMatNode;
  TMatNode = record
    Probability: Single;
    Parent: PMatNode;
    Child0: PMatNode;
    Child1: PMatNode;
  end;

procedure TMatCoderHuffman.BuildCodeTable;
var Node: array of TMatNode;
    i, k: Integer;
    mn0, mn1, cn: PMatNode;
begin
  SetLength(Node, FCodesPerTable);
  for i := 0 to FCodesPerTable-1 do
  with Node[i] do
  begin
    Probability := FCodeTable[i].CharItem.Probability;
    Parent := nil;
    Child0 := nil;
    Child1 := nil;
  end;

  repeat
    mn0 := nil;
    for i := 0 to FCodesPerTable-1 do
    begin
      cn := @Node[i];
      while cn.Parent <> nil do cn := cn.Parent;
      if (mn0 = nil) or (mn0.Probability > cn.Probability) then mn0 := cn;
    end;

    mn1 := nil;
    for i := 0 to FCodesPerTable-1 do
    begin
      cn := @Node[i];
      while cn.Parent <> nil do cn := cn.Parent;
      if ((mn1 = nil) or (mn1.Probability > cn.Probability)) and (cn <> mn0) then mn1 := cn;
    end;

    if mn1 <> nil then
    begin
      New(cn);
      cn.Probability := mn0.Probability + mn1.Probability;
      cn.Parent := nil;
      cn.Child0 := mn0;
      cn.Child1 := mn1;
      mn0.Parent := cn;
      mn1.Parent := cn;
    end;
  until mn1 = nil;

  for i := 0 to FCodesPerTable-1 do
  begin
    k := 0;
    cn := @Node[i];
    while cn.Parent <> nil do
    begin
      Inc(k);
      if cn = cn.Parent.Child0 then
        FCodeTable[i].Code[k] := '0'
      else
        FCodeTable[i].Code[k] := '1';  
      cn := cn.Parent;
    end;
    FCodeTable[i].CodeBits := k;
  end;
 
  SetLength(Node, 0);
end;

end.
