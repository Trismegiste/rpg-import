<outer-edge>
    <div class="pure-g">
        <div class="pure-u-1-5"></div>
        <div class="pure-u-4-5">
            <div class="pure-g edges-outer">
                <div class="pure-u-11-12">
                    <i class="icon-outer"></i>
                </div>
                <div class="pure-u-1-12">
                    <a onclick="{
                                onAddOuter
                            }"><i class="icon-plus-squared"></i></a>
                </div>
                <virtual each="{ RpgImpro.document.getVertexBySource(vertex.pk) }">
                    <div class="pure-u-11-12 edge">
                        <a href="#show/{pk}" class="hashtag">{ hashtag }</a>
                        {sentence}
                    </div>
                    <div class="pure-u-1-12">
                        <a onclick="{
                                    parent.onRemoveEdge
                                }"><i class="icon-cancel-squared"></i></a>
                    </div>
                </virtual>
                <div class="pure-u-1" if="{ viewOuter }">
                    <form class="pure-form" onsubmit="return false">
                        <textarea name="outer" rows="1" class="pure-input-1"></textarea>
                    </form>
                </div>
            </div>
        </div>
    </div>
    <script>
        var self = this
        this.viewOuter = false

        this.onAddOuter = function () {
            self.viewOuter = !self.viewOuter
        }

        this.onRemoveEdge = function (e) {
            RpgImpro.document.cutEdge(self.vertex.pk, e.item.pk)
        }

        this.on('mount', function () {
            var Textarea = Textcomplete.editors.Textarea

            var editor, tc;

            editor = new Textarea(self.outer)
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
                var pk = self.outer.value
                self.outer.value = ''
                self.viewOuter = false
                RpgImpro.document.addEdge(self.vertex.pk, pk)
                self.update()
            })

        })

    </script>
</outer-edge>