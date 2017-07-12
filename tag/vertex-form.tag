<vertex-form>
    <form id="create-form" class="pure-form" onsubmit="return false" onchange="{
                onChange
            }">
        <textarea placeholder="Hashtag" id="hashtag" name="hashtag" class="pure-input-1" rows="1">{ model.hashtag }</textarea>
        <textarea name="sentence" id="sentence" class="pure-input-1" rows="3" placeholder="Relation">{ model.sentence }</textarea>
        <div class="pure-g">
            <div class="pure-u-1-2">
                <button class="pure-button pure-input-1" onclick="{
                            onCancel
                        }">Annuler</button>
            </div>
            <div class="pure-u-1-2">
                <button class="pure-button pure-input-1 button-primary" onclick="{
                            onCreate
                        }">Ajouter</button>
            </div>
        </div>
    </form>
    <script>
        var self = this
        this.model = {
            hashtag: '',
            sentence: '',
            inner: null,
            outer: null
        }

        this.resetModel = function () {
            self.model.hashtag = ''
            self.model.sentence = ''
            self.model.inner = null
            self.model.outer = null
        }

        this.onCreate = function () {
            // validation
            if (!self.model.hashtag.length || !self.model.sentence.length) {
                return;
            }

            var newPk = RpgImpro.document.addUniqueVertex(self.model.hashtag, self.model.sentence)
            // edges
            if (self.model.inner && newPk) {
                RpgImpro.document.addEdge(self.model.inner, newPk)
            }
            if (self.model.outer && newPk) {
                RpgImpro.document.addEdge(newPk, self.model.outer)
            }
            // repository (@todo useless ?)
            RpgImpro.repository.addUniqueVertex(self.model.hashtag, self.model.sentence)
            RpgImpro.document.trigger('update')

            self.resetModel()
            self.parent.viewForm = false
            self.parent.update()
            scrollToElement('selected')
        }

        this.onChange = function () {
            self.model.hashtag = self.hashtag.value.trim().toLowerCase()
            self.model.sentence = self.sentence.value.trim()
        }

        RpgImpro.document.on('create-from-hashtag', function (hashtag, innerVertex) {
            self.parent.viewForm = true
            self.model.hashtag = hashtag
            self.model.inner = innerVertex
            self.parent.update()
            scrollToElement('create-form')
            self.sentence.focus()
        })

        RpgImpro.document.on('create-from-link', function (innerVertex) {
            self.parent.viewForm = true
            self.model.inner = innerVertex
            self.parent.update()
            scrollToElement('create-form')
            self.hashtag.focus()
        })

        RpgImpro.document.on('create-from-outer', function (outerVertex) {
            self.parent.viewForm = true
            self.model.outer = outerVertex
            self.parent.update()
            scrollToElement('create-form')
            self.hashtag.focus()
        })

        this.onCancel = function () {
            self.parent.viewForm = false
            self.resetModel()
            self.parent.update()
            scrollToElement('selected')
        }

        //
        // CONFIG
        //
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
                            if ((v.hashtag.search(new RegExp(term, 'i')) !== -1) && (found.indexOf(v.hashtag) === -1)) {
                                found.push(v.hashtag)
                            }
                        }

                        callback(found)
                    },
                    replace: function (value) {
                        return value + ' '
                    }
                }
            ])

            tc[1].register([
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
                },
                {
                    match: /(^)([^\s]+)$/,
                    search: function (term, callback) {
                        var repo = RpgImpro.repository.vertex
                        var filter = self.model.hashtag

                        var found = []
                        for (var k in repo) {
                            var v = repo[k]
                            if (filter.length && (v.hashtag !== filter)) {
                                continue
                            }
                            if ((v.sentence.search(term) !== -1) && (found.indexOf(v.sentence) === -1)) {
                                found.push(v)
                            }
                        }

                        callback(found)
                    },
                    template: function (obj) {
                        return obj.sentence
                    },
                    replace: function (obj) {
                        self.model.hashtag = obj.hashtag
                        self.update()
                        return obj.sentence + ' '
                    }
                }
            ])

        })

    </script>
</vertex-form>