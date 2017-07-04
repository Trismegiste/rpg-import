<vertex-detail id="selected">
    <article>
        <header class="pure-g">
            <div class="pure-u-3-4">
                <mark class="hashtag">{vertex.hashtag}</mark>
            </div>
            <div class="pure-u-1-6">
                <a if="{ isOrphan(vertex) }" onclick="{
                            onDelete
                        }"><i class="icon-cancel-squared"></i></a>
            </div>
            <div class="pure-u-1-12">
                <a href="#" onclick="{
                            onEdit
                        }"><i class="icon-pencil"></i></a>
            </div>
        </header>
        <div class="pure-g" if="{ !isEditing }">
            <div class="pure-u-1">
                <hashtag-decorator str="{vertex.sentence}" inner="{ vertex.pk }"></hashtag-decorator>
            </div>
        </div>
        <div class="pure-g" if="{ isEditing }">
            <div class="pure-u-1">
                <form class="pure-form" onsubmit="{
                            onSubmit
                        }">
                    <textarea class="pure-input-1" name="sentence" rows="3">{ vertex.sentence }</textarea>
                    <div class="pure-g">
                        <div class="pure-u-1-2">
                            <button class="pure-button pure-input-1" onclick="{
                                        onCancel
                                    }">Annuler</button>
                        </div>
                        <div class="pure-u-1-2">
                            <button class="pure-button pure-input-1 button-primary" onclick="{
                                        onSubmit
                                    }">Modifier</button>
                        </div>
                    </div>
                </form>
            </div>
        </div>
        <outer-edge></outer-edge>
        <inner-edge></inner-edge>
    </article>

    <script>
        var self = this
        this.isEditing = false

        this.isOrphan = function (v) {
            return RpgImpro.document.isOrphan(v)
        }

        this.onDelete = function () {
            RpgImpro.document.remove(self.vertex)
        }

        this.onEdit = function () {
            self.isEditing = true
        }

        this.onCancel = function () {
            self.isEditing = false
        }

        this.onSubmit = function () {
            self.vertex.sentence = self.sentence.value
            self.isEditing = false
        }

        //
        // CONFIG
        //
        this.on('mount', function () {
            var Textarea = Textcomplete.editors.Textarea
            var editor, tc, textAreaElem = self.sentence

            editor = new Textarea(textAreaElem)
            tc = new Textcomplete(editor)

            tc.register([
                {
                    match: /(^|\s)#([^\s]+)$/,
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
                }
            ])

        })


    </script>
</vertex-detail>