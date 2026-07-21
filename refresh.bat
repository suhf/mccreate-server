content = """@echo off
chcp 65001 >nul
echo ==================================================
echo       Packwiz 자동 갱신 및 Git 배포 스크립트
echo ==================================================
echo.

echo [1/3] Packwiz 인덱스 갱신 중 (packwiz refresh)...
packwiz refresh
if %errorlevel% neq 0 (
    echo [오류] packwiz refresh에 실패했습니다.
    pause
    exit /b %errorlevel%
)
echo.

echo [2/3] Git 파일 스테이징 및 커밋...
git add .
set /p commit_msg="커밋 메시지를 입력하세요 (엔터 입력 시 'Update modpack' 자동 적용): "
if "%commit_msg%"=="" set commit_msg=Update modpack

git commit -m "%commit_msg%"
echo.

echo [3/3] GitHub로 푸시 중 (git push)...
git push
if %errorlevel% neq 0 (
    echo [오류] git push에 실패했습니다. 원격 저장소 연결 상태를 확인하세요.
    pause
    exit /b %errorlevel%
)
echo.

echo ==================================================
echo  배포 완료! 유저들은 런처 실행 시 자동으로 업데이트를 받습니다.
echo ==================================================
pause
"""

file_path = "update_pack.bat"
with open(file_path, "w", encoding="utf-8") as f:
    f.write(content)

print(f"Created: {file_path}")