@echo off
chcp 65001 > nul
echo Активация виртуальной среды...
call bgremover_env\Scripts\activate.bat
if %errorlevel% neq 0 (
    echo ❌ Ошибка активации виртуальной среды
    pause
    exit /b 1
)
echo ✅ Виртуальная среда активирована
echo.
echo Запуск теста импорта библиотек...
python test_imports.py
echo.
echo Тест завершен.
pause