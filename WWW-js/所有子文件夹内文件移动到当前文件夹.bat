@echo off
chcp 65001 >nul
echo ========================================
echo  子文件夹文件移动工具
echo ========================================
echo.

:: 显示当前路径
echo 当前文件夹: %cd%
echo.

:: 计数器
set /a fileCount=0
set /a folderCount=0

:: 遍历所有子文件夹
for /d %%D in (*) do (
    set /a folderCount+=1
    echo 正在处理文件夹: %%D
    
    :: 移动该文件夹下的所有文件（包括子子文件夹中的文件，使用/s递归）
    for /f "delims=" %%F in ('dir "%%D\*" /s /b /a-d 2^>nul') do (
        set /a fileCount+=1
        move "%%F" "." >nul 2>&1
        if errorlevel 1 (
            echo   [失败] %%F
        ) else (
            echo   [成功] %%~nF%%~xF
        )
    )
    
    :: 可选：删除空文件夹
    :: rd "%%D" /s /q 2>nul
)

echo.
echo ========================================
echo 处理完成!
echo 扫描文件夹数: %folderCount%
echo 移动文件数: %fileCount%
echo ========================================
pause