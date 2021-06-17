defmodule Unbreakable.Repo.Migrations.CreateStreakView do
  use Ecto.Migration

  def up do
    execute """
      CREATE VIEW streaks AS
      WITH start_streak AS (
        SELECT
          statuses.date,
          statuses.goal_id,
          CASE WHEN statuses.date - LAG(statuses.date, 1) OVER (PARTITION BY statuses.goal_id ORDER BY statuses.date) > 1
          THEN 1
          ELSE 0
        END streak_start
        FROM statuses
        WHERE statuses.is_complete = 't'
      ),
      streak_groups AS (
        SELECT
          date,
          goal_id,
          SUM(streak_start) over (PARTITION BY goal_id ORDER BY date) streak
        FROM start_streak
      )
      SELECT
        goal_id,
        MIN(date) AS start,
        MAX(date) AS end,
        MAX(date) - MIN(date) + 1 AS length
      FROM streak_groups
      GROUP By goal_id, streak;
    """
  end

  def down do
    execute "DROP VIEW streaks;"
  end
end
