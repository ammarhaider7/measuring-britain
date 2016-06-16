// Generated by CoffeeScript 1.10.0
var Nav;

Nav = React.createClass({displayName: "Nav",
  render: function() {
    return React.createElement("nav", {
      "className": (this.props.border === 'yes' ? "navbar navbar-default navbar-static-top mb-nav-border" : "navbar navbar-default navbar-static-top")
    }, React.createElement("div", {
      "className": (this.props.alt_bg === 'yes' ? "container mb-alt-bg mb-full-width" : "container")
    }, React.createElement("div", {
      "className": "navbar-header"
    }, React.createElement("button", {
      "type": "button",
      "className": "navbar-toggle collapsed",
      "data-toggle": "collapse",
      "data-target": "#navbar",
      "aria-expanded": "false",
      "aria-controls": "navbar"
    }, React.createElement("span", {
      "className": "sr-only"
    }, "Toggle navigation"), React.createElement("span", {
      "className": "icon-bar"
    }), React.createElement("span", {
      "className": "icon-bar"
    }), React.createElement("span", {
      "className": "icon-bar"
    })), React.createElement("a", {
      "className": (this.props.alt_bg === 'yes' ? "mb-nav-brand-font navbar-brand mb-white-text" : "mb-nav-brand-font navbar-brand"),
      "href": "#"
    }, "MB App")), React.createElement("div", {
      "id": "navbar",
      "className": "navbar-collapse collapse",
      "aria-expanded": "false",
      "style": {
        height: '1px'
      }
    }, React.createElement("ul", {
      "className": "nav navbar-nav"
    }, React.createElement("li", {
      "className": (this.props.active === "home" ? 'active' : '')
    }, React.createElement("a", {
      "className": (this.props.alt_bg === 'yes' ? 'mb-white-text' : void 0),
      "href": "/"
    }, "Home")), React.createElement("li", {
      "className": (this.props.active === "census" ? 'dropdown active' : 'dropdown')
    }, React.createElement("a", {
      "href": "/demographics",
      "className": (this.props.alt_bg === 'yes' ? 'dropdown-toggle mb-white-text' : "dropdown-toggle"),
      "data-toggle": "dropdown",
      "role": "button",
      "aria-haspopup": "true",
      "aria-expanded": "false"
    }, "Census ", React.createElement("span", {
      "className": "caret"
    })), React.createElement("ul", {
      "className": "dropdown-menu"
    }, React.createElement("li", null, React.createElement("a", {
      "href": "/census"
    }, "Census Home")), React.createElement("li", {
      "role": "separator",
      "className": "divider"
    }), React.createElement("li", {
      "className": "dropdown-header"
    }, "Demographics"), React.createElement("li", null, React.createElement("a", {
      "href": "/census/population-pyramid"
    }, "Population Pyramid (Census)")), React.createElement("li", null, React.createElement("a", {
      "href": "/census/ethnic-diversity"
    }, "Ethnic Diversity (Census)")), React.createElement("li", null, React.createElement("a", {
      "href": "/census/religious-diversity"
    }, "Religious Diversity (Census)")), React.createElement("li", {
      "role": "separator",
      "className": "divider"
    }), React.createElement("li", {
      "className": "dropdown-header"
    }, "Health"), React.createElement("li", null, React.createElement("a", {
      "href": "/census/ethnic-disparities-general-health"
    }, "Ethnic Disparities in General Health (Census)")), React.createElement("li", null, React.createElement("a", {
      "href": "/census/longterm-illness-disability-by-ethnicity	"
    }, "Long-term illness\x2Fdisability by ethnicity (Census)")))), React.createElement("li", {
      "className": (this.props.active === "demographics" ? 'dropdown active' : 'dropdown')
    }, React.createElement("a", {
      "href": "/demographics",
      "className": (this.props.alt_bg === 'yes' ? 'dropdown-toggle mb-white-text' : "dropdown-toggle"),
      "data-toggle": "dropdown",
      "role": "button",
      "aria-haspopup": "true",
      "aria-expanded": "false"
    }, "Demographics ", React.createElement("span", {
      "className": "caret"
    })), React.createElement("ul", {
      "className": "dropdown-menu"
    }, React.createElement("li", {
      "role": "separator",
      "className": "divider"
    }), React.createElement("li", {
      "className": "dropdown-header"
    }, "Census"), React.createElement("li", null, React.createElement("a", {
      "href": "/census/population-pyramid"
    }, "Population Pyramid (Census)")), React.createElement("li", null, React.createElement("a", {
      "href": "/census/ethnic-diversity"
    }, "Ethnic Diversity (Census)")), React.createElement("li", null, React.createElement("a", {
      "href": "/census/religious-diversity"
    }, "Religious Diversity (Census)")))), React.createElement("li", {
      "className": (this.props.active === "health" ? 'dropdown active' : 'dropdown')
    }, React.createElement("a", {
      "href": "/health",
      "className": (this.props.alt_bg === 'yes' ? 'dropdown-toggle mb-white-text' : "dropdown-toggle"),
      "data-toggle": "dropdown",
      "role": "button",
      "aria-haspopup": "true",
      "aria-expanded": "false"
    }, "Health ", React.createElement("span", {
      "className": "caret"
    })), React.createElement("ul", {
      "className": "dropdown-menu"
    }, React.createElement("li", {
      "role": "separator",
      "className": "divider"
    }), React.createElement("li", {
      "className": "dropdown-header"
    }, "Census"), React.createElement("li", null, React.createElement("a", {
      "href": "/census/ethnic-disparities-general-health"
    }, "Ethnic Disparities in General Health (Census)")), React.createElement("li", null, React.createElement("a", {
      "href": "/census/longterm-illness-disability-by-ethnicity"
    }, "Long-term illness\x2Fdisability by ethnicity (Census)")))), React.createElement("li", {
      "className": "labour"
    }, React.createElement("a", {
      "className": (this.props.alt_bg === 'yes' ? 'mb-white-text' : void 0),
      "href": "labour"
    }, "Labour Market")), React.createElement("li", {
      "className": "about"
    }, React.createElement("a", {
      "className": (this.props.alt_bg === 'yes' ? 'mb-white-text' : void 0),
      "href": "/about"
    }, "About"))), React.createElement("ul", {
      "className": "nav navbar-nav navbar-right"
    }, React.createElement("li", null, React.createElement("a", {
      "href": "#"
    }, React.createElement("i", {
      "className": "fa fa-facebook fa-lg fa-fw"
    }))), React.createElement("li", null, React.createElement("a", {
      "href": "#"
    }, React.createElement("i", {
      "className": "fa fa-twitter fa-lg fa-fw"
    }))), React.createElement("li", null, React.createElement("a", {
      "href": "https://github.com/ammarhaider7/measuring-britain",
      "target": "_blank"
    }, React.createElement("i", {
      "className": "fa fa-github fa-lg fa-fw"
    }))), React.createElement("li", null, React.createElement("a", {
      "href": "#"
    }, React.createElement("i", {
      "className": "fa fa-trello fa-lg fa-fw"
    })))))));
  }
});

module.exports = Nav;

//# sourceMappingURL=nav.map
