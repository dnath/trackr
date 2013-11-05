CONFIG = YAML.load_file(Rails.root.join("config/facebook.yml"))[Rails.env]
APP_ID = CONFIG['app_id']
APP_SECRET = CONFIG['app_secret']
SITE_URL = CONFIG['site_url']