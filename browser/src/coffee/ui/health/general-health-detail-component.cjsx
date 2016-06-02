format = d3.format '.3s'
percFormat = d3.format ',.2%'

GenHealthDetailComponent = React.createClass 
  render: ->
    <div>
      <table className="table table-condensed table-hover table-striped mb-oxygen">
        <tbody>
          <tr>
            <td>{ if @props.activeCategory is 'default' then 'Geography:' else @props.activeCategory + ':'}</td>
            <td><strong>{ if @props.activeValue is 'default' then 'England \& Wales' else @props.activeValue }</strong></td>
          </tr>
          {###<tr>
            <td>Ethnicity:</td> 
            <td><strong>{ if @props.mouseOverData.key? then @props.mouseOverData.key else 'All' }</strong></td>
          </tr>###}
        </tbody>
      </table>
      <table className="table table-condensed table-hover table-striped mb-oxygen">
        <thead>
            <tr>
              <th>Age group</th>
              <th>Total population</th>
              <th>Total bad health</th>
              <th>% bad health</th>
            </tr>
        </thead>
        <tbody>
          <tr>
            <td>Age 0 to 15:</td>
            <td><strong>{ 
              if @props.data.total_item? then format @props.data.total_item.total_age_detail[0].values.total_population
            }</strong></td>
            <td><strong>{ 
              if @props.data.total_item? then format @props.data.total_item.total_age_detail[0].values.bad_health
            }</strong></td>
            <td><strong>{ 
              if @props.data.total_item? then percFormat (@props.data.total_item.total_age_detail[0].values.bad_health / @props.data.total_item.total_age_detail[0].values.total_population)
            }</strong></td>
          </tr>
          <tr>   
            <td>Age 16 to 24:</td>
            <td><strong>{ 
              if @props.data.total_item? then format @props.data.total_item.total_age_detail[1].values.total_population
            }</strong></td>
            <td><strong>{ 
              if @props.data.total_item? then format @props.data.total_item.total_age_detail[1].values.bad_health
            }</strong></td>
            <td><strong>{ 
              if @props.data.total_item? then percFormat (@props.data.total_item.total_age_detail[1].values.bad_health / @props.data.total_item.total_age_detail[1].values.total_population)
            }</strong></td>
          </tr>
          <tr>   
            <td>Age 25 to 34:</td>
            <td><strong>{ 
              if @props.data.total_item? then format @props.data.total_item.total_age_detail[2].values.total_population
            }</strong></td>
            <td><strong>{ 
              if @props.data.total_item? then format @props.data.total_item.total_age_detail[2].values.bad_health
            }</strong></td>
            <td><strong>{ 
              if @props.data.total_item? then percFormat (@props.data.total_item.total_age_detail[2].values.bad_health / @props.data.total_item.total_age_detail[2].values.total_population)
            }</strong></td>
          </tr>
          <tr>   
            <td>Age 35 to 49:</td>
            <td><strong>{ 
              if @props.data.total_item? then format @props.data.total_item.total_age_detail[3].values.total_population
            }</strong></td>
            <td><strong>{ 
              if @props.data.total_item? then format @props.data.total_item.total_age_detail[3].values.bad_health
            }</strong></td>
            <td><strong>{ 
              if @props.data.total_item? then percFormat (@props.data.total_item.total_age_detail[3].values.bad_health / @props.data.total_item.total_age_detail[3].values.total_population)
            }</strong></td>
          </tr>
          <tr>   
            <td>Age 50 to 64:</td>
            <td><strong>{ 
              if @props.data.total_item? then format @props.data.total_item.total_age_detail[4].values.total_population
            }</strong></td>
            <td><strong>{ 
              if @props.data.total_item? then format @props.data.total_item.total_age_detail[4].values.bad_health
            }</strong></td>
            <td><strong>{ 
              if @props.data.total_item? then percFormat (@props.data.total_item.total_age_detail[4].values.bad_health / @props.data.total_item.total_age_detail[4].values.total_population)
            }</strong></td>        
          </tr>
          <tr>   
            <td>Age 65 and over:</td>
            <td><strong>{ 
              if @props.data.total_item? then format @props.data.total_item.total_age_detail[5].values.total_population
            }</strong></td>
            <td><strong>{ 
              if @props.data.total_item? then format @props.data.total_item.total_age_detail[5].values.bad_health
            }</strong></td>
            <td><strong>{ 
              if @props.data.total_item? then percFormat (@props.data.total_item.total_age_detail[5].values.bad_health / @props.data.total_item.total_age_detail[5].values.total_population)
            }</strong></td>        
          </tr>
          <tr>
            <td>Total population:</td> 
            <td><strong>{ if @props.data.total_item? then format @props.data.total_item.population else '' }</strong></td>
            <td><strong>{ if @props.data.total_item? then format @props.data.total_item.number_bad_health else '' }</strong></td> 
            <td><strong>{ if @props.data.total_item? then percFormat @props.data.total_item.percent_bad_health else '' }</strong></td>   
          </tr>
        </tbody>
      </table>
    </div>

module.exports = GenHealthDetailComponent