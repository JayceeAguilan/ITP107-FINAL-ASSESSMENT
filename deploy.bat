@echo off
echo ==========================================
echo      Deploying to GitHub Pages
echo ==========================================

echo.
echo [1/2] Building Flutter Web App...
call flutter build web --base-href "/ITP107-FINAL-ASSESSMENT/" --release
if %errorlevel% neq 0 (
    echo Build failed!
    pause
    exit /b %errorlevel%
)

echo.
echo [2/2] Pushing to GitHub...
cd build\web
git init
git add .
git commit -m "Deploy update"
git branch -M main
git remote add origin https://github.com/JayceeAguilan/ITP107-FINAL-ASSESSMENT.git
git push -u -f origin main:gh-pages

echo.
echo ==========================================
echo      Deployment Complete!
echo ==========================================
pause
