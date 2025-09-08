@echo off
chcp 65001 > nul
echo Запуск приложения для удаления фона...
echo.

REM Проверяем, существует ли виртуальная среда
if not exist "venv\Scripts\activate.bat" (
    echo Ошибка: Виртуальная среда не найдена.
    echo Пожалуйста, сначала запустите install.bat.
    pause
    exit /b 1
)

REM Активируем виртуальную среду
echo Активация виртуальной среды...
call venv\Scripts\activate.bat
if %errorlevel% neq 0 (
    echo Ошибка: Не удалось активировать виртуальную среду.
    pause
    exit /b 1
)

echo Виртуальная среда активирована.
echo.

REM Запускаем приложение
echo Запуск приложения...
python main.py
if %errorlevel% neq 0 (
    echo Ошибка: Не удалось запустить приложение.
    pause
    exit /b 1
)

echo Приложение закрыто.
pause