# Genereaza sursele ANTLR si compileaza parserul NeoCrypt (GD2)
$ErrorActionPreference = "Stop"
$root = $PSScriptRoot
$antlrJar = Join-Path $root "lib\antlr-4.13.2-complete.jar"
$grammarDir = Join-Path $root "grammar"
$genDir = Join-Path $root "src\neocryptproject"
$testsDir = Join-Path $root "tests"
$buildDir = Join-Path $root "build\classes"

if (-not (Test-Path $antlrJar)) {
    Write-Error "Lipseste $antlrJar. Ruleaza din nou descarcarea ANTLR."
}

New-Item -ItemType Directory -Force -Path $genDir, $buildDir | Out-Null

java -jar $antlrJar -visitor -no-listener -package neocryptproject `
    -o $genDir `
    (Join-Path $grammarDir "NeoCryptLexer.g4") `
    (Join-Path $grammarDir "NeoCryptParser.g4")

$srcFiles = @(
    (Join-Path $genDir "NeoCryptLexer.java"),
    (Join-Path $genDir "NeoCryptParser.java"),
    (Join-Path $genDir "NeoCryptParserBaseVisitor.java"),
    (Join-Path $genDir "NeoCryptParserVisitor.java"),
    (Join-Path $genDir "NeoCryptParserMain.java"),
    (Join-Path $genDir "NeoCryptLexerManual.java")
) | Where-Object { Test-Path $_ }
$cp = "$antlrJar;$buildDir"

javac -encoding UTF-8 -cp $antlrJar -d $buildDir @srcFiles
if ($LASTEXITCODE -ne 0) { exit $LASTEXITCODE }

Write-Host "Build reusit. Clase in: $buildDir"
Write-Host ""
Write-Host "Testare pe fisierele complexe:"
$tests = @(
    "part4_test1.txt",
    "part4_test2.txt",
    "part4_test3.txt",
    "part5_test4.txt",
    "part5_test5.txt",
    "part5_invalid_syntax.txt"
) | ForEach-Object { Join-Path $testsDir $_ }

java -cp "$cp" neocryptproject.NeoCryptParserMain @tests
