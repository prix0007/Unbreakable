defmodule Unbreakable.Repo do
  use Ecto.Repo,
    otp_app: :unbreakable,
    adapter: Ecto.Adapters.Postgres
end
