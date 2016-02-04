"use strict";

var adgear = adgear || {};
adgear.ui = adgear.ui || {};

adgear.ui.init = function () {
    adgear.ui.stackWordTree.init();
};

adgear.ui.stackWordTree = (function () {
    var t = {};

    var drawStackWordTree = function (container, data) {
        //Credits: http://bl.ocks.org/mbostock/4063269

        var diameter = 660,
            format   = d3.format(",d"),
            color    = d3.scale.category20c();

        var bubble = d3.layout.pack()
            .sort(null)
            .size([diameter, diameter])
            .padding(1.5);

        var svg = d3.select(container).append("svg")
            .attr("width", diameter)
            .attr("height", diameter)
            .attr("class", "bubble");

        var node = svg.selectAll(".node")
            .data(bubble.nodes(classes(data))
                .filter(function (d) {
                    return !d.children;
                }))
            .enter().append("g")
            .attr("class", "node")
            .attr("transform", function (d) {
                return "translate(" + d.x + "," + d.y + ")";
            });

        node.append("title")
            .text(function (d) {
                return d.className + ": " + format(d.value);
            });

        node.append("circle")
            .attr("r", function (d) {
                return d.r;
            })
            .style("fill", function (d) {
                return color(d.packageName);
            });

        node.append("text")
            .attr("dy", ".2em")
            .style("text-anchor", "middle")
            .text(function (d) {
                return d.className.substring(0, d.r / 3);
            });

        // Returns a flattened hierarchy containing all leaf nodes under the root.
        function classes(root) {
            var classes = [];

            function recurse(name, node) {
                if (node.children) node.children.forEach(function (child) {
                    recurse(node.name, child);
                });
                else classes.push({packageName: name, className: node.name, value: node.size});
            }

            recurse(null, root);
            return {children: classes};
        }

        d3.select(self.frameElement).style("height", diameter + "px");
    };

    var init = function() {
        console.log("adgear.ui.stackWordTree initialized");
    };

    return {
        init: init,
        drawStackWordTree: drawStackWordTree
    };
}());
