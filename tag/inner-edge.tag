<inner-edge>
    <div class="pure-g edges-inner">
        <div class="pure-u-11-12">
            <i class="icon-inner"></i>
        </div>
        <div class="pure-u-1-12">
            <a onclick="{
                        onAddInner
                    }"><i class="icon-plus-squared"></i></a>
        </div>
        <div class="pure-u-1">
            <ul>
                <li each="{ RpgImpro.document.getVertexByTarget(vertex.pk) }">
                    <a href="#show/{pk}" class="hashtag">{ hashtag }</a>
                </li>
            </ul>
        </div>
        <div class="pure-u-1" if="{ viewInner }">
            <form class="pure-form" onsubmit="return false">
                <textarea name="inner" rows="1" class="pure-input-1"></textarea>
            </form>
        </div>
    </div>

    <script>
        var self = this
        this.viewInner = false

        this.onAddInner = function () {
            self.viewInner = !self.viewInner
            if (self.viewInner) {
                self.update()
                self.inner.focus()
            }
        }

        this.on('mount', function () {
            var Textarea = Textcomplete.editors.Textarea
            var editor, tc;

            var textAreaElem = self.inner

            editor = new Textarea(textAreaElem)
            tc = new Textcomplete(editor)

            tc.register([
                {
                    match: /(^)([^\s]+)$/,
                    search: function (term, callback) {
                        var repo = RpgImpro.document.getVertex()
                        var found = []
                        for (var k in repo) {
                            var v = repo[k]
                            if (v.sentence.search(new RegExp(term, 'i')) !== -1) {
                                found.push(v)
                            }
                        }

                        callback(found)
                    },
                    template: function (obj) {
                        return '#' + obj.hashtag + ' ' + obj.sentence
                    },
                    replace: function (value) {
                        return value.pk
                    }
                }
            ])

            tc.on('selected', function () {
                var pk = self.inner.value
                self.inner.value = ''
                self.viewInner = false
                RpgImpro.document.addEdge(pk, self.vertex.pk)
                self.update()
            })
        })
    </script>
</inner-edge>