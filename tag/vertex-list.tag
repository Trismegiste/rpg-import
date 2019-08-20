<vertex-list>
    <div class="pure-g search-bar">
        <div class="pure-u-1-12"><i class="icon-search"></i></div>
        <div class="pure-u-1-2">
            <form class="pure-form" onkeyup="{
                        onSearch
                    }" onsubmit="{
                                noSubmit
                            }">
                <input type="text" class="pure-input-1" name="search" value="{ keyword }" autocomplete="off" placeholder="Search..." />
            </form>
        </div>
        <div class="pure-u-1-12"><a onclick="{
                    onReset
                }"><i class="icon-cancel-squared"></i></a></div>
        <div class="pure-u-1-6"><a onclick="{
                    onCreate
                }"><i class="icon-plus-squared"></i></a></div>
        <div class="pure-u-1-6"><a onclick="{
                    onGDrive
                }"><i class="icon-google-drive-logo"></i></a></div>
    </div>
    <form class="pure-form pure-g" onchange="{
                onChangeColor
            }">
        <div class="pure-u-1-3">
            <label>
                <input type="radio" name="scheme" value="white"
                       checked="{ colorScheme == 'white' }"/>
                White
            </label>
        </div>
        <div class="pure-u-1-3">
            <label>
                <input type="radio" name="scheme" value="tag"
                       checked="{ colorScheme == 'tag' }"/>
                Tag
            </label>
        </div>
        <div class="pure-u-1-3">
            <label>
                <input type="radio" name="scheme" value="distance"
                       checked="{ colorScheme == 'distance' }"/>
                Distance
            </label>
        </div>
    </form>
    <div class="pure-g">
        <div class="vertex pure-u-1 pure-u-md-1-2 pure-u-lg-1-3 pure-u-xl-1-4" 
             each="{ vertex in found }" 
             style="background-color: {getLinkedVertexClass(vertex)}">
            <div if="{vertex.pk != selected}">
                <vertex></vertex>
            </div>
            <div if="{vertex.pk == selected}">
                <vertex-detail></vertex-detail>
            </div>
        </div>
    </div>
    <script>
        this.selected = 0
        this.keyword = ''
        this.found = RpgImpro.document.getVertex()
        this.colorScheme = 'white'
        this.colorSchemeChoice = []
        this.vertexColor = {}
        var self = this

        RpgImpro.document.on('update', function () {
            self.update()
        })

        this.noSubmit = function () {
            // to make the virtual keyboard disappeard on mobile
            self.search.blur()
            self.onSearch()
        }

        this.onReset = function () {
            this.keyword = ''
        }

        this.onCreate = function () {
            self.parent.trigger('add-vertex')
        }

        this.onGDrive = function () {
            self.parent.trigger('toggle-cloud')
        }

        this.on('update', function () {
            var srch = self.keyword.trim()
            var model = RpgImpro.document.getVertex()

            if (srch.length === 0) {
                self.found = model
                return
            }

            if (srch.length < 2) {
                return
            }

            var regex = new RegExp(srch, 'i')
            self.found = []
            for (var k in model) {
                var v = model[k]
                if (regex.test(v.hashtag) || regex.test(v.sentence)) {
                    self.found.push(v)
                }
            }
        })

        // search
        this.onSearch = function () {
            self.keyword = self.search.value
        }

        riot.route('/search/*', function (keyword) {
            self.keyword = keyword
            self.update()
        })

        riot.route('/show/*', function (pk) {
            self.selected = pk
            self.update()
            scrollToElement('selected')
        })

        this.getLinkedVertexClass = function (v) {
            switch (self.colorScheme) {
                case 'white':
                    return 'white'
                case 'tag':
                    return d3.hsl(360 * b_crc32(v.hashtag) / Math.pow(2, 32), 1, 0.9)
                case 'distance':
                    return self.vertexColor.hasOwnProperty(v.pk) ? self.vertexColor[v.pk] : 'white'
            }
        }

        this.onChangeColor = function (e) {
            // manage radio
            self.scheme.forEach(function (radio) {
                if (radio.checked) {
                    self.colorScheme = radio.value
                }
            })
            // action
            if (self.colorScheme === 'distance') {
                self.vertexColor = {}
                if (self.select === 0)
                    return
                var vertices = RpgImpro.document.getVertexBySource(self.selected)
                for (var idx in vertices) {
                    self.vertexColor[vertices[idx].pk] = 'green'
                }
                vertices = RpgImpro.document.getVertexByTarget(self.selected)
                for (var idx in vertices) {
                    self.vertexColor[vertices[idx].pk] = 'yellow'
                }
                console.log(self.vertexColor)
            }
        }

    </script>
</vertex-list>