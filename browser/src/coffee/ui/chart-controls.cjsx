React = require 'react'
FancySelect = require 'react-select'
Filter = require './chart-controls-filter.js'

Controls = React.createClass 
  render: ->
    console.log 'Controls props'
    console.log @props
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
                  if category.value is @props._barsCategory.value then return category.label
              }
              onChange={ @props.onCategoryChange }
            />
          </div>
          <div className="mb-form-group col-sm-6 category-group mb-oxygen">
            <FancySelect
              className="mb-input-sm"
              placeholder={ do =>
                for category in @props.categories
                  if category.value is @props._barsCategory.value
                    return 'Search ' + category.value + '..'
                  else if category.value isnt @props._barsCategory.value
                    continue
                return '2. Choose a value'
              }
              value={ if @props._barsValue.value isnt 'default' then @props._barsValue.label }
              options={ do =>
                for category in @props.categories
                  if category.value is @props._barsCategory.value then return @props.values[category.value]
              }
              onChange={ @props.onValueChange }
            />
          </div>
        </div>
        <div className="col-sm-2 col-md-3 mb-no-padding">
          <button className="btn btn-sm btn-primary mb-oxygen">Go</button>
          { do =>
            if @props.chartName is 'pyramid'
              <button 
                className={ if @props.outlineFilter is true then "hide" else "btn btn-sm btn-default mb-oxygen ml-small mb-small-btn-gradient" }
                type="button" 
                onClick={ @props.onAddOutline }
              >
                <span className={ "glyphicon glyphicon-plus" }/>
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