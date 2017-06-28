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
                dropdown: {
                    placement: 'top'
                }
            })
            tc.register([{
                    match: /(^|\s)#(\w+)$/,
                    search: function (term, callback) {
                        callback(['aaa', 'bbb'])
                    },
                    replace: function (value) {
                        return '$1#' + value + ' '
                    }
                }])
        })

    </script>
</vertex-form>