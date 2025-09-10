@echo off
chcp 65001 > nul
title Установка приложения для удаления фона
color 0A

echo ==========================================================
echo    Установка приложения для удаления фона с помощью ИИ    
echo ==========================================================
echo.

REM Проверяем установку Python
echo [1/5] Проверка установки Python...
echo Python необходим для работы приложения. Проверяем его наличие в системе.
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Ошибка: Python не установлен или не добавлен в переменные среды PATH.
    echo    Пожалуйста, установите Python 3.6 или выше и добавьте его в PATH.
    echo    Скачайте с: https://www.python.org/downloads/
    echo    При установке обязательно поставьте галочку "Add Python to PATH".
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('python --version') do set PYTHON_VERSION=%%i
echo ✅ Найден %PYTHON_VERSION%
echo.

REM Удаляем старую виртуальную среду, если она существует
echo [2/5] Подготовка виртуальной среды...
echo Проверяем наличие старой виртуальной среды...
if exist "bgremover_env" (
    echo Обнаружена старая виртуальная среда. Удаляем...
    rmdir /s /q "bgremover_env" >nul 2>&1
    if %errorlevel% neq 0 (
        echo ⚠ Предупреждение: Не удалось полностью удалить старую виртуальную среду.
        echo    Это может привести к конфликтам. Продолжаем установку...
    ) else (
        echo ✅ Старая виртуальная среда удалена
    )
)
echo.

REM Создаем виртуальную среду
echo [3/5] Создание новой виртуальной среды...
echo Создаем изолированное окружение для установки библиотек приложения.
python -m venv bgremover_env >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Ошибка: Не удалось создать виртуальную среду.
    echo    Попробуйте закрыть другие программы и повторить попытку.
    pause
    exit /b 1
)
echo ✅ Виртуальная среда создана в папке bgremover_env
echo.

REM Активируем виртуальную среду
echo [4/5] Активация виртуальной среды...
echo Активируем созданное окружение для установки библиотек.
call bgremover_env\Scripts\activate.bat >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Ошибка: Не удалось активировать виртуальную среду.
    echo    Файл активации не найден или поврежден.
    pause
    exit /b 1
)
echo ✅ Виртуальная среда активирована
echo.

REM Обновляем pip
echo [5/5] Обновление pip...
echo Pip - инструмент для установки Python библиотек. Обновляем до последней версии.
python -m pip install --upgrade pip >nul 2>&1
if %errorlevel% neq 0 (
    echo ❌ Ошибка: Не удалось обновить pip.
    echo    Проверьте подключение к интернету и попробуйте снова.
    pause
    exit /b 1
)
echo ✅ Pip успешно обновлен
echo.

REM Устанавливаем зависимости
echo Установка необходимых библиотек...
echo Устанавливаем специальные библиотеки для удаления фона:
echo  - rembg: основная библиотека для удаления фона с помощью ИИ
echo  - onnxruntime: для работы с нейронными сетями
echo  - pillow: для обработки изображений
echo Процесс может занять несколько минут, пожалуйста, подождите...
echo.
echo Установка rembg...
pip install rembg > install_log.txt 2>&1
if %errorlevel% neq 0 (
    echo ❌ Ошибка при установке rembg. Подробности в install_log.txt
    echo    Убедитесь, что у вас есть подключение к интернету.
    type install_log.txt
    pause
    exit /b 1
)
echo ✅ rembg установлен
echo.
echo Установка onnxruntime...
pip install onnxruntime >> install_log.txt 2>&1
if %errorlevel% neq 0 (
    echo ❌ Ошибка при установке onnxruntime. Подробности в install_log.txt
    echo    Убедитесь, что у вас есть подключение к интернету.
    type install_log.txt
    pause
    exit /b 1
)
echo ✅ onnxruntime установлен
echo.
echo Установка Pillow...
pip install Pillow >> install_log.txt 2>&1
if %errorlevel% neq 0 (
    echo ❌ Ошибка при установке Pillow. Подробности в install_log.txt
    echo    Убедитесь, что у вас есть подключение к интернету.
    type install_log.txt
    pause
    exit /b 1
)
echo ✅ Pillow установлен
echo.
del install_log.txt >nul 2>&1

REM Проверяем установку
echo Проверка установленных библиотек...
echo Проверяем, что все библиотеки установлены правильно и могут быть импортированы.
echo Проверка rembg...
python -c "import rembg" > verification_log.txt 2>&1
if %errorlevel% neq 0 (
    echo ❌ Ошибка при импорте rembg:
    type verification_log.txt
    echo.
    echo Попробуйте перезапустить установку.
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
    echo Попробуйте перезапустить установку.
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
    echo Попробуйте перезапустить установку.
    del verification_log.txt >nul 2>&1
    pause
    exit /b 1
)
echo ✅ PIL успешно импортирован
del verification_log.txt >nul 2>&1
echo ✅ Проверка завершена успешно
echo.

echo ==========================================================
echo    Установка завершена успешно!                            
echo ==========================================================
echo.
echo Виртуальная среда создана в папке bgremover_env
echo Все необходимые библиотеки установлены
echo.
echo Для запуска приложения используйте run.bat
echo.
pause