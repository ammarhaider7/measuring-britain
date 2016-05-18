# React = require 'react'
FancySelect = require 'react-select'
Filter = require './chart-controls-filter.js'
# window.$ = require 'jQuery'

Controls = React.createClass 
  render: ->  
    <div className="mb-form hidden-xs clearfix pl-medium">
      <div className="mb-form-row col-sm-12 row">
        <div className="col-sm-9 mb-no-padding">
          <label className="col-sm-1"></label>
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
        <div className="col-sm-3 mb-no-padding">
          <button 
            className="btn btn-sm btn-primary mb-oxygen"
            onClick={ =>
              @props.fetchPyramidData {
                outlineRequested: if @props.outlineFilter is on then yes else no
                bars: {
                  isDefault: no
                  category: {
                    label: @props._barsCategory.label
                    value: @props._barsCategory.value
                  }
                  value: {
                    label: @props._barsValue.label
                    value: @props._barsValue.value
                  }
                }
                outline: {
                  isDefault: no
                  category: {
                    label: @props._outlineCategory.label
                    value: @props._outlineCategory.value
                  }
                  value: {
                    label: @props._outlineValue.label
                    value: @props._outlineValue.value
                  }
                }
              } 
            }
          >Go
          </button>
          { do =>
            if @props.chartName is 'pyramid'
              <button 
                className={ if @props.outlineFilter is yes then "hide" else "btn btn-sm btn-default mb-oxygen ml-small mb-small-btn-gradient" }
                type="button" 
                onClick={ @props.onAddOutline }
              >
                <span className={ "glyphicon glyphicon-plus" }/>
                { if @props.outlineFilter is no then " " + "Line" else '' }
              </button>
          }
        <img src="./images/mb_ajax_loader.gif" 
          className={ if @props.isFetching is yes and @props.isDefault is no then 'mb-spinner' else 'hide' }
        />     
        { if @props.error is yes then <span className={ "glyphicon glyphicon-remove pl-small mb-error-icon" }/> }
        </div>
      </div>
      { if @props.outlineFilter is yes
        <Filter {...@props}/>
      }
    </div>

module.exports = Controls