<digraph>
    <script>

        function wrap(text, width) {
            text.each(function () {
                var text = d3.select(this),
                        words = text.text().split(/\s+/).reverse(),
                        word,
                        line = [],
                        lineNumber = 0,
                        lineHeight = 1.1, // ems
                        x = text.attr("x"),
                        y = text.attr("y"),
                        tspan = text.text(null).append("tspan").attr("x", x).attr("y", y)
                while (word = words.pop()) {
                    line.push(word);
                    tspan.text(line.join(" "));
                    if (tspan.node().getComputedTextLength() > width) {
                        line.pop();
                        tspan.text(line.join(" "));
                        line = [word];
                        tspan = text.append("tspan").attr("x", x).attr("y", y).attr("dy", ++lineNumber * lineHeight + "em").text(word);
                    }
                }
            });
        }

        var a_table = "00000000 77073096 EE0E612C 990951BA 076DC419 706AF48F E963A535 9E6495A3 0EDB8832 79DCB8A4 E0D5E91E 97D2D988 09B64C2B 7EB17CBD E7B82D07 90BF1D91 1DB71064 6AB020F2 F3B97148 84BE41DE 1ADAD47D 6DDDE4EB F4D4B551 83D385C7 136C9856 646BA8C0 FD62F97A 8A65C9EC 14015C4F 63066CD9 FA0F3D63 8D080DF5 3B6E20C8 4C69105E D56041E4 A2677172 3C03E4D1 4B04D447 D20D85FD A50AB56B 35B5A8FA 42B2986C DBBBC9D6 ACBCF940 32D86CE3 45DF5C75 DCD60DCF ABD13D59 26D930AC 51DE003A C8D75180 BFD06116 21B4F4B5 56B3C423 CFBA9599 B8BDA50F 2802B89E 5F058808 C60CD9B2 B10BE924 2F6F7C87 58684C11 C1611DAB B6662D3D 76DC4190 01DB7106 98D220BC EFD5102A 71B18589 06B6B51F 9FBFE4A5 E8B8D433 7807C9A2 0F00F934 9609A88E E10E9818 7F6A0DBB 086D3D2D 91646C97 E6635C01 6B6B51F4 1C6C6162 856530D8 F262004E 6C0695ED 1B01A57B 8208F4C1 F50FC457 65B0D9C6 12B7E950 8BBEB8EA FCB9887C 62DD1DDF 15DA2D49 8CD37CF3 FBD44C65 4DB26158 3AB551CE A3BC0074 D4BB30E2 4ADFA541 3DD895D7 A4D1C46D D3D6F4FB 4369E96A 346ED9FC AD678846 DA60B8D0 44042D73 33031DE5 AA0A4C5F DD0D7CC9 5005713C 270241AA BE0B1010 C90C2086 5768B525 206F85B3 B966D409 CE61E49F 5EDEF90E 29D9C998 B0D09822 C7D7A8B4 59B33D17 2EB40D81 B7BD5C3B C0BA6CAD EDB88320 9ABFB3B6 03B6E20C 74B1D29A EAD54739 9DD277AF 04DB2615 73DC1683 E3630B12 94643B84 0D6D6A3E 7A6A5AA8 E40ECF0B 9309FF9D 0A00AE27 7D079EB1 F00F9344 8708A3D2 1E01F268 6906C2FE F762575D 806567CB 196C3671 6E6B06E7 FED41B76 89D32BE0 10DA7A5A 67DD4ACC F9B9DF6F 8EBEEFF9 17B7BE43 60B08ED5 D6D6A3E8 A1D1937E 38D8C2C4 4FDFF252 D1BB67F1 A6BC5767 3FB506DD 48B2364B D80D2BDA AF0A1B4C 36034AF6 41047A60 DF60EFC3 A867DF55 316E8EEF 4669BE79 CB61B38C BC66831A 256FD2A0 5268E236 CC0C7795 BB0B4703 220216B9 5505262F C5BA3BBE B2BD0B28 2BB45A92 5CB36A04 C2D7FFA7 B5D0CF31 2CD99E8B 5BDEAE1D 9B64C2B0 EC63F226 756AA39C 026D930A 9C0906A9 EB0E363F 72076785 05005713 95BF4A82 E2B87A14 7BB12BAE 0CB61B38 92D28E9B E5D5BE0D 7CDCEFB7 0BDBDF21 86D3D2D4 F1D4E242 68DDB3F8 1FDA836E 81BE16CD F6B9265B 6FB077E1 18B74777 88085AE6 FF0F6A70 66063BCA 11010B5C 8F659EFF F862AE69 616BFFD3 166CCF45 A00AE278 D70DD2EE 4E048354 3903B3C2 A7672661 D06016F7 4969474D 3E6E77DB AED16A4A D9D65ADC 40DF0B66 37D83BF0 A9BCAE53 DEBB9EC5 47B2CF7F 30B5FFE9 BDBDF21C CABAC28A 53B39330 24B4A3A6 BAD03605 CDD70693 54DE5729 23D967BF B3667A2E C4614AB8 5D681B02 2A6F2B94 B40BBE37 C30C8EA1 5A05DF1B 2D02EF8D";
        var b_table = a_table.split(' ').map(function (s) {
            return parseInt(s, 16)
        });
        function b_crc32(str) {
            var crc = -1;
            for (var i = 0, iTop = str.length; i < iTop; i++) {
                crc = (crc >>> 8) ^ b_table[(crc ^ str.charCodeAt(i)) & 0xFF];
            }
            return (crc ^ (-1)) >>> 0;
        }

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
                    .charge([-500])
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

            var edgepaths = svg.selectAll(".edgepath")
                    .data(dataset.edges)
                    .enter()
                    .append('path')
                    .attr({'d': function (d) {
                            return 'M ' + d.source.x + ' ' + d.source.y + ' L ' + d.target.x + ' ' + d.target.y
                        },
                        'class': 'edgepath',
                        'fill-opacity': 0,
                        'stroke-opacity': 0,
                        'fill': 'blue',
                        'stroke': 'red',
                        'id': function (d, i) {
                            return 'edgepath' + i
                        }})
                    .style("pointer-events", "none");

            var edgelabels = svg.selectAll(".edgelabel")
                    .data(dataset.edges)
                    .enter()
                    .append('text')
                    .style("pointer-events", "none")
                    .attr({'class': 'edgelabel',
                        'id': function (d, i) {
                            return 'edgelabel' + i
                        },
                        'dx': 80,
                        'dy': 0,
                        'font-size': 10,
                        'fill': '#aaa'});

            edgelabels.append('textPath')
                    .attr('xlink:href', function (d, i) {
                        return '#edgepath' + i
                    })
                    .style("pointer-events", "none")
                    .text(function (d, i) {
                        return d.target.tag
                    });


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
                            //console.log(this, d)
                            var t = d3.select(this)
                            t.attr('x', d.x)
                            t.attr('y', d.y)
                        })


                edgepaths.attr('d', function (d) {
                    var path = 'M ' + d.source.x + ' ' + d.source.y + ' L ' + d.target.x + ' ' + d.target.y;
                    //console.log(d)
                    return path
                });

                edgelabels.attr('transform', function (d, i) {
                    if (d.target.x < d.source.x) {
                        bbox = this.getBBox();
                        rx = bbox.x + bbox.width / 2;
                        ry = bbox.y + bbox.height / 2;
                        return 'rotate(180 ' + rx + ' ' + ry + ')';
                    }
                    else {
                        return 'rotate(0)';
                    }
                });
            })
        })
    </script>
</digraph>
