/*
 * A digraph
 */
Graph = function () {
    this.vertex = []  // {pk:NN, hashtag:'wesh', sentence:'yo #mama'}
    this.edge = []
}

Graph.prototype.findVertexByPk = function (pk) {
    for (var k in this.vertex) {
        if (this.vertex[k].pk === pk) {
            return this.vertex[k]
        }
    }
}

Graph.prototype.hasVertex = function (obj) {
    for (var k in this.vertex) {
        var v = this.vertex[k]
        if ((v.hashtag === obj.hashtag) && (v.sentence === obj.sentence)) {
            return true
        }
    }

    return false
}

Graph.prototype.addVertex = function (v) {
    var newPk = this.vertex.length
    v.pk = 'id-' + newPk + '-' + Math.random()
    this.vertex.push(v)
}

Graph.prototype.addUniqueVertex = function (v) {
    if (!this.hasVertex(v)) {
        this.addVertex(v)
    }
}

Graph.prototype.getVertex = function () {
    return this.vertex
}

Graph.prototype.getVertexBySource = function (pk) {
    var lst = []
    for (var k in this.edge) {

        if (this.edge[k].source === pk) {
            var v = this.findVertexByPk(this.edge[k].target)
            if (v) {
                lst.push(v)
            }
        }
    }

    return lst
}

Graph.prototype.getVertexByTarget = function (pk) {
    var lst = []
    for (var k in this.edge) {

        if (this.edge[k].target === pk) {
            var v = this.findVertexByPk(this.edge[k].source)
            if (v) {
                lst.push(v)
            }
        }
    }

    return lst
}