NeoCrypt v2 — Grand Devoir 2
=============================

Rulare rapida:
  powershell -ExecutionPolicy Bypass -File .\build-parser.ps1

Test individual:
  java -cp "lib\antlr-4.13.2-complete.jar;build\classes" ^
    neocryptproject.NeoCryptParserMain tests\part4_test1.txt

Lexer GD1 (referinta, regex manual):
  javac -cp build\classes -d build\classes src\neocryptproject\NeoCryptLexerManual.java
  java -cp build\classes neocryptproject.NeoCryptLexerManual test4.txt

Structuri noi fata de GD1:
  SCOPE, GUARD/UNLESS, SELECT/CASE/DEFAULT, SCAN/UNTIL/DO,
  CHAIN/LINK, LET/IN, expresii LEVEL/MIN/MAX, IF/ELSE, BEGIN/END, REPEAT.

Raport complet: ..\RAPORT_GRAND_DEVOIR_2_NEOCRYPT.txt
