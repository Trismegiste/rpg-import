function init() {return ;
    var doc = RpgImpro.document
    var nb = 100;
    var sentence = ['tata', 'toto', 'yoyo']

    for (var k = 0; k < nb; k++) {
        var h = ''
        for (var s = 0; s < 8; s++) {
            h += String.fromCharCode(97 + Math.random() * 26)
        }
        doc.addVertex(h, sentence[Math.floor(Math.random() * 3)])
    }

    for (var k = 0; k < nb; k++) {
        var src = doc.vertex[Math.floor(Math.random() * nb)]
        var tgt = doc.vertex[Math.floor(Math.random() * nb)]
        doc.addEdge(src.pk, tgt.pk)
    }

    RpgImpro.repository.vertex = [
        {
            hashtag: 'arme',
            sentence: 'épée'
        },
        {
            hashtag: 'arme',
            sentence: 'flingue'
        },
        {
            hashtag: 'artefact',
            sentence: 'anneau'
        }
    ]
}