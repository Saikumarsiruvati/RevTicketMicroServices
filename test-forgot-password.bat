@echo off
echo Testing Forgot Password Endpoint...
echo.

curl -X POST http://localhost:8090/api/auth/forgot-password ^
  -H "Content-Type: application/json" ^
  -d "{\"email\":\"test@example.com\"}"

echo.
echo.
echo Check the auth-service logs for the reset link:
echo docker logs auth-service --tail 30
