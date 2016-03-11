React = require 'react'
FancySelect = require 'react-select'

Controls = React.createClass
  render: ->
    <div className="mb-form hidden-xs clearfix">
      <div className="mb-form-container col-sm-11 col-sm-offset-1">
        <label>Filter by</label>
        <div className="mb-form-group col-sm-4 mb-oxygen">
          <FancySelect
            className="mb-input-sm"
            placeholder="1. Choose a category"
            options={ @props.categories }
            value={ do =>
              for category in @props.categories
                if category.value is @props.category then return category.label
            }
            onChange={ @props.onCategoryChange }
          />
        </div>
        <div className="mb-form-group category-group col-sm-5 mb-oxygen">
          <FancySelect
            className="mb-input-sm"
            placeholder={ do =>
              for category in @props.categories
                if category.value is @props.category
                  return 'Search ' + category.value + '..'
                else if category.value isnt @props.category
                  continue
              return '2. Choose a value'  
            }
            options={ do =>
              for category in @props.categories
                if category.value is @props.category then return @props.values[category.value]
            }
          />
        </div>
        <button className="btn btn-sm btn-default">Go</button>
      </div>
    </div>

module.exports = Controls