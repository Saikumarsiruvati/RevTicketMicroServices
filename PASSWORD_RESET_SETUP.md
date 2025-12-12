# Password Reset Email Setup - FIXED ✅

## What Was Changed

1. **Enabled Email Sending**: Changed `email.enabled=true` in auth-service configuration
2. **Removed Console Fallback**: Email service now throws errors if email fails instead of printing to console
3. **Added User Verification**: System verifies user exists before sending reset email
4. **Better Error Messages**: Clear error messages when email fails

## Email Configuration

The system is configured to use Gmail SMTP:
- **Host**: smtp.gmail.com
- **Port**: 587
- **Email**: revticketsa952@gmail.com
- **App Password**: oaaxelposrurgbax (already configured)

## How to Test

### 1. Rebuild the Auth Service
```bash
cd microservices-backend\auth-service
mvn clean package
```

### 2. Restart the Auth Service
If running with Docker:
```bash
docker-compose restart auth-service
```

If running locally:
```bash
cd auth-service
mvn spring-boot:run
```

### 3. Test Password Reset Flow

1. Go to: http://localhost:4200/forgot-password
2. Enter a registered email address
3. Click "Send Reset Link"
4. Check the email inbox for the reset link
5. Click the link in the email
6. Enter new password and confirm
7. Login with new password

## Expected Behavior

### Success Case:
- User enters valid email
- Message: "Password reset link has been sent to your email address"
- Email arrives within 1-2 minutes
- Email contains clickable reset link
- Link redirects to reset password page with token

### Error Cases:
- **User not found**: "User not found with email: xxx@xxx.com"
- **Email service fails**: "Failed to send password reset email. Please check email configuration."

## Troubleshooting

### If Email Doesn't Arrive:

1. **Check Spam/Junk Folder**: Gmail might filter it
2. **Verify Email Credentials**: Make sure the app password is valid
3. **Check Auth Service Logs**: Look for email sending confirmation
   ```
   ✅ Password reset email sent successfully to: user@example.com
   ```
4. **Test Gmail SMTP**: The credentials are already configured and should work

### If You See Console Output Instead:
- Make sure you rebuilt the service after changes
- Verify `email.enabled=true` in application.properties
- Restart the auth-service container/process

## Email Template

The reset email will look like this:

```
Subject: RevTickets - Password Reset Request

Hello,

You have requested to reset your password for your RevTickets account.

Please click the link below to reset your password:
http://localhost:4200/reset-password?token=<UUID>

This link will expire in 1 hour.

If you did not request this password reset, please ignore this email.

Best regards,
RevTickets Team
```

## Security Notes

- Reset tokens are stored in memory (will be lost on service restart)
- Tokens are single-use (deleted after successful reset)
- For production, consider:
  - Storing tokens in database with expiration time
  - Adding rate limiting to prevent abuse
  - Using Redis for token storage
  - Implementing token expiration (currently no time limit)

## Next Steps for Production

1. **Add Token Expiration**: Store tokens with timestamp and validate age
2. **Use Database Storage**: Store tokens in MySQL/Redis instead of memory
3. **Add Rate Limiting**: Prevent spam/abuse of forgot password endpoint
4. **Use Environment Variables**: Don't hardcode email credentials
5. **Custom Email Domain**: Use your own domain instead of Gmail
6. **HTML Email Templates**: Create better-looking HTML emails

## Support

If you encounter any issues:
1. Check auth-service logs for errors
2. Verify email configuration in application.properties
3. Test with a real email address you have access to
4. Check if Gmail is blocking the app password
