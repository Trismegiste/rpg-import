function init() {
    RpgImpro.document.vertex = [
        {
            pk: 1,
            hashtag: 'scenario',
            sentence: "#templier veut tuer #nephilim"
        },
        {
            pk: 2,
            hashtag: 'templier',
            sentence: "Manteau noir"
        },
        {
            pk: 3,
            hashtag: 'nephilim',
            sentence: "un pj"
        }
    ]

    RpgImpro.document.edge = [
        {source: 1, target: 2},
        {source: 1, target: 3}
    ]
}