React = require 'react'
FancySelect = require 'react-select'
Filter = require './chart-controls-filter.js'

Controls = React.createClass
  render: ->
    <div className="mb-form hidden-xs clearfix pl-medium">
      <div className="mb-form-container col-sm-12 row">
        <div className="col-sm-9 mb-no-padding">
          <label className="col-sm-1">Filter</label>
          <div className="mb-form-group col-sm-5 mb-oxygen">
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
          <div className="mb-form-group col-sm-6 category-group mb-oxygen">
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
        </div>
        <div className="col-sm-2 col-md-3 mb-no-padding">
          <button className="btn btn-sm btn-primary mb-oxygen">Go</button>
          { do =>
            if @props.chartName is 'pyramid'
              <button 
                className="btn btn-sm btn-default mb-oxygen ml-small mb-small-btn-gradient" 
                type="button" 
                onClick={ if @props.outlineFilter is false then @props.onAddOutline else @props.onRemoveFilter }
              >
                <span className={ if @props.outlineFilter is false then "glyphicon glyphicon-plus" else "glyphicon glyphicon-minus" }/>
                { if @props.outlineFilter is false then " " + "Add outline" else '' }
              </button>
          }
        </div>
      </div>
      { if @props.outlineFilter is true
        <Filter {...@props}/>
      }
    </div>

module.exports = Controls