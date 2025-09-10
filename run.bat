@echo off
chcp 65001 > nul
title Запуск приложения для удаления фона
echo ==========================================================
echo    Запуск приложения для удаления фона с помощью ИИ    
echo ==========================================================
echo.

REM Проверяем, существует ли виртуальная среда
echo Проверка наличия виртуальной среды...
echo Виртуальная среда содержит все необходимые библиотеки для работы приложения.
if not exist "bgremover_env\Scripts\activate.bat" (
    echo ❌ Ошибка: Виртуальная среда не найдена.
    echo    Пожалуйста, сначала запустите install.bat для установки.
    echo    Это необходимо для правильной работы приложения.
    echo.
    echo    Порядок действий:
    echo    1. Дважды щелкните setup_and_run.bat ИЛИ
    echo    2. Дважды щелкните install.bat
    echo    3. После установки дважды щелкните run.bat
    pause
    exit /b 1
)
echo ✅ Найдена виртуальная среда в папке bgremover_env
echo.

REM Активируем виртуальную среду
echo Активация виртуальной среды...
echo Активируем изолированное окружение с установленными библиотеками.
call bgremover_env\Scripts\activate.bat
if %errorlevel% neq 0 (
    echo ❌ Ошибка: Не удалось активировать виртуальную среду.
    echo    Файл активации поврежден или отсутствует.
    echo    Попробуйте перезапустить install.bat.
    pause
    exit /b 1
)
echo ✅ Виртуальная среда успешно активирована
echo.

REM Проверяем наличие необходимых библиотек
echo Проверка наличия необходимых библиотек...
echo Проверка rembg...
python -c "import rembg" > verification_log.txt 2>&1
if %errorlevel% neq 0 (
    echo ❌ Ошибка при импорте rembg:
    type verification_log.txt
    echo.
    echo Решения:
    echo 1. Запустите setup_and_run.bat для полной переустановки
    echo 2. Или запустите install.bat для установки библиотек
    del verification_log.txt >nul 2>&1
    pause
    exit /b 1
)
echo ✅ rembg успешно импортирован
echo Проверка onnxruntime...
python -c "import onnxruntime" >> verification_log.txt 2>&1
if %errorlevel% neq 0 (
    echo ❌ Ошибка при импорте onnxruntime:
    type verification_log.txt
    echo.
    echo Решения:
    echo 1. Запустите setup_and_run.bat для полной переустановки
    echo 2. Или запустите install.bat для установки библиотек
    del verification_log.txt >nul 2>&1
    pause
    exit /b 1
)
echo ✅ onnxruntime успешно импортирован
echo Проверка PIL...
python -c "import PIL" >> verification_log.txt 2>&1
if %errorlevel% neq 0 (
    echo ❌ Ошибка при импорте PIL:
    type verification_log.txt
    echo.
    echo Решения:
    echo 1. Запустите setup_and_run.bat для полной переустановки
    echo 2. Или запустите install.bat для установки библиотек
    del verification_log.txt >nul 2>&1
    pause
    exit /b 1
)
echo ✅ PIL успешно импортирован
del verification_log.txt >nul 2>&1
echo ✅ Все необходимые библиотеки установлены
echo.

REM Запускаем приложение
echo Запуск основного приложения...
echo Открывается графическое окно приложения.
echo Для удаления фона:
echo  1. Нажмите "Выбрать изображение"
echo  2. Выберите файл с изображением
echo  3. Нажмите "Удалить фон"
echo  4. Сохраните результат
echo.
python main.py
if %errorlevel% neq 0 (
    echo ❌ Ошибка: Не удалось запустить приложение.
    echo    Возможные причины:
    echo     - Файл main.py отсутствует или поврежден
    echo     - Ошибки в коде приложения
    echo     - Проблемы с графической библиотекой tkinter
    echo.
    echo    Решения:
    echo     - Убедитесь, что все файлы проекта на месте
    echo     - Попробуйте перезапустить setup_and_run.bat
    echo     - Проверьте, что Python правильно установлен
    pause
    exit /b 1
)

echo.
echo ==========================================================
echo    Приложение закрыто. Спасибо за использование!    
echo ==========================================================
pause