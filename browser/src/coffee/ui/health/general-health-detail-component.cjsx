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
        trimmedStr = 'Gypsy'
        return trimmedStr
      else if ethnicity_string.indexOf('English') isnt -1
        trimmedStr = 'British'
        return trimmedStr
      else if ethnicity_string.indexOf('Any other') isnt -1
        trimmedStr = 'Any other'
        return trimmedStr
      else if ethnicity_string.indexOf('Arab') isnt -1
        trimmedStr = 'Arab'
        return trimmedStr
      else if ethnicity_string.indexOf('and') isnt -1
        str = ethnicity_string.replace ' and ', '/'
        trimmedStr = str.substr(str.indexOf(':') + 2, str.length)
        return trimmedStr
      else if ethnicity_string.indexOf('Other') isnt -1
        trimmedStr = 'Other'
        return trimmedStr
      else
        str = ethnicity_string
        trimmedStr = str.substr(str.indexOf(':') + 2, str.length)
        return trimmedStr

  render: ->

    <div>
      <div>
        <span className="mb-oxygen mb-gender-toggles-label">Choose gender: </span>
        <div className="btn-group mb-gender-toggles mb-oxygen mb-right" role="group" aria-label="...">
          <button type="button" 
            className={ if @props.sex is 'All' then "btn btn-default active" else "btn btn-default" }
            data-value={ '0' }
            onClick={ @onToggleSex }
          >All
          </button>
          <button type="button" 
            className={ if @props.sex is 'Female' then "btn btn-default active" else "btn btn-default" }
            data-value={ '2' }
            onClick={ @onToggleSex }
          >Female</button>
          <button type="button" 
            className={ if @props.sex is 'Male' then "btn btn-default active" else "btn btn-default" }
            data-value={ '1' }
            onClick={ @onToggleSex }
          >Male</button>
        </div>
      </div>
      <div className="mb-oxygen clearfix mt-medium">
        <h4 className="mb-left"><strong>Highlight ethnicities</strong></h4>
        <div className="checkbox mb-right">
          <label className="checkbox-zone">
            <input
              type="checkbox" 
              value="Mean" 
              onChange={ @handleChange }
            />
            Show mean
          </label>
        </div>
        <div className="">
          <img src="/images/mb_ajax_loader.gif" 
            className={ 
              if @props.isFetching is yes and @props.isDefault is yes then 'mb-spinner' else 'hide' 
            }
          />
        {### jshint ignore:start ###
        if @props.data.ethnicities?
          for group, i in @props.data.ethnicities_grouped
            <div key={i} className="col-sm-4 mt-small ethnic-checkboxes-column">
            {for ethnicity, j in group
                if typeof ethnicity is 'object'
                  <div key={ethnicity.title}>
                    <label className="ethnic_title"><strong>{ ethnicity.title }</strong></label>
                  </div>
                else
                  <div className="checkbox ethnicity" key={ethnicity}>
                    <label className="checkbox-zone">
                      <input
                        type="checkbox" 
                        value={ ethnicity } 
                        onChange={ @handleChange }
                      />
                      { @trimEthnicity ethnicity }
                    </label>
                  </div>}
            </div>
        ### jshint ignore:end ###}
        </div>
      </div>
    </div>

module.exports = GenHealthDetailComponent