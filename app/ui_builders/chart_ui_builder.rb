class ChartUIBuilder < BaseUIBuilder
  param_attr :data, default: []
  param_attr :type, default: :vertical_column
  param_attr :title, default: nil
  param_attr :group_by, default: nil
  param_attr :order_by, default: :asc
  param_attr :calculate_method, default: :count
  param_attr :calculate_field, default: nil

  def count
    @params.calculate_method = :count
    @params.calculate_field = nil
  end

  def view_data
    if @params.type == :vertical_column
      if @params.calculate_method == :count
        return single_group_count
      end
    end
    return []
  end

  def single_group_count
    @params.data.group(@params.group_by).count.map do |k,v|
      {
        name: k,
        y: v
      }
    end
  end

  def encoded_data
    Base64.encode64(chart_data.to_json)
  end

  def chart_data
    d = {}
    d[:chart] = {type: "column"}
    d[:title] = {align: "left", text: @params.title}
    d[:accessibility] = {announceNewData: {enabled: true}}
    d[:xAxis] = {type: "category"}
    d[:yAxis] = {title: {text: "Model Count"}}
    d[:legend] = {enabled: false}
    d[:plotOptions] = {series: {borderWidth: 0, pointPadding: 0, groupPadding: 0.01, dataLabels: {enabled: true, format: "{point.y:.0f}"}}}
    d[:series] = [{name: 'Model Count', colorByPoint: true, data: view_data}]
    d
  end


end
