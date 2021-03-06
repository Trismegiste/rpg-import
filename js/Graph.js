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

Graph.prototype.hasVertex = function (hashtag, sentence) {
    for (var k in this.vertex) {
        var v = this.vertex[k]
        if ((v.hashtag === hashtag) && (v.sentence === sentence)) {
            return true
        }
    }

    return false
}

Graph.prototype.addVertex = function (hashtag, sentence) {
    var v = {hashtag: hashtag, sentence: sentence}
    v.pk = hashCode(hashtag + sentence + Math.random())
    this.vertex.push(v)

    return v.pk
}

Graph.prototype.addUniqueVertex = function (hashtag, sentence) {
    if (!this.hasVertex(hashtag, sentence)) {
        return this.addVertex(hashtag, sentence)
    }
}

Graph.prototype.getVertex = function () {
    return this.vertex
}

Graph.prototype.hasEdge = function (src, tgt) {
    for (var k in this.edge) {
        if ((this.edge[k].source === src) && (this.edge[k].target === tgt)) {
            return true
        }
    }

    return false
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

/**
 * Add an edge
 *
 * @param string source primary key
 * @param string target primary key
 */
Graph.prototype.addEdge = function (source, target) {
    if (source === target) {
        return
    }
    
    if (this.hasEdge(source, target)) {
        return
    }

    if (undefined === this.findVertexByPk(source)) {
        throw new Error(source + " is unknown source")
    }

    if (undefined === this.findVertexByPk(target)) {
        throw new Error(target + " is unknown target")
    }

    this.edge.push({source: source, target: target})
}

Graph.prototype.isSource = function (v) {
    for (var k in this.edge) {
        if (this.edge[k].target === v.pk) {
            return false
        }
    }

    return true
}

Graph.prototype.isSink = function (v) {
    for (var k in this.edge) {
        if (this.edge[k].source === v.pk) {
            return false
        }
    }

    return true
}

Graph.prototype.isOrphan = function (v) {
    for (var k in this.edge) {
        var e = this.edge[k]
        if ((e.source === v.pk) || (e.target === v.pk)) {
            return false
        }
    }

    return true
}

Graph.prototype.remove = function (v) {
    for (var k in this.edge) {
        var e = this.edge[k]
        if ((e.source === v.pk) || (e.target === v.pk)) {
            this.edge.splice(k, 1)
        }
    }
    // delete
    for (var k in this.vertex) {
        if (this.vertex[k].pk === v.pk) {
            this.vertex.splice(k, 1)
        }
    }
}

Graph.prototype.cutEdge = function (src, tgt) {
    for (var k in this.edge) {
        var e = this.edge[k]
        if ((e.source === src) && (e.target === tgt)) {
            this.edge.splice(k, 1)
        }
    }
}

Graph.prototype.export = function () {
    console.log(this)
}

Graph.prototype.import = function (json) {
    this.edge = json.edge
    this.vertex = json.vertex
}