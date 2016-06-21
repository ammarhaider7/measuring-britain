# drawDonut = require './d3/econ-activity-country-donut.js'

EconByCountryDetailComponent = React.createClass

  getAppropriateHeight: ->

    window_height = $(window).height()
    if window_height > 700
      return 320
    else
      return $(window).height() - 320

  sum: (arr) ->

    return d3.sum arr, (d) ->
      return d.value

  format: (val) ->
    return d3.format('.2s')(val)

  percFormat: (val) ->
    return d3.format(',.2%')(val)

  render: ->
    <div className="mb-oxygen">
      { if @props.isFetching is yes and @props.isDefault is yes
          <img src="/images/mb_ajax_loader.gif" className="mb-spinner"/>
      }
      <table className="table table-condensed table-striped mb-oxygen">
        <tbody>
          <tr>
            <td>{ if @props.activeCategory is 'default' then 'Geography:' else @props.activeCategory + ':'}</td>
            <td><strong>{ if @props.activeValue is 'default' then 'England \& Wales' else @props.activeValue }</strong></td>
          </tr>
        </tbody>
      </table>
      <table className="table table-condensed table-hover table-striped mb-oxygen">
        <thead>
          <tr>
            <td><strong>Employment Status</strong></td>
            <td><strong>No.</strong></td>
            <td><strong>%</strong></td>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>Employee:</td> 
            <td><strong>{ if @props.data.total_item_percs? then @format @props.data.total_item_percs[0].value else '' }</strong></td>
            <td><strong>{ if @props.data.total_item_percs? then @percFormat @props.data.total_item_percs[0].perc else '' }</strong></td>
          </tr>
          <tr>
            <td>Self employed:</td> 
            <td><strong>{ if @props.data.total_item_percs? then @format @props.data.total_item_percs[1].value else '' }</strong></td>
            <td><strong>{ if @props.data.total_item_percs? then @percFormat @props.data.total_item_percs[1].perc else '' }</strong></td>
          </tr>
          <tr>
            <td>Unemployed:</td> 
            <td><strong>{ if @props.data.total_item_percs? then @format @props.data.total_item_percs[2].value else '' }</strong></td>
            <td><strong>{ if @props.data.total_item_percs? then @percFormat @props.data.total_item_percs[2].perc else '' }</strong></td>
          </tr>
          <tr>
            <td>Retired:</td> 
            <td><strong>{ if @props.data.total_item_percs? then @format @props.data.total_item_percs[3].value else '' }</strong></td>
            <td><strong>{ if @props.data.total_item_percs? then @percFormat @props.data.total_item_percs[3].perc else '' }</strong></td>
          </tr>
          <tr>
            <td>Student:</td> 
            <td><strong>{ if @props.data.total_item_percs? then @format @props.data.total_item_percs[4].value else '' }</strong></td>
            <td><strong>{ if @props.data.total_item_percs? then @percFormat @props.data.total_item_percs[4].perc else '' }</strong></td>
          </tr>
          <tr>
            <td>Looking after home/family:</td> 
            <td><strong>{ if @props.data.total_item_percs? then @format @props.data.total_item_percs[5].value else '' }</strong></td>
            <td><strong>{ if @props.data.total_item_percs? then @percFormat @props.data.total_item_percs[5].perc else '' }</strong></td>
          </tr>
          <tr>
            <td>Long-term sick/disabled:</td> 
            <td><strong>{ if @props.data.total_item_percs? then @format @props.data.total_item_percs[6].value else '' }</strong></td>
            <td><strong>{ if @props.data.total_item_percs? then @percFormat @props.data.total_item_percs[6].perc else '' }</strong></td>
          </tr>
          <tr>
            <td>Other:</td> 
            <td><strong>{ if @props.data.total_item_percs? then @format @props.data.total_item_percs[7].value else '' }</strong></td>
            <td><strong>{ if @props.data.total_item_percs? then @percFormat @props.data.total_item_percs[7].perc else '' }</strong></td>
          </tr>
        </tbody>
      </table>
    </div>

module.exports = EconByCountryDetailComponent