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
                <a href="#"><i class="icon-pencil"></i></a>
            </div>
        </header>
        <div class="pure-g">
            <div class="pure-u-11-12">
                <hashtag-decorator str="{vertex.sentence}" inner="{ vertex.pk }"></hashtag-decorator>
            </div>
            <div class="pure-u-1-12">
                <a href="#"><i class="icon-pencil"></i></a>
            </div>
        </div>
        <!-- outer -->
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
        <!-- inner -->
        <div class="pure-g">
            <div class="pure-u-1-5"></div>
            <div class="pure-u-4-5">
                <div class="pure-g edges-inner">
                    <div class="pure-u-11-12">
                        <i class="icon-inner"></i>
                    </div>
                    <div class="pure-u-1-12">
                        <a onclick="{
                                    onAddInner
                                }"><i class="icon-plus-squared"></i></a>
                    </div>
                    <div class="pure-u-1 edge">
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
            </div>
        </div>
    </article>
    <script>
        var self = this
        this.viewOuter = false
        this.viewInner = false

        this.onAddOuter = function () {
            self.viewOuter = !self.viewOuter
        }

        this.onAddInner = function () {
            self.viewInner = !self.viewInner
        }

        this.isOrphan = function (v) {
            return RpgImpro.document.isOrphan(v)
        }

        this.onDelete = function () {
            RpgImpro.document.remove(self.vertex)
        }

        this.onRemoveEdge = function (e) {
            RpgImpro.document.cutEdge(self.vertex.pk, e.item.pk)
        }

        this.on('mount', function () {
            var Textarea = Textcomplete.editors.Textarea
            var elem = [self.outer, self.inner]
            var editor = [], tc = []

            for (var k in elem) {
                var textAreaElem = elem[k]

                editor[k] = new Textarea(textAreaElem)
                tc[k] = new Textcomplete(editor[k], {
                    dropdown: Infinity
                })

                tc[k].register([
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
            }

            tc[0].on('selected', function () {
                var pk = self.outer.value
                self.outer.value = ''
                self.viewOuter = false
                RpgImpro.document.addEdge(self.vertex.pk, pk)
                self.update()
            })

            tc[1].on('selected', function () {
                var pk = self.inner.value
                self.inner.value = ''
                self.viewInner = false
                RpgImpro.document.addEdge(pk, self.vertex.pk)
                self.update()
            })
        })

    </script>
</vertex-detail>