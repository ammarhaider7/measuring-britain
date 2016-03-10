React = require 'react'
FancySelect = require 'react-select'

Controls = React.createClass
  render: ->
    <div className="mb-form hidden-xs clearfix">
      <div className="mb-form-container col-sm-11 col-sm-offset-1">
        <label>Filter by</label>
        <div className="mb-form-group col-sm-4 mb-oxygen">
          <select className="Select form-control input-sm" onChange={ @props.onCategoryChange }>
            <option className="mb-default-select-value" selected disabled>Select a Category..</option>
            { @props.categories.map (category) ->
              <option value={ category.value } key={ category.value }>{ category.label }</option> 
            }
          </select>
        </div>
        <div className="mb-form-group category-group col-sm-5 mb-oxygen">
          <FancySelect
            className="mb-input-sm"
            placeholder={ do =>
              switch @props.category
                when 'districts' then 'Search districts..'
                when 'regions' then 'Select a region..'
                when 'ethnicity' then 'Select an ethnic group..'
                when 'religion' then 'Select a religion..'   
                else 'Select a category first..'           
            }
            options={ do =>
              switch @props.category
                when 'districts' then @props.values.districts
                when 'regions' then @props.values.regions
                when 'ethnicity' then @props.values.ethnic_groups
                when 'religion' then @props.values.religions 
                else []          
            }
          />
        </div>
        <button className="btn btn-sm btn-default">Go</button>
      </div>
    </div>

module.exports = Controls