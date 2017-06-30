<vertex-list>
    <div class="pure-g search-bar">
        <div class="pure-u-1-12"><i class="icon-search"></i></div>
        <div class="pure-u-1-2">
            <form class="pure-form" onkeyup="{
                        onSearch
                    }" onsubmit="{
                                noSubmit
                            }">
                <input type="text" class="pure-input-1" name="search" value="{ keyword }" autocomplete="off"/>
            </form>
        </div>
        <div class="pure-u-1-12"><i class="icon-cancel-squared"></i></div>
        <div class="pure-u-1-6"><a onclick="{
                    onCreate
                }"><i class="icon-plus-squared"></i></a></div>
        <div class="pure-u-1-6"><i class="icon-google-drive-logo"></i></div>
    </div>
    <div class="pure-g listing">
        <section class="pure-u-1" each="{ vertex in found }">
            <virtual if="{vertex.pk != selected}">
                <vertex></vertex>
            </virtual>
            <virtual if="{vertex.pk == selected}">
                <vertex-detail></vertex-detail>
            </virtual>
        </section>
    </div>
    <script>
        this.selected = 0 // by default, first entry on the list
        this.keyword = ''
        this.found = RpgImpro.document.getVertex()
        var self = this

        RpgImpro.document.on('update', function () {
            self.update()
        })

        this.noSubmit = function () {
            // to make the virtual keyboard disappeard on mobile
            self.search.blur()
            self.onSearch()
        }

        this.onCreate = function () {
            self.parent.viewForm = true
            self.parent.update()
        }

        this.on('update', function () {
            var regex = new RegExp(self.keyword.trim(), 'i')
            var model = RpgImpro.document.getVertex()
            self.found = []
            for (var k in model) {
                var v = model[k]
                if (regex.test('#' + v.hashtag + ' ' + v.sentence)) {
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
            var obj = document.getElementById('selected')
            if (obj) {
                window.scrollTo(0, obj.offsetTop)
            }
        })

    </script>
</vertex-list>