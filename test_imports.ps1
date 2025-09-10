# PowerShell script to test library imports
Write-Host "Активация виртуальной среды..."
Set-Location "c:\BackGround_removal_imgs-main\AiRemovingBackground"
.\bgremover_env\Scripts\Activate.ps1

Write-Host "Проверка версии Python..."
python --version

Write-Host "Запуск теста импорта библиотек..."
python test_imports.py

Write-Host "Тест завершен."