<digraph>
    <script>

        RpgImpro.document.on('update', function () {
            var doc = RpgImpro.document
            var linkDistance = 200
            var textWidth = 100
            var colors = d3.scale.category20c();
            var dataset = {
                nodes: [],
                edges: []
            }
            var pkMap = {}
            var w = window.innerWidth - 20
            var h = window.innerHeight

            for (var k in doc.vertex) {
                var v = doc.vertex[k]
                pkMap[v.pk] = parseInt(k, 10) // javascript mystery
                dataset.nodes.push({name: v.sentence, tag: v.hashtag})
            }

            for (var k in doc.edge) {
                var link = doc.edge[k]
                dataset.edges.push({source: pkMap[link.source], target: pkMap[link.target]})
            }

            d3.select("digraph").select("svg").remove()
            var svg = d3.select("digraph").append("svg").attr({
                width: w,
                height: h,
                viewBox: "0 0 " + w + " " + h
            })

            var force = d3.layout.force()
                    .nodes(dataset.nodes)
                    .links(dataset.edges)
                    .size([w, h])
                    .linkDistance([linkDistance])
                    .charge([-900])
                    .theta(0.1)
                    .gravity(0.05)
                    .start();

            var edges = svg.selectAll("line")
                    .data(dataset.edges)
                    .enter()
                    .append("line")
                    .attr("id", function (d, i) {
                        return 'edge' + i
                    })
                    .attr('marker-end', 'url(#arrowhead)')
                    .style("stroke", "#ccc")
                    .style("pointer-events", "none");

            var nodes = svg.selectAll("circle")
                    .data(dataset.nodes)
                    .enter()
                    .append("circle")
                    .attr({"r": 35})
                    .style("fill", function (d, i) {
                        return d3.hsl(360 * b_crc32(d.tag) / Math.pow(2, 32), 1, 0.75)
                    })
                    .call(force.drag)

            var nodeHashtag = svg.selectAll(".node-hashtag")
                    .data(dataset.nodes)
                    .enter()
                    .append("text")
                    .attr({x: function (d) {
                            return d.x;
                        },
                        y: function (d) {
                            return d.y;
                        },
                        class: "node-hashtag",
                        dy: '-1.3em'
                    })
                    .text(function (d) {
                        return d.tag;
                    });

            var nodelabels = svg.selectAll(".nodelabel")
                    .data(dataset.nodes)
                    .enter()
                    .append("text")
                    .attr({"x": function (d) {
                            return d.x;
                        },
                        "y": function (d) {
                            return d.y;
                        },
                        "class": "nodelabel"
                    })
                    .text(function (d) {
                        return d.name;
                    });

            svg.selectAll('.nodelabel')
                    .call(wrap, textWidth)

            svg.append('defs').append('marker')
                    .attr({'id': 'arrowhead',
                        'viewBox': '-0 -5 10 10',
                        'refX': 45,
                        'refY': 0,
                        //'markerUnits':'strokeWidth',
                        'orient': 'auto',
                        'markerWidth': 10,
                        'markerHeight': 10,
                        'xoverflow': 'visible'})
                    .append('svg:path')
                    .attr('d', 'M 0,-5 L 10 ,0 L 0,5')
                    .attr('fill', '#ccc')
                    .attr('stroke', '#ccc');


            force.on("tick", function () {

                edges.attr({"x1": function (d) {
                        return d.source.x;
                    },
                    "y1": function (d) {
                        return d.source.y;
                    },
                    "x2": function (d) {
                        return d.target.x;
                    },
                    "y2": function (d) {
                        return d.target.y;
                    }
                });

                nodes.attr({"cx": function (d) {
                        return d.x;
                    },
                    "cy": function (d) {
                        return d.y;
                    }
                });

                nodelabels
                        .attr("x", function (d) {
                            return d.x;
                        })
                        .attr("y", function (d) {
                            return d.y;
                        })
                        .selectAll('tspan')
                        .each(function (d) {
                            var t = d3.select(this)
                            t.attr('x', d.x)
                            t.attr('y', d.y)
                        })

                nodeHashtag.attr("x", function (d) {
                    return d.x;
                })
                        .attr("y", function (d) {
                            return d.y;
                        })
            })
        })
    </script>
</digraph>
