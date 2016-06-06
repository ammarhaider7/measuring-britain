format = d3.format '.3s'
percFormat = d3.format ',.2%'

GenHealthDetailComponent = React.createClass 

  onToggleSex: (e) ->

    el = e.target
    sexVal = el.getAttribute 'data-value'
    sexLabel = el.innerHTML
    # dispatch toggle sex action
    @props.onToggleSex sexLabel, sexVal
    # Fetch new data
    @props.fetchGenHealthData {
      isDefault: no
      category: @props._category
      value: @props._value
      sex: {
        label: sexLabel
        value: sexVal
      }
    }

  highlight: (ethnicity) ->

    @props.onHighlightLine ethnicity

  unHighlight: (ethnicity, index) ->

    @props.onUnHighlightLine ethnicity, index

  handleChange: (event) ->
    
    $el = $(event.target)
    value = event.target.value
    if $el.parent().hasClass('highlight') is yes
      $el.parent().removeClass 'highlight'
      arr = @props._highlights
      index = arr.indexOf value
      @unHighlight value, index
    else 
      $el.parent().addClass 'highlight'
      @highlight value

  trimEthnicity: (ethnicity_string) ->

      if ethnicity_string.indexOf('Gypsy') isnt -1
        return trimmedStr = 'Gypsy'
      else if ethnicity_string.indexOf('English') isnt -1
        return trimmedStr = 'British'
      else if ethnicity_string.indexOf('Any other') isnt -1
        return trimmedStr = 'Any other'
      else if ethnicity_string.indexOf('Arab') isnt -1
        return trimmedStr = 'Arab'
      else if ethnicity_string.indexOf('and') isnt -1
        str = ethnicity_string.replace ' and ', '/'
        return trimmedStr = str.substr(str.indexOf(':') + 2, str.length)
      else if ethnicity_string.indexOf('Other') isnt -1
        return trimmedStr = 'Other'
      else
        str = ethnicity_string
        return trimmedStr = str.substr(str.indexOf(':') + 2, str.length)

  render: ->

    <div>
      <div className="clearfix">
        <span className="mb-oxygen mb-gender-toggles-label">Choose gender: </span>
        <div className="btn-group mb-gender-toggles mb-oxygen mb-right" role="group" aria-label="...">
          <button type="button" 
            className={ if @props.sex is 'All' then "btn btn-default active" else "btn btn-default" }
            data-value={ 0 }
            onClick={ @onToggleSex }
          >All
          </button>
          <button type="button" 
            className={ if @props.sex is 'Female' then "btn btn-default active" else "btn btn-default" }
            data-value={ 2 }
            onClick={ @onToggleSex }
          >Female</button>
          <button type="button" 
            className={ if @props.sex is 'Male' then "btn btn-default active" else "btn btn-default" }
            data-value={ 1 }
            onClick={ @onToggleSex }
          >Male</button>
        </div>
      </div>
      {###
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
      </table>###}
      <div className="mb-oxygen">
        <h4><strong>Highlight ethnicities</strong></h4>
        <div className="">
          <img src="./images/mb_ajax_loader.gif" 
            className={ 
              if @props.isFetching is yes and @props.isDefault is yes then 'mb-spinner' else 'hide' 
            }
          />
        {
          if @props.data.ethnicities?
            for group, i in @props.data.ethnicities_grouped
              <div key={i} className="col-sm-4 mt-small ethnic-checkboxes-column">
                {
                  for ethnicity, j in group
                    if typeof ethnicity is 'object'
                      <div key={ethnicity.title}>
                        <label className="ethnic_title"><strong>{ ethnicity.title }</strong></label>
                      </div>
                    else
                      <div className="checkbox" key={ethnicity}>
                        <label className="checkbox-zone">
                          <input 
                            type="checkbox" 
                            value={ ethnicity } 
                            onChange={ @handleChange }
                          />
                          { @trimEthnicity ethnicity }
                        </label>
                      </div>
                }
              </div>
        }
        </div>
      </div>
    </div>

module.exports = GenHealthDetailComponent