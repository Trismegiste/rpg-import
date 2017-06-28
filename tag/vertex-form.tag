<vertex-form>
    <form class="pure-form">
        <input type="text" placeholder="Hashtag" name="hashtag" class="pure-input-1"/>
        <textarea name="sentence" id="sentence" class="pure-input-1" rows="3"></textarea>
    </form>
    <script>
        this.on('mount', function () {
            var Textarea = Textcomplete.editors.Textarea
            var textAreaElem = document.getElementById('sentence')
            var editor = new Textarea(textAreaElem)
            var tc = new Textcomplete(editor, {
                dropdown: Infinity
            })
            tc.register([
                {
                    match: /(^|\s)#(\w+)$/,
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
                    match: /(^)(\w+)$/,
                    search: function (term, callback) {
                        console.log(term)
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