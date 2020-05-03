JWTSessions.algorithm = "HS256"
JWTSessions.encryption_key = Rails.application.credentials.secret_jwt_encryption_key

JWTSessions.token_store = :redis, {
  redis_url: ENV.fetch("REDIS_URL", "redis://127.0.0.1:6379")
}
