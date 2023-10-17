import Mix.Config

config :kata_example, KataBirthday,
  adapter: Swoosh.Adapters.SMTP,
  relay: "smtp.avengers.com",
  username: "tonystark",
  password: "ilovepepperpotts",
  ssl: true,
  tls: :always,
  auth: :always,
  port: 1025,
  # dkim: [
  #  s: "default", d: "domain.com",
  #  private_key: {:pem_plain, File.read!("priv/keys/domain.private")}
  # ],
  retries: 2,
  no_mx_lookups: false
