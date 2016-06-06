// Generated by CoffeeScript 1.10.0
var GenHealthDetailComponent, format, percFormat;

format = d3.format('.3s');

percFormat = d3.format(',.2%');

GenHealthDetailComponent = React.createClass({displayName: "GenHealthDetailComponent",
  onToggleSex: function(e) {
    var el, sexLabel, sexVal;
    el = e.target;
    sexVal = el.getAttribute('data-value');
    sexLabel = el.innerHTML;
    this.props.onToggleSex(sexLabel, sexVal);
    return this.props.fetchGenHealthData({
      isDefault: false,
      category: this.props._category,
      value: this.props._value,
      sex: {
        label: sexLabel,
        value: sexVal
      }
    });
  },
  highlight: function(ethnicity) {
    return this.props.onHighlightLine(ethnicity);
  },
  unHighlight: function(ethnicity, index) {
    return this.props.onUnHighlightLine(ethnicity, index);
  },
  handleChange: function(event) {
    var $el, arr, index, value;
    $el = $(event.target);
    value = event.target.value;
    if ($el.parent().hasClass('highlight') === true) {
      $el.parent().removeClass('highlight');
      arr = this.props._highlights;
      index = arr.indexOf(value);
      return this.unHighlight(value, index);
    } else {
      $el.parent().addClass('highlight');
      return this.highlight(value);
    }
  },
  trimEthnicity: function(ethnicity_string) {
    var str, trimmedStr;
    if (ethnicity_string.indexOf('Gypsy') !== -1) {
      return trimmedStr = 'Gypsy';
    } else if (ethnicity_string.indexOf('English') !== -1) {
      return trimmedStr = 'British';
    } else if (ethnicity_string.indexOf('Any other') !== -1) {
      return trimmedStr = 'Any other';
    } else if (ethnicity_string.indexOf('Arab') !== -1) {
      return trimmedStr = 'Arab';
    } else if (ethnicity_string.indexOf('and') !== -1) {
      str = ethnicity_string.replace(' and ', '/');
      return trimmedStr = str.substr(str.indexOf(':') + 2, str.length);
    } else if (ethnicity_string.indexOf('Other') !== -1) {
      return trimmedStr = 'Other';
    } else {
      str = ethnicity_string;
      return trimmedStr = str.substr(str.indexOf(':') + 2, str.length);
    }
  },
  render: function() {
    var ethnicity, group, i, j;
    return React.createElement("div", null, React.createElement("div", {
      "className": "clearfix"
    }, React.createElement("span", {
      "className": "mb-oxygen mb-gender-toggles-label"
    }, "Choose gender: "), React.createElement("div", {
      "className": "btn-group mb-gender-toggles mb-oxygen mb-right",
      "role": "group",
      "aria-label": "..."
    }, React.createElement("button", {
      "type": "button",
      "className": (this.props.sex === 'All' ? "btn btn-default active" : "btn btn-default"),
      "data-value": 0.,
      "onClick": this.onToggleSex
    }, "All"), React.createElement("button", {
      "type": "button",
      "className": (this.props.sex === 'Female' ? "btn btn-default active" : "btn btn-default"),
      "data-value": 2.,
      "onClick": this.onToggleSex
    }, "Female"), React.createElement("button", {
      "type": "button",
      "className": (this.props.sex === 'Male' ? "btn btn-default active" : "btn btn-default"),
      "data-value": 1.,
      "onClick": this.onToggleSex
    }, "Male"))), ((function() {

      /*
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
       */
    })()), React.createElement("div", {
      "className": "mb-oxygen"
    }, React.createElement("h4", null, React.createElement("strong", null, "Highlight ethnicities")), React.createElement("div", {
      "className": ""
    }, React.createElement("img", {
      "src": "./images/mb_ajax_loader.gif",
      "className": (this.props.isFetching === true && this.props.isDefault === true ? 'mb-spinner' : 'hide')
    }), ((function() {
      var k, len, ref, results;
      if (this.props.data.ethnicities != null) {
        ref = this.props.data.ethnicities_grouped;
        results = [];
        for (i = k = 0, len = ref.length; k < len; i = ++k) {
          group = ref[i];
          results.push(React.createElement("div", {
            "key": i,
            "className": "col-sm-4 mt-small ethnic-checkboxes-column"
          }, (function() {
            var l, len1, results1;
            results1 = [];
            for (j = l = 0, len1 = group.length; l < len1; j = ++l) {
              ethnicity = group[j];
              if (typeof ethnicity === 'object') {
                results1.push(React.createElement("div", {
                  "key": ethnicity.title
                }, React.createElement("label", {
                  "className": "ethnic_title"
                }, React.createElement("strong", null, ethnicity.title))));
              } else {
                results1.push(React.createElement("div", {
                  "className": "checkbox",
                  "key": ethnicity
                }, React.createElement("label", {
                  "className": "checkbox-zone"
                }, React.createElement("input", {
                  "type": "checkbox",
                  "value": ethnicity,
                  "onChange": this.handleChange
                }), this.trimEthnicity(ethnicity))));
              }
            }
            return results1;
          }).call(this)));
        }
        return results;
      }
    }).call(this)))));
  }
});

module.exports = GenHealthDetailComponent;

//# sourceMappingURL=general-health-detail-component.map
