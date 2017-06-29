function init() {
    RpgImpro.document.vertex = [
        {
            pk: '1',
            hashtag: 'scenario',
            sentence: "#templier veut tuer #nephilim"
        },
        {
            pk: '2',
            hashtag: 'templier',
            sentence: "Manteau noir équipé #artefact"
        },
        {
            pk: '3',
            hashtag: 'nephilim',
            sentence: "un pj"
        },
        {
            pk: '4',
            hashtag: 'artefact',
            sentence: "anneau orichalque"
        }
    ]

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