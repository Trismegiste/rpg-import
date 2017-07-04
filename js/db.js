function init() {
    for (var k = 0; k < 100; k++) {
        var h = ''
        for (var s = 0; s < 8; s++) {
            h += String.fromCharCode(97 + Math.random() * 26)
        }
        RpgImpro.document.addVertex(h, 'toto')
    }



    RpgImpro.document.edge = [
        {source: '1', target: '2'},
        {source: '1', target: '3'},
        {source: '2', target: '4'}
    ]

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