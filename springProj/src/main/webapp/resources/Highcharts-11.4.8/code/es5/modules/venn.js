!/**
 * Highcharts JS v11.4.8 (2024-08-29)
 *
 * (c) 2017-2024 Highsoft AS
 * Authors: Jon Arild Nygard
 *
 * License: www.highcharts.com/license
 */function(t){"object"==typeof module&&module.exports?(t.default=t,module.exports=t):"function"==typeof define&&define.amd?define("highcharts/modules/venn",["highcharts"],function(e){return t(e),t.Highcharts=e,t}):t("undefined"!=typeof Highcharts?Highcharts:void 0)}(function(t){"use strict";var e=t?t._modules:{};function r(e,r,n,i){e.hasOwnProperty(r)||(e[r]=i.apply(null,n),"function"==typeof CustomEvent&&t.win.dispatchEvent(new CustomEvent("HighchartsModuleLoaded",{detail:{path:r,module:e[r]}})))}r(e,"Core/Geometry/CircleUtilities.js",[e["Core/Geometry/GeometryUtilities.js"]],function(t){var e,r=t.getAngleBetweenPoints,n=t.getCenterOfPoints,i=t.getDistanceBetweenPoints;return function(t){function e(t,e){var r=Math.pow(10,e);return Math.round(t*r)/r}function o(t){if(t<=0)throw Error("radius of circle must be a positive number.");return Math.PI*t*t}function s(t,e){return t*t*Math.acos(1-e/t)-(t-e)*Math.sqrt(e*(2*t-e))}function a(t,r){var n=i(t,r),o=t.r,s=r.r,a=[];if(n<o+s&&n>Math.abs(o-s)){var u=o*o,c=(u-s*s+n*n)/(2*n),l=Math.sqrt(u-c*c),f=t.x,p=r.x,h=t.y,d=r.y,y=f+c*(p-f)/n,v=h+c*(d-h)/n,g=-(l/n*(d-h)),m=-(l/n*(p-f));a=[{x:e(y+g,14),y:e(v-m,14)},{x:e(y-g,14),y:e(v+m,14)}]}return a}function u(t){return t.reduce(function(t,e,r,n){var i=n.slice(r+1).reduce(function(t,n,i){var o=[r,i+r+1];return t.concat(a(e,n).map(function(t){return t.indexes=o,t}))},[]);return t.concat(i)},[])}function c(t,e){return i(t,e)<=e.r+1e-10}function l(t,e){return!e.some(function(e){return!c(t,e)})}function f(t){return u(t).filter(function(e){return l(e,t)})}t.round=e,t.getAreaOfCircle=o,t.getCircularSegmentArea=s,t.getOverlapBetweenCircles=function(t,r,n){var i=0;if(n<t+r){if(n<=Math.abs(r-t))i=o(t<r?t:r);else{var a=(t*t-r*r+n*n)/(2*n);i=s(t,t-a)+s(r,r-(n-a))}i=e(i,14)}return i},t.getCircleCircleIntersection=a,t.getCirclesIntersectionPoints=u,t.isCircle1CompletelyOverlappingCircle2=function(t,e){return i(t,e)+e.r<t.r+1e-10},t.isPointInsideCircle=c,t.isPointInsideAllCircles=l,t.isPointOutsideAllCircles=function(t,e){return!e.some(function(e){return c(t,e)})},t.getCirclesIntersectionPolygon=f,t.getAreaOfIntersectionBetweenCircles=function(t){var e,o=f(t);if(o.length>1){var s=n(o),a=(o=o.map(function(t){return t.angle=r(s,t),t}).sort(function(t,e){return e.angle-t.angle}))[o.length-1],u=o.reduce(function(e,o){var s=e.startPoint,a=n([s,o]),u=o.indexes.filter(function(t){return s.indexes.indexOf(t)>-1}).reduce(function(e,n){var u=t[n],c=r(u,o),l=r(u,s),f=l-c+(l<c?2*Math.PI:0),p=l-f/2,h=i(a,{x:u.x+u.r*Math.sin(p),y:u.y+u.r*Math.cos(p)}),d=u.r;return h>2*d&&(h=2*d),(!e||e.width>h)&&(e={r:d,largeArc:h>d?1:0,width:h,x:o.x,y:o.y}),e},null);if(u){var c=u.r;e.arcs.push(["A",c,c,0,u.largeArc,1,u.x,u.y]),e.startPoint=o}return e},{startPoint:a,arcs:[]}).arcs;0===u.length||1===u.length||(u.unshift(["M",a.x,a.y]),e={center:s,d:u})}return e}}(e||(e={})),e}),r(e,"Series/DrawPointUtilities.js",[],function(){var t=this&&this.__assign||function(){return(t=Object.assign||function(t){for(var e,r=1,n=arguments.length;r<n;r++)for(var i in e=arguments[r])Object.prototype.hasOwnProperty.call(e,i)&&(t[i]=e[i]);return t}).apply(this,arguments)};return{draw:function(e,r){var n=r.animatableAttribs,i=r.onComplete,o=r.css,s=r.renderer,a=e.series&&e.series.chart.hasRendered?void 0:e.series&&e.series.options.animation,u=e.graphic;if(r.attribs=t(t({},r.attribs),{class:e.getClassName()})||{},e.shouldDraw())u||(u="text"===r.shapeType?s.text():"image"===r.shapeType?s.image(r.imageUrl||"").attr(r.shapeArgs||{}):s[r.shapeType](r.shapeArgs||{}),e.graphic=u,u.add(r.group)),o&&u.css(o),u.attr(r.attribs).animate(n,!r.isNew&&a,i);else if(u){var c=function(){e.graphic=u=u&&u.destroy(),"function"==typeof i&&i()};Object.keys(n).length?u.animate(n,void 0,function(){return c()}):c()}}}}),r(e,"Series/Venn/VennPoint.js",[e["Core/Series/SeriesRegistry.js"],e["Core/Utilities.js"]],function(t,e){var r,n=this&&this.__extends||(r=function(t,e){return(r=Object.setPrototypeOf||({__proto__:[]})instanceof Array&&function(t,e){t.__proto__=e}||function(t,e){for(var r in e)Object.prototype.hasOwnProperty.call(e,r)&&(t[r]=e[r])})(t,e)},function(t,e){if("function"!=typeof e&&null!==e)throw TypeError("Class extends value "+String(e)+" is not a constructor or null");function n(){this.constructor=t}r(t,e),t.prototype=null===e?Object.create(e):(n.prototype=e.prototype,new n)}),i=t.seriesTypes.scatter.prototype.pointClass,o=e.isNumber;return function(t){function e(){return null!==t&&t.apply(this,arguments)||this}return n(e,t),e.prototype.isValid=function(){return o(this.value)},e.prototype.shouldDraw=function(){return!!this.shapeArgs},e}(i)}),r(e,"Series/Venn/VennSeriesDefaults.js",[],function(){return{borderColor:"#cccccc",borderDashStyle:"solid",borderWidth:1,brighten:0,clip:!1,colorByPoint:!0,dataLabels:{enabled:!0,verticalAlign:"middle",formatter:function(){return this.point.name}},inactiveOtherPoints:!0,marker:!1,opacity:.75,showInLegend:!1,legendType:"point",states:{hover:{opacity:1,borderColor:"#333333"},select:{color:"#cccccc",borderColor:"#000000",animation:!1},inactive:{opacity:.075}},tooltip:{pointFormat:"{point.name}: {point.value}"},legendSymbol:"rectangle"}}),r(e,"Series/Venn/VennUtils.js",[e["Core/Geometry/CircleUtilities.js"],e["Core/Geometry/GeometryUtilities.js"],e["Core/Utilities.js"]],function(t,e,r){var n=this&&this.__assign||function(){return(n=Object.assign||function(t){for(var e,r=1,n=arguments.length;r<n;r++)for(var i in e=arguments[r])Object.prototype.hasOwnProperty.call(e,i)&&(t[i]=e[i]);return t}).apply(this,arguments)},i=t.getAreaOfCircle,o=t.getCircleCircleIntersection,s=t.getOverlapBetweenCircles,a=t.isPointInsideAllCircles,u=t.isPointInsideCircle,c=t.isPointOutsideAllCircles,l=e.getDistanceBetweenPoints,f=r.extend,p=r.isArray,h=r.isNumber,d=r.isObject,y=r.isString;function v(t){var e={};return t.filter(function(t){return 2===t.sets.length}).forEach(function(t){t.sets.forEach(function(r,i,o){var s;d(e[r])||(e[r]={totalOverlap:0,overlapping:{}}),e[r]={totalOverlap:(e[r].totalOverlap||0)+t.value,overlapping:n(n({},e[r].overlapping||{}),((s={})[o[1-i]]=t.value,s))}})}),t.filter(b).forEach(function(t){var r=e[t.sets[0]];f(t,r)}),t}function g(t,e,r,n,i){var o,s,a=t(e),u=t(r),c=i||100,l=n||1e-10,f=r-e,p=1;if(e>=r)throw Error("a must be smaller than b.");if(a*u>0)throw Error("f(a) and f(b) must have opposite signs.");if(0===a)o=e;else if(0===u)o=r;else for(;p++<=c&&0!==s&&f>l;)f=(r-e)/2,a*(s=t(o=e+f))>0?e=o:r=o;return o}function m(t){for(var e=t.slice(0,-1),r=e.length,n=[],i=function(t,e){return t.sum+=e[t.i],t},o=0;o<r;o++)n[o]=e.reduce(i,{sum:0,i:o}).sum/r;return n}function x(t,e,r){var n=t+e;return r<=0?n:i(t<e?t:e)<=r?0:g(function(n){return r-s(t,e,n)},0,n)}function b(t){return p(t.sets)&&1===t.sets.length}function C(t){var e={};return d(t)&&h(t.value)&&t.value>-1&&p(t.sets)&&t.sets.length>0&&!t.sets.some(function(t){var r=!1;return!e[t]&&y(t)?e[t]=!0:r=!0,r})}function O(t,e){return e.reduce(function(e,r){var n=0;if(r.sets.length>1){var i=r.value-function(t){var e=0;if(2===t.length){var r=t[0],n=t[1];e=s(r.r,n.r,l(r,n))}return e}(r.sets.map(function(e){return t[e]}));n=Math.round(i*i*1e11)/1e11}return e+n},0)}function A(t,e){return void 0!==e.totalOverlap&&void 0!==t.totalOverlap?e.totalOverlap-t.totalOverlap:NaN}return{geometry:e,geometryCircles:t,addOverlapToSets:v,getCentroid:m,getDistanceBetweenCirclesByOverlap:x,getLabelWidth:function(t,e,r){var n=e.reduce(function(t,e){return Math.min(e.r,t)},1/0),i=r.filter(function(e){return!u(t,e)}),o=function(r,n){return g(function(o){var s={x:t.x+n*o,y:t.y};return-(r-o)+(a(s,e)&&c(s,i)?0:Number.MAX_VALUE)},0,r)};return 2*Math.min(o(n,-1),o(n,1))},getMarginFromCircles:function(t,e,r){var n=e.reduce(function(e,r){var n=r.r-l(t,r);return n<=e?n:e},Number.MAX_VALUE);return r.reduce(function(e,r){var n=l(t,r)-r.r;return n<=e?n:e},n)},isSet:b,layoutGreedyVenn:function(t){var e=[],r={};t.filter(function(t){return 1===t.sets.length}).forEach(function(t){r[t.sets[0]]=t.circle={x:Number.MAX_VALUE,y:Number.MAX_VALUE,r:Math.sqrt(t.value/Math.PI)}});var n=function(t,r){var n=t.circle;n&&(n.x=r.x,n.y=r.y),e.push(t)};v(t);var i=t.filter(b).sort(A);n(i.shift(),{x:0,y:0});for(var s=t.filter(function(t){return 2===t.sets.length}),a=0;a<i.length;a++)!function(t){var i=t.circle;if(i){var a=i.r,u=t.overlapping;n(t,e.reduce(function(t,n,c){var l=n.circle;if(!l||!u)return t;for(var f=u[n.sets[0]],p=x(a,l.r,f),h=[{x:l.x+p,y:l.y},{x:l.x-p,y:l.y},{x:l.x,y:l.y+p},{x:l.x,y:l.y-p}],d=0,y=e.slice(c+1);d<y.length;d++){var v=y[d],g=v.circle,m=u[v.sets[0]];if(g){var b=x(a,g.r,m);h=h.concat(o({x:l.x,y:l.y,r:p},{x:g.x,y:g.y,r:b}))}}for(var C=0,A=h;C<A.length;C++){var j=A[C];i.x=j.x,i.y=j.y;var w=O(r,s);w<t.loss&&(t.loss=w,t.coordinates=j)}return t},{loss:Number.MAX_VALUE,coordinates:void 0}).coordinates)}}(i[a]);return r},loss:O,nelderMead:function(t,e){for(var r=function(t,e){return t.fx-e.fx},n=function(t,e,r,n){return e.map(function(e,i){return t*e+r*n[i]})},i=function(e,r){return r.fx=t(r),e[e.length-1]=r,e},o=function(e){var r=e[0];return e.map(function(e){var i=n(.5,r,.5,e);return i.fx=t(i),i})},s=function(e,r,i,o){var s=n(i,e,o,r);return s.fx=t(s),s},a=function(e){var r=e.length,n=Array(r+1);n[0]=e,n[0].fx=t(e);for(var i=0;i<r;++i){var o=e.slice();o[i]=o[i]?1.05*o[i]:.001,o.fx=t(o),n[i+1]=o}return n}(e),u=0;u<100;u++){a.sort(r);var c=a[a.length-1],l=m(a),f=s(l,c,2,-1);if(f.fx<a[0].fx){var p=s(l,c,3,-2);a=i(a,p.fx<f.fx?p:f)}else if(f.fx>=a[a.length-2].fx){var h=void 0;a=f.fx>c.fx?(h=s(l,c,.5,.5)).fx<c.fx?i(a,h):o(a):(h=s(l,c,1.5,-.5)).fx<f.fx?i(a,h):o(a)}else a=i(a,f)}return a[0]},processVennData:function(t,e){var r=p(t)?t:[],n=r.reduce(function(t,e){var r;return e.sets&&C(r=e)&&b(r)&&r.value>0&&-1===t.indexOf(e.sets[0])&&t.push(e.sets[0]),t},[]).sort(),i=r.reduce(function(t,r){return r.sets&&C(r)&&!r.sets.some(function(t){return -1===n.indexOf(t)})&&(t[r.sets.sort().join(e)]={sets:r.sets,value:r.value||0}),t},{});return n.reduce(function(t,r,n,i){return i.slice(n+1).forEach(function(n){t.push(r+e+n)}),t},[]).forEach(function(t){if(!i[t]){var r={sets:t.split(e),value:0};i[t]=r}}),Object.keys(i).map(function(t){return i[t]})},sortByTotalOverlap:A}}),r(e,"Series/Venn/VennSeries.js",[e["Core/Animation/AnimationUtilities.js"],e["Core/Color/Color.js"],e["Core/Geometry/CircleUtilities.js"],e["Series/DrawPointUtilities.js"],e["Core/Geometry/GeometryUtilities.js"],e["Core/Series/SeriesRegistry.js"],e["Series/Venn/VennPoint.js"],e["Series/Venn/VennSeriesDefaults.js"],e["Series/Venn/VennUtils.js"],e["Core/Utilities.js"]],function(t,e,r,n,i,o,s,a,u,c){var l,f=this&&this.__extends||(l=function(t,e){return(l=Object.setPrototypeOf||({__proto__:[]})instanceof Array&&function(t,e){t.__proto__=e}||function(t,e){for(var r in e)Object.prototype.hasOwnProperty.call(e,r)&&(t[r]=e[r])})(t,e)},function(t,e){if("function"!=typeof e&&null!==e)throw TypeError("Class extends value "+String(e)+" is not a constructor or null");function r(){this.constructor=t}l(t,e),t.prototype=null===e?Object.create(e):(r.prototype=e.prototype,new r)}),p=t.animObject,h=e.parse,d=r.getAreaOfIntersectionBetweenCircles,y=r.getCirclesIntersectionPolygon,v=r.isCircle1CompletelyOverlappingCircle2,g=r.isPointInsideAllCircles,m=r.isPointOutsideAllCircles,x=i.getCenterOfPoints,b=o.seriesTypes.scatter,C=c.addEvent,O=c.extend,A=c.isArray,j=c.isNumber,w=c.isObject,P=c.merge,M=function(t){function e(){return null!==t&&t.apply(this,arguments)||this}return f(e,t),e.getLabelPosition=function(t,e){var r=t.reduce(function(r,n){var i=n.r/2;return[{x:n.x,y:n.y},{x:n.x+i,y:n.y},{x:n.x-i,y:n.y},{x:n.x,y:n.y+i},{x:n.x,y:n.y-i}].reduce(function(r,n){var i=u.getMarginFromCircles(n,t,e);return r.margin<i&&(r.point=n,r.margin=i),r},r)},{point:void 0,margin:-Number.MAX_VALUE}).point,n=u.nelderMead(function(r){return-u.getMarginFromCircles({x:r[0],y:r[1]},t,e)},[r.x,r.y]);return g(r={x:n[0],y:n[1]},t)&&m(r,e)||(r=t.length>1?x(y(t)):{x:t[0].x,y:t[0].y}),r},e.getLabelValues=function(t,r){var n=t.sets,i=r.reduce(function(t,e){var r=n.indexOf(e.sets[0])>-1;return e.circle&&t[r?"internal":"external"].push(e.circle),t},{internal:[],external:[]});i.external=i.external.filter(function(t){return i.internal.some(function(e){return!v(t,e)})});var o=e.getLabelPosition(i.internal,i.external),s=u.getLabelWidth(o,i.internal,i.external);return{position:o,width:s}},e.layout=function(t){var r={},n={};if(t.length>0)for(var i=u.layoutGreedyVenn(t),o=t.filter(u.isSet),s=0;s<t.length;s++){var a=t[s],c=a.sets,l=c.join(),f=u.isSet(a)?i[l]:d(c.map(function(t){return i[t]}));f&&(r[l]=f,n[l]=e.getLabelValues(a,o))}return{mapOfIdToShape:r,mapOfIdToLabelValues:n}},e.getScale=function(t,e,r){var n=r.bottom-r.top,i=r.right-r.left,o=(r.right+r.left)/2,s=(r.top+r.bottom)/2,a=Math.min(i>0?1/i*t:1,n>0?1/n*e:1);return{scale:a,centerX:t/2-o*a,centerY:e/2-s*a}},e.updateFieldBoundaries=function(t,e){var r=e.x-e.r,n=e.x+e.r,i=e.y+e.r,o=e.y-e.r;return(!j(t.left)||t.left>r)&&(t.left=r),(!j(t.right)||t.right<n)&&(t.right=n),(!j(t.top)||t.top>o)&&(t.top=o),(!j(t.bottom)||t.bottom<i)&&(t.bottom=i),t},e.prototype.animate=function(t){if(!t)for(var e=p(this.options.animation),r=function(t){var r=t.shapeArgs;if(t.graphic&&r){var n={},i={};r.d?n.opacity=.001:(n.r=0,i.r=r.r),t.graphic.attr(n).animate(i,e),r.d&&setTimeout(function(){t&&t.graphic&&t.graphic.animate({opacity:1})},e.duration)}},n=0,i=this.points;n<i.length;n++)r(i[n])},e.prototype.drawPoints=function(){for(var t=this.chart,e=this.group,r=this.points||[],i=t.renderer,o=0;o<r.length;o++){var s=r[o],a={zIndex:A(s.sets)?s.sets.length:0},u=s.shapeArgs;t.styledMode||O(a,this.pointAttribs(s,s.state)),n.draw(s,{isNew:!s.graphic,animatableAttribs:u,attribs:a,group:e,renderer:i,shapeType:u&&u.d?"path":"circle"})}},e.prototype.init=function(){b.prototype.init.apply(this,arguments),delete this.opacity},e.prototype.pointAttribs=function(t,e){var r=this.options||{},n=t&&t.options||{},i=e&&r.states[e]||{},o=P(r,{color:t&&t.color},n,i);return{fill:h(o.color).brighten(o.brightness).get(),opacity:o.opacity,stroke:o.borderColor,"stroke-width":o.borderWidth,dashstyle:o.borderDashStyle}},e.prototype.translate=function(){var t=this.chart;this.processedXData=this.xData,this.generatePoints();for(var r=u.processVennData(this.options.data,e.splitter),n=e.layout(r),i=n.mapOfIdToShape,o=n.mapOfIdToLabelValues,s=Object.keys(i).filter(function(t){var e=i[t];return e&&j(e.r)}).reduce(function(t,r){return e.updateFieldBoundaries(t,i[r])},{top:0,bottom:0,left:0,right:0}),a=e.getScale(t.plotWidth,t.plotHeight,s),c=a.scale,l=a.centerX,f=a.centerY,p=0,h=this.points;p<h.length;p++){var d=h[p],y=A(d.sets)?d.sets:[],v=y.join(),g=i[v],m=o[v]||{},x=d.options&&d.options.dataLabels,b=void 0,C=m.width,O=m.position;if(g){if(g.r)b={x:l+g.x*c,y:f+g.y*c,r:g.r*c};else if(g.d){var M=g.d;M.forEach(function(t){"M"===t[0]?(t[1]=l+t[1]*c,t[2]=f+t[2]*c):"A"===t[0]&&(t[1]=t[1]*c,t[2]=t[2]*c,t[6]=l+t[6]*c,t[7]=f+t[7]*c)}),b={d:M}}O?(O.x=l+O.x*c,O.y=f+O.y*c):O={},j(C)&&(C=Math.round(C*c))}d.shapeArgs=b,O&&b&&(d.plotX=O.x,d.plotY=O.y),C&&b&&(d.dlOptions=P(!0,{style:{width:C}},w(x,!0)?x:void 0)),d.name=d.options.name||y.join("∩")}},e.splitter="highcharts-split",e.defaultOptions=P(b.defaultOptions,a),e}(b);return O(M.prototype,{axisTypes:[],directTouch:!0,isCartesian:!1,pointArrayMap:["value"],pointClass:s,utils:u}),C(M,"afterSetOptions",function(t){var e=t.options.states||{};if(this.is("venn"))for(var r=0,n=Object.keys(e);r<n.length;r++)e[n[r]].halo=!1}),o.registerSeriesType("venn",M),M}),r(e,"masters/modules/venn.src.js",[e["Core/Globals.js"]],function(t){return t})});