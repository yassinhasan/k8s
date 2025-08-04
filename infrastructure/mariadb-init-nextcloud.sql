-- Nextcloud Database Initialization Script
-- This script creates the nextcloud database and grants permissions to the hasan user

-- Create the nextcloud database if it doesn't exist
CREATE DATABASE IF NOT EXISTS nextcloud;

-- Grant all privileges on nextcloud database to hasan user
GRANT ALL PRIVILEGES ON nextcloud.* TO 'hasan'@'%';

-- Flush privileges to apply changes
FLUSH PRIVILEGES;

-- Show confirmation
SELECT 'Nextcloud database setup completed successfully' AS status; 