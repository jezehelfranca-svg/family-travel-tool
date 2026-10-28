@echo off
setlocal enabledelayedexpansion

echo ===================================================
echo   Family Travel Tool: Mode B (GitHub Overwrite ^& Deploy)
echo ===================================================
echo.

echo [1/3] Syncing local files with GitHub origin/main...
git remote set-url origin https://github.com/jezehelfranca-svg/family-travel-tool.git
git fetch origin main
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Failed to fetch latest commits from GitHub! Please check your connection.
    pause
    exit /b %ERRORLEVEL%
)

git reset --hard origin/main
git clean -fd
echo [SUCCESS] Local project files matched 100 percent to GitHub!
echo.

echo [2/3] Validating hosting files...
if not exist "public\index.html" (
    echo [ERROR] public\index.html not found!
    pause
    exit /b 1
)
echo [SUCCESS] Web assets verified.
echo.

echo [3/3] Deploying build to Firebase Hosting...
call npx firebase-tools deploy --only hosting
if %ERRORLEVEL% NEQ 0 (
    echo [ERROR] Firebase deployment failed!
    pause
    exit /b %ERRORLEVEL%
)

echo.
echo ===================================================
echo   [SUCCESS] Deployment complete!
echo   Website: https://family-travel-tool-2026.web.app
echo   Console: https://console.firebase.google.com/project/family-travel-tool-2026/overview
echo ===================================================
echo.
pause

