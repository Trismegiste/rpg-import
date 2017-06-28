<vertex-form>
    <form class="pure-form">
        <input type="text" placeholder="Hashtag" id="hashtag" name="hashtag" class="pure-input-1"/>
        <textarea name="sentence" id="sentence" class="pure-input-1" rows="3"></textarea>
    </form>
    <script>
        this.on('mount', function () {
            var Textarea = Textcomplete.editors.Textarea
            var autocompleted = ["hashtag", 'sentence']
            var editor = [], tc = []

            for (var k in autocompleted) {
                var key = autocompleted[k]
                var textAreaElem = document.getElementById(key)
                editor[k] = new Textarea(textAreaElem)
                tc[k] = new Textcomplete(editor[k], {
                    dropdown: Infinity
                })
            }

            tc[0].register([
                {
                    match: /(^)([^\s]+)$/,
                    search: function (term, callback) {
                        var repo = RpgImpro.repository.vertex
                        var found = []
                        for (var k in repo) {
                            var v = repo[k]
                            if ((v.hashtag.search(term) !== -1) && (found.indexOf(v.hashtag) === -1)) {
                                found.push(v.hashtag)
                            }
                        }

                        callback(found)
                    },
                    replace: function (value) {
                        return value
                    }
                }
            ])

            tc[1].register([
                {
                    match: /(^|\s)#(éèêëàâäîïùûüôöç-\w+)$/,
                    search: function (term, callback) {
                        var repo = RpgImpro.repository.vertex
                        var found = []
                        for (var k in repo) {
                            var v = repo[k]
                            if ((v.hashtag.search(term) !== -1) && (found.indexOf(v.hashtag) === -1)) {
                                found.push(v.hashtag)
                            }
                        }

                        callback(found)
                    },
                    replace: function (value) {
                        return '$1#' + value + ' '
                    }
                },
                {
                    match: /(^)([éèêëàâäîïùûüôöç-\w]+)$/,
                            search: function (term, callback) {
                                var repo = RpgImpro.repository.vertex
                                var found = []
                                for (var k in repo) {
                                    var v = repo[k]
                                    if ((v.sentence.search(term) !== -1) && (found.indexOf(v.sentence) === -1)) {
                                        found.push(v.sentence)
                                    }
                                }

                                callback(found)
                            },
                    replace: function (value) {
                        return value
                    }
                }
            ])


        })

    </script>
</vertex-form>