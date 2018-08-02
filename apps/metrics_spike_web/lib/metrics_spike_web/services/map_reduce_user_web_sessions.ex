defmodule MetricsSpikeWeb.MapReduceUserWebSessions do
  @time_period -30

  def call(table, column_name) do
    start_date = Timex.now |> Timex.shift(days: @time_period) |> DateTime.to_string

    MetricsDynamoDB.MapReduceScan.call(table, column_name, start_date)
  end
end
