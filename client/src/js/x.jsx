import React from 'react';
import ReactDOM from 'react-dom';
import RxComponent from './rxComponent.js'
import coffeeFn from './coffee/b.coffee'
import { CjsxComponentX } from './coffee/c.cjsx'
import '../css/global.scss';
import '../css/xstyles.css';

coffeeFn();

const Xcomponent = React.createClass({
  render() {
    return (
      <div className="Xcomponent">
        <p>Hello, world! I am a client-side react component on x.</p>
        <RxComponent />
        <CjsxComponentX />
      </div>
    );
  }
});

ReactDOM.render(<Xcomponent />,  document.getElementById('content'));